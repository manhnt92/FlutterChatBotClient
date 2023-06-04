import 'package:chat_bot/models/user.dart';
import 'package:chat_bot/screens/base.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/utils/app_iap.dart';
import 'package:chat_bot/utils/app_navigator.dart';
import 'package:chat_bot/utils/app_style.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';

class PremiumScreen extends BaseStatefulWidget {

  final bool showRewardAdsOption;

  const PremiumScreen({super.key, required this.showRewardAdsOption});

  @override
  State<StatefulWidget> createState() => _PremiumScreenState();

}

class _PremiumScreenState extends BaseState<PremiumScreen> {

  int _selectedIndex = 0;
  final int _adsIndex = 1000;
  RewardedAd? _rewardedAd;

  @override
  void initState() {
    super.initState();
    if (Utils.isMobile) {
      _loadRewardAd(show: false);
    }
    var viewModel = context.read<AppIAP>();
    if (viewModel.products.isNotEmpty) {
      _selectedIndex = 0;
    } else {
      _selectedIndex = _adsIndex;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.addAll([
      Container(height: 10),
      Text(S.current.premium_title_hint, textAlign: TextAlign.center, style: AppStyle.body1B),
      Text(S.current.premium_title_hint_1, textAlign: TextAlign.center, style: AppStyle.body2),
      Container(height: 10),
    ]);
    //subs
    var viewModel = context.watch<AppIAP>();
    for (int i = 0; i < viewModel.products.length; i++) {
      children.add(Subscription(
        onTap: () => onSubscriptionSelected(i),
        isSelected: _selectedIndex == i,
        detail: viewModel.products[i],
      ));
      if (i != viewModel.products.length - 1) {
        children.add(Container(height: 10));
      }
    }
    if (widget.showRewardAdsOption) {
      children.add(Container(height: 10));
      children.add(SubscriptionAds(onTap: () => onSubscriptionSelected(_adsIndex),
        isSelected: _selectedIndex == _adsIndex)
      );
    }
    children.addAll([
      const SubscriptionFeatures(),
      ElevatedButton(
        style : ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith((states) {
            return states.contains(MaterialState.pressed) ? Theme.of(context).primaryColor : null;
          }),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return Theme.of(context).primaryColor.withAlpha(180);
          })
        ),
        // style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor.withAlpha(180),
        //   foregroundColor: Theme.of(context).primaryColor),
        onPressed: onSubscription,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
          child: Text(_getPurchaseBtString(), textAlign: TextAlign.center, style: AppStyle.headline6B.apply(color: Colors.white)),
        ),
      ),
      Container(height: 10),
      // Center(child: InkWell(
      //     onTap: () {
      //       viewModel.restorePurchases();
      //     },
      //     child: Text(S.current.setting_restore_purchase, style: AppStyle.body2.apply(decoration: TextDecoration.underline)))
      // ),
      Container(height: 10),
      SubscriptionTerm(term: _getPurchaseBtString())
    ]);

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
            children: children
          ),
        ),
      ),
    );
  }

  String _getPurchaseBtString() {
    if (_selectedIndex == _adsIndex) {
      return S.current.premium_purchase_ads;
    }
    var products = context.read<AppIAP>().products;
    if (_selectedIndex >= 0 && _selectedIndex < products.length) {
      var product = products[_selectedIndex];
      if (product.id == AppIAP.kWeekSubscriptionId) {
        return S.current.premium_purchase_try_for_free;
      }
    }
    return S.current.premium_purchase;
  }

  void onSubscription() {
    if (_selectedIndex == _adsIndex) {
      _showRewardAd();
      return;
    }
    var viewModel = context.read<AppIAP>();
    if (_selectedIndex >= 0 && _selectedIndex < viewModel.products.length) {
      var product = viewModel.products[_selectedIndex];
      viewModel.purchase(product);
    }
  }

  void onSubscriptionSelected(int index) {
    setState(() {
      _selectedIndex = index;
      debugPrint("on subscription selected: $_selectedIndex");
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
          _rewardedAd?.setServerSideOptions(ServerSideVerificationOptions(
              customData: User.instance.userId.toString()
          ));
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
      _loadRewardAd(show: true);
    } else {
      _rewardedAd?.setServerSideOptions(ServerSideVerificationOptions(
        customData: User.instance.userId.toString()
      ));
      _rewardedAd?.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
          AppNavigator.goBack();
        }
      );
    }
  }

}

class Subscription extends BaseStatelessWidget {

  final VoidCallback onTap;
  final bool isSelected;
  String promotion = "";
  final ProductDetails detail;

  Subscription({Key? key, required this.onTap, required this.isSelected, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = detail.id == AppIAP.kYearSubscriptionId ? S.current.premium_year : S.current.premium_week;
    String desc = detail.id == AppIAP.kYearSubscriptionId ? S.current.premium_year_desc(detail.price) : S.current.premium_week_desc(detail.price);
    promotion = detail.id == AppIAP.kYearSubscriptionId ? "Save 85%": "";
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
                      Text(title, style: AppStyle.body1B),
                      Text(desc, style: AppStyle.body2),
                    ]
                ),
              ),
              Visibility(
                visible: promotion.isNotEmpty,
                child: Positioned(
                  top: 0.0, right: 0.0, child: Container(
                    decoration: ShapeDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(180),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomLeft: Radius.circular(15)))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                      child: Text(promotion, style: AppStyle.body2.apply(color: Colors.white)),
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

class SubscriptionAds extends BaseStatelessWidget {

  final VoidCallback onTap;
  final bool isSelected;

  const SubscriptionAds({Key? key, required this.onTap, required this.isSelected}) : super(key: key);

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
                      Text(S.current.premium_ads, style: AppStyle.body1B),
                      Text(S.current.premium_ads_price, style: AppStyle.body2),
                    ]
                ),
              )
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
          _featureItem(Image.asset(isDarkMode ? "assets/images/ic_infinite_white.png" : "assets/images/ic_infinite.png"), S.current.premium_feature_3, S.current.premium_feature_3_desc),
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