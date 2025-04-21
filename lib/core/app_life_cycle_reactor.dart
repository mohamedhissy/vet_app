import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app_open_ad_manager.dart';

class AppLifecycleReactor with WidgetsBindingObserver {
  final AppOpenAdManager adManager;

  AppLifecycleReactor({required this.adManager});

  void start() {
    WidgetsBinding.instance.addObserver(this);
    adManager.loadAd(); // حمل الإعلان عند بدء التطبيق
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      adManager.showAdIfAvailable(); // عرض الإعلان عند العودة من الخلفية
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
