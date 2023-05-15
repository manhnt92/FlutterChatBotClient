import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const String testDevice = 'YOUR_DEVICE_ID';
const int maxFailedLoadAttempts = 3;

class TestAds extends StatefulWidget {

  const TestAds({super.key});

  @override
  State<StatefulWidget> createState() => _TestAdsState();

}

class _TestAdsState extends State<TestAds> {

  final BannerAdListener _bannerListener = BannerAdListener(
    onAdLoaded: (Ad ad) => debugPrint('Ad loaded.'),
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      debugPrint('Ad failed to load: $error');
    },
    onAdOpened: (Ad ad) => debugPrint('Ad opened.'),
    onAdClosed: (Ad ad) => debugPrint('Ad closed.'),
    onAdImpression: (Ad ad) => debugPrint('Ad impression.'),
  );
  late BannerAd _banner;
  late final Container _bannerContainer;
  final String _bannerAdUnitId = "ca-app-pub-3940256099942544/6300978111";

  InterstitialAd? _interstitialAd;
  final _interstitialAdUnitId = Utils.instance.isAndroid ? 'ca-app-pub-3940256099942544/1033173712' : 'ca-app-pub-3940256099942544/4411468910';

  RewardedAd? _rewardedAd;
  final _rewardAdUnitId = Utils.instance.isAndroid ? 'ca-app-pub-3940256099942544/5224354917' : 'ca-app-pub-3940256099942544/1712485313';

  RewardedInterstitialAd? _rewardedInterstitialAd;
  final _rewardedInterstitialAdUnitId = Utils.instance.isAndroid ? 'ca-app-pub-3940256099942544/5354046379' : 'ca-app-pub-3940256099942544/6978759866';

  @override
  void initState() {
    super.initState();
    _banner = BannerAd(
      adUnitId: _bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: _bannerListener,
    );
    _banner.load();
    _bannerContainer = Container(
      alignment: Alignment.center,
      width: _banner.size.width.toDouble(),
      height: _banner.size.height.toDouble(),
      child: AdWidget(ad: _banner),
    );

    _loadInterstitialAd(show: false);
    _loadRewardAd(show: false);
    _loadRewardInterstitialAd(show: false);
  }

  void _loadInterstitialAd({bool show = true}) {
    InterstitialAd.load(
      adUnitId: _interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {},
            onAdImpression: (ad) {},
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
              _interstitialAd = null;
            },
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;
            },
            onAdClicked: (ad) {}
          );

          debugPrint('$ad loaded.');
          _interstitialAd = ad;
          if (show) {
            _showInterstitialAd();
          }
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
          _interstitialAd = null;
        }
      )
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      _loadInterstitialAd(show: true);
    } else {
      _interstitialAd?.show();
    }
  }

  void _loadRewardAd({bool show = true}) {
    RewardedAd.load(
      adUnitId: _rewardAdUnitId,
      request: const AdRequest(),
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

  void _loadRewardInterstitialAd({bool show = true}) {
    RewardedInterstitialAd.load(
        adUnitId: _rewardedInterstitialAdUnitId,
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              ad.fullScreenContentCallback = FullScreenContentCallback(
                  onAdShowedFullScreenContent: (ad) {},
                  onAdImpression: (ad) {},
                  onAdFailedToShowFullScreenContent: (ad, err) {
                    ad.dispose();
                    _rewardedInterstitialAd = null;
                  },
                  onAdDismissedFullScreenContent: (ad) {
                    ad.dispose();
                    _rewardedInterstitialAd = null;
                  },
                  onAdClicked: (ad) {}
              );
              debugPrint('$ad loaded.');
              _rewardedInterstitialAd = ad;
              if (show) {
                _showRewardInterstitialAd();
              }
            },
            onAdFailedToLoad: (LoadAdError error) {
              debugPrint('RewardedAd failed to load: $error');
              _rewardedInterstitialAd = null;
            }
        )
    );
  }
  
  void _showRewardInterstitialAd() {
    if (_rewardedInterstitialAd == null) {
      _loadRewardInterstitialAd();
    } else {
      _rewardedInterstitialAd?.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {

        }
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _banner.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    _rewardedInterstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdMob Plugin example app'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _bannerContainer,
            ElevatedButton(
              onPressed: _showInterstitialAd,
              child: const Text('show Interstitial Ad')
            ),
            ElevatedButton(
                onPressed: _showInterstitialAd,
                child: const Text('show Reward Ad')
            ),
            ElevatedButton(
                onPressed: _showInterstitialAd,
                child: const Text('show Reward Interstitial Ad')
            ),
            const Spacer()
          ],
        )
      ),
    );
  }
}