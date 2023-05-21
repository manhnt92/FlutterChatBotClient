import 'dart:async';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IOSPaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}

class ConsumableStore {
  static const String _kPrefKey = 'consumables';
  static Future<void> _writes = Future<void>.value();

  static Future<void> save(String id) {
    _writes = _writes.then((void _) => _doSave(id));
    return _writes;
  }

  static Future<void> consume(String id) {
    _writes = _writes.then((void _) => _doConsume(id));
    return _writes;
  }

  static Future<List<String>> load() async {
    return (await SharedPreferences.getInstance()).getStringList(_kPrefKey) ?? <String>[];
  }

  static Future<void> _doSave(String id) async {
    final List<String> cached = await load();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cached.add(id);
    await prefs.setStringList(_kPrefKey, cached);
  }

  static Future<void> _doConsume(String id) async {
    final List<String> cached = await load();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cached.remove(id);
    await prefs.setStringList(_kPrefKey, cached);
  }

}

class AppIAP {

  static final AppIAP instance = AppIAP._internal();
  factory AppIAP() => instance;
  AppIAP._internal();

  final bool _kAutoConsume = Utils.isIOS || true;

  static const String _kConsumableId = 'consumable';
  static const String _kUpgradeId = 'upgrade';
  static const String _kWeekSubscriptionId = 'subscription_week';
  static const String _kMonthSubscriptionId = 'subscription_month';
  static const List<String> _kProductIds = <String>[
    _kConsumableId,
    _kUpgradeId,
    _kWeekSubscriptionId,
    _kMonthSubscriptionId,
  ];

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  List<String> _consumables = <String>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  void init() {
    _subscription = _inAppPurchase.purchaseStream.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
      }, onDone: () {
        _subscription.cancel();
      }, onError: (Object error) {}
    );
    initStoreInfo();
  }

  void dispose() {
    if (Utils.isIOS) {
      final iosPlatformAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
  }

  void purchase(ProductDetails productDetails) {
    var purchases = Map<String, PurchaseDetails>.fromEntries(_purchases.map((PurchaseDetails purchase) {
        if (purchase.pendingCompletePurchase) {
          _inAppPurchase.completePurchase(purchase);
        }
        return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
      })
    );

    late PurchaseParam purchaseParam;
    if (Utils.isAndroid) {
      var oldSubscription = _getOldSubscription(productDetails, purchases);
      ChangeSubscriptionParam? changeParam;
      if (oldSubscription != null) {
        changeParam = ChangeSubscriptionParam(oldPurchaseDetails: oldSubscription, prorationMode: ProrationMode.immediateWithTimeProration);
      }
      purchaseParam = GooglePlayPurchaseParam(productDetails: productDetails, changeSubscriptionParam: changeParam);
    } else {
      purchaseParam = PurchaseParam(productDetails: productDetails);
    }
    if (productDetails.id == _kConsumableId) {
      _inAppPurchase.buyConsumable(purchaseParam: purchaseParam, autoConsume: _kAutoConsume);
    } else {
      _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    }
  }

  void restorePurchases() {
    _inAppPurchase.restorePurchases();
  }

  Future<void> consume(String id) async {
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _consumables = consumables;
    });
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await InAppPurchase.instance.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _notFoundIds = <String>[];
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }
    if (Utils.isIOS) {
      final iosPlatformAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(IOSPaymentQueueDelegate());
    }

    final productDetailResponse = await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      var status = purchaseDetails.status;
      if (status == PurchaseStatus.pending) {
        setState(() {
          _purchasePending = true;
        });
      } else {
        if (status == PurchaseStatus.error) {
          debugPrint("error : ${purchaseDetails.error!}");
          setState(() {
            _purchasePending = false;
          });
        } else if (status == PurchaseStatus.purchased || status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Utils.isAndroid) {
          if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
            var androidAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if (purchaseDetails.productID == _kConsumableId) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      final List<String> consumables = await ConsumableStore.load();
      _purchasePending = false;
      _consumables = consumables;
    } else {
      _purchases.add(purchaseDetails);
      _purchasePending = false;
    }
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  GooglePlayPurchaseDetails? _getOldSubscription(ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    GooglePlayPurchaseDetails? oldSubscription;
    if (productDetails.id == _kWeekSubscriptionId && purchases[_kMonthSubscriptionId] != null) {
      oldSubscription = purchases[_kMonthSubscriptionId]! as GooglePlayPurchaseDetails;
    } else if (productDetails.id == _kMonthSubscriptionId && purchases[_kWeekSubscriptionId] != null) {
      oldSubscription = purchases[_kWeekSubscriptionId]! as GooglePlayPurchaseDetails;
    }
    return oldSubscription;
  }

  void setState(VoidCallback func) {
    func();
  }

}