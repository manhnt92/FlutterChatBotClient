import 'dart:async';
import 'package:chat_bot/data/app_web_socket.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

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

class AppIAP with ChangeNotifier {

  final bool _kAutoConsume = Utils.isIOS || true;

  static const String kWeekSubscriptionId = 'weekly';
  static const String kYearSubscriptionId = 'yearly';
  static const List<String> _kProductIds = <String>[
    kWeekSubscriptionId,
    kYearSubscriptionId,
  ];

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> products = <ProductDetails>[];

  final List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  bool _purchasePending = false;

  void init() async {
    _subscription = _inAppPurchase.purchaseStream.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
      }, onDone: () {
        _subscription.cancel();
      }, onError: (Object error) {}
    );

    final bool isAvailable = await InAppPurchase.instance.isAvailable();
    debugPrint("store available: $isAvailable");
    if (!isAvailable) {
      return;
    }
    if (Utils.isIOS) {
      final iosPlatformAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(IOSPaymentQueueDelegate());
    }
    final productDetailResponse = await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    products = productDetailResponse.productDetails;
    if (productDetailResponse.error != null) {
      debugPrint("product detail response error: ${productDetailResponse.error!.message}");
    }
    if (productDetailResponse.notFoundIDs.isNotEmpty) {
      debugPrint("products not found: ${productDetailResponse.notFoundIDs}");
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (Utils.isIOS) {
      final iosPlatformAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        _purchasePending = true;
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          debugPrint("error : ${purchaseDetails.error!}");
          _purchasePending = false;
        } else if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {
          if (purchaseDetails.purchaseID != null) {
            AppWebSocket.instance.sendIAP(purchaseDetails.purchaseID!, purchaseDetails.productID);
          }
        }
        if (Utils.isAndroid) {
          if (!_kAutoConsume && _isConsumable(purchaseDetails.productID)) {
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


  void purchase(ProductDetails productDetails) {
    late PurchaseParam purchaseParam;
    if (Utils.isAndroid) {
      var oldSubscription = null;//_getOldSubscription(productDetails, purchases);//TODO oldSubscription
      ChangeSubscriptionParam? changeParam;
      if (oldSubscription != null) {
        changeParam = ChangeSubscriptionParam(oldPurchaseDetails: oldSubscription, prorationMode: ProrationMode.immediateWithTimeProration);
      }
      purchaseParam = GooglePlayPurchaseParam(productDetails: productDetails, changeSubscriptionParam: changeParam);
    } else {
      purchaseParam = PurchaseParam(productDetails: productDetails);
    }
    if (_isConsumable(productDetails.id)) {
      _inAppPurchase.buyConsumable(purchaseParam: purchaseParam, autoConsume: _kAutoConsume);
    } else {
      _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    }
  }

  void restorePurchases() {
    _inAppPurchase.restorePurchases();
  }

  GooglePlayPurchaseDetails? _getOldSubscription(ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    GooglePlayPurchaseDetails? oldSubscription;
    if (productDetails.id == kWeekSubscriptionId && purchases[kYearSubscriptionId] != null) {
      oldSubscription = purchases[kYearSubscriptionId]! as GooglePlayPurchaseDetails;
    } else if (productDetails.id == kYearSubscriptionId && purchases[kWeekSubscriptionId] != null) {
      oldSubscription = purchases[kWeekSubscriptionId]! as GooglePlayPurchaseDetails;
    }
    return oldSubscription;
  }

  bool _isConsumable(String productId) {
    if (productId == kWeekSubscriptionId || productId == kYearSubscriptionId) {
      return false;
    }
    return true;
  }

}