import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class IAP {

  static final IAP instance = IAP._internal();
  factory IAP() => instance;
  IAP._internal();

  final bool _kAutoConsume = true;

  static const String _kConsumableId = 'consumable';
  static const String _kUpgradeId = 'upgrade';
  static const String _kSilverSubscriptionId = 'subscription_silver';
  static const String _kGoldSubscriptionId = 'subscription_gold';
  static const List<String> _kProductIds = <String>[
    _kConsumableId,
    _kUpgradeId,
    _kSilverSubscriptionId,
    _kGoldSubscriptionId,
  ];

}