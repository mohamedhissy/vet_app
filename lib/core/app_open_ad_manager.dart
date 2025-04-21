import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdManager {
  AppOpenAd? _appOpenAd;
  bool _isAdAvailable = false;
  bool isShowingAd = false;

  bool get isAdAvailable => _isAdAvailable;

  void loadAd() {
    AppOpenAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/3419835294', // Test ID
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          print('📲 App Open Ad loaded.');
          _appOpenAd = ad;
          _isAdAvailable = true;
        },
        onAdFailedToLoad: (error) {
          print('❌ Failed to load App Open Ad: $error');
          _isAdAvailable = false;
        },
      ),
      orientation: AppOpenAd.orientationPortrait,
    );
  }

  Future<void> showAdIfAvailable() async {
    if (!_isAdAvailable || isShowingAd || _appOpenAd == null) {
      print('⚠️ App Open Ad not ready yet.');
      loadAd();
      return;
    }

    isShowingAd = true;
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) => print('📢 Ad shown.'),
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('❌ Ad failed to show: $error');
        ad.dispose();
        _resetAdState();
      },
      onAdDismissedFullScreenContent: (ad) {
        print('👋 Ad dismissed.');
        ad.dispose();
        _resetAdState();
        loadAd(); // reload for next time
      },
    );

    await _appOpenAd!.show();
  }

  void _resetAdState() {
    _appOpenAd = null;
    _isAdAvailable = false;
    isShowingAd = false;
  }
}
