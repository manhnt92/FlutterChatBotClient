import "dart:math" show pi;
import 'package:chat_bot/screens/base.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/models/sub_data.dart';
import 'package:chat_bot/utils/app_navigator.dart';
import 'package:chat_bot/utils/app_style.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class PremiumScreen extends BaseStatefulWidget {

  const PremiumScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PremiumScreenState();

}

class _PremiumScreenState extends BaseState<PremiumScreen> {

  int _selectedIndex = 1;
  List<SubData> subs = [
    SubData(title: S.current.premium_week, price: S.current.premium_week_price, promotion: ''),
    SubData(title: S.current.premium_month, price: S.current.premium_month_price, promotion: S.current.premium_promotion("85")),
    SubData(title: S.current.premium_ads, price: S.current.premium_ads_price, promotion: '')
  ];
  RewardedAd? _rewardedAd;

  @override
  void initState() {
    super.initState();
    _loadRewardAd(show: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.premium_title),
        leading: InkWell(
          onTap: () { AppNavigator.goBack(); },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(height: 10),
              Text(S.current.premium_title_hint, textAlign: TextAlign.center, style: AppStyle.body1B),
              Text(S.current.premium_title_hint_1, textAlign: TextAlign.center, style: AppStyle.body2),
              Container(height: 10),
              Subscription(onTap: () => onSubscriptionSelected(1),
                  isSelected: _selectedIndex == 1, sub: subs[0]),
              Container(height: 10),
              Subscription(onTap: () => onSubscriptionSelected(2),
                  isSelected: _selectedIndex == 2, sub: subs[1]),
              Container(height: 10),
              Subscription(onTap: () => onSubscriptionSelected(3),
                  isSelected: _selectedIndex == 3, sub: subs[2]),
              const SubscriptionFeatures(),
              PlatformElevatedButton(
                onPressed: onSubscription,
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                child: Text(_getPurchaseBtString(), style: AppStyle.headline6B),
              ),
              Container(height: 10),
              Center(child: InkWell(
                  onTap: () { },
                  child: Text(S.current.setting_restore_purchase, style: AppStyle.body2.apply(decoration: TextDecoration.underline)))
              ),
              Container(height: 10),
              SubscriptionTerm(term: _getPurchaseBtString())
            ],
          ),
        ),
      ),
    );
  }

  String _getPurchaseBtString() {
    if (_selectedIndex == 1) {
      return S.current.premium_purchase_try_for_free;
    } else if (_selectedIndex == 2) {
      return S.current.premium_purchase;
    }
    return S.current.premium_purchase_ads;
  }

  void onSubscription() {
    if (_selectedIndex == 1) {

    } else if (_selectedIndex == 2) {

    } else {
      _showRewardAd();
    }
  }

  void onSubscriptionSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _loadRewardAd({bool show = true}) {
    var request = const AdRequest();
    RewardedAd.load(
        adUnitId: Utils.rewardAdUnitId,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad) {
              ad.fullScreenContentCallback = FullScreenContentCallback(
                  onAdShowedFullScreenContent: (ad) {},
                  onAdImpression: (ad) {},
                  onAdFailedToShowFullScreenContent: (ad, err) {
                    ad.dispose();
                    _rewardedAd = null;
                  },
                  onAdDismissedFullScreenContent: (ad) {
                    ad.dispose();
                    _rewardedAd = null;
                  },
                  onAdClicked: (ad) {}
              );
              debugPrint('$ad loaded.');
              _rewardedAd = ad;
              if (show) {
                _showRewardAd();
              }
            },
            onAdFailedToLoad: (LoadAdError error) {
              debugPrint('RewardedAd failed to load: $error');
              _rewardedAd = null;
            }
        )
    );
  }

  void _showRewardAd() {
    if (_rewardedAd == null) {
      _loadRewardAd();
    } else {
      _rewardedAd?.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {

          }
      );
    }
  }

}

class Subscription extends BaseStatelessWidget {

  final VoidCallback onTap;
  final bool isSelected;
  final SubData sub;

  const Subscription({Key? key, required this.onTap, required this.isSelected, required this.sub}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onTap: onTap,
      child: Material(
        elevation: 1.0,
        borderOnForeground: true,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: AppStyle.colorBorder(context, isSelected)),
            color: AppStyle.colorBgElevatedButton(context, isSelected),
            borderRadius: const BorderRadius.all(Radius.circular(15))
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(sub.title, style: AppStyle.body1B),
                      Text(sub.price, style: AppStyle.body2)
                    ]
                ),
              ),
              Visibility(
                visible: sub.promotion.isNotEmpty,
                child: Positioned(
                  top: 0.0, right: 0.0, child: Container(
                    decoration: ShapeDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomLeft: Radius.circular(15)))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                      child: Text(sub.promotion, style: AppStyle.body2.apply(color: Colors.white)),
                    ),
                    )
                  )
                ),
            ],
          ),
        ),
      ),
    );
  }

}

class SubscriptionFeatures extends BaseStatelessWidget {

  const SubscriptionFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _featureItem(const Icon(Icons.star), S.current.premium_feature_1, S.current.premium_feature_1_desc),
          Container(height: 5),
          _featureItem(const Icon(Icons.trending_up), S.current.premium_feature_2, S.current.premium_feature_2_desc),
          Container(height: 5),
          _featureItem(Image.asset("assets/images/ic_infinite.png"), S.current.premium_feature_3, S.current.premium_feature_3_desc),
          Container(height: 5),
          _featureItem(const Icon(Icons.not_interested), S.current.premium_feature_4, S.current.premium_feature_4_desc),
        ]
      ),
    );
  }

  Widget _featureItem(Widget icon, String title, String desc) {
    return Row(
      children: [
        icon,
        Container(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title, style: AppStyle.body2B),
              Text(desc, style: AppStyle.body2)
            ],
          ),
        )
      ],
    );
  }

}

class SubscriptionTerm extends BaseStatelessWidget {

  final String term;

  const SubscriptionTerm({super.key, required this.term});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(S.current.premium_purchase_term(term), style: AppStyle.body2),
        ),
        Container(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                onTap: () { AppNavigator.goToPrivacy(); },
                child: Text(S.current.setting_policy, style: AppStyle.body2.apply(decoration: TextDecoration.underline))),
            Container(width: 15),
            InkWell(
                onTap: () { AppNavigator.goToTerm(); },
                child: Text(S.current.setting_term, style: AppStyle.body2.apply(decoration: TextDecoration.underline)))
          ],
        ),
        Container(height: 10)
      ],
    );
  }

}