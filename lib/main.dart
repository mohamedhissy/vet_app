import 'package:animalsapp/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/dependancy_injection.dart';
import 'core/app_life_cycle_reactor.dart';
import 'core/app_open_ad_manager.dart';
import 'core/services/notification_service.dart';

final AppOpenAdManager _adManager = AppOpenAdManager();
late final AppLifecycleReactor _appLifecycleReactor;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("🔥 بدء تهيئة Supabase...");
  await Supabase.initialize(
    url: 'https://onrolwqjeygbcuqyxoah.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9ucm9sd3FqZXlnYmN1cXl4b2FoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ4MDE1MjksImV4cCI6MjA2MDM3NzUyOX0._Nw4VYwzXIMIvvVJHIDXf1sqQ0j-NTcpIK3pnoYH77M',
  );
  print("✅ تم تهيئة Supabase");

  print("🔥 Firebase...");
  await Firebase.initializeApp();
  print("✅ Firebase جاهز");

  await FirebaseMessaging.instance.requestPermission();
  final token = await FirebaseMessaging.instance.getToken();
  print("🔥 FCM Token: $token");

  final user = Supabase.instance.client.auth.currentUser;
  print("🧪 Supabase user: ${user?.email}");

  if (user != null && token != null) {
    print("📤 رفع التوكن لقاعدة البيانات...");
    await Supabase.instance.client.from('user_tokens').upsert({
      'user_id': user.id,
      'token': token,
    }, onConflict: 'token');
    print("✅ تم رفع التوكن");
  }

  await NotificationService.instance.setUpFlutterNotification();
  print("✅ تم تهيئة الإشعارات");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      NotificationService.instance.showNotification(
        title: notification.title ?? 'تنبيه',
        body: notification.body ?? '',
      );
    }
  });

  await MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(testDeviceIds: ['FA5764DF4617191A5EC3668CC2DA2E0C']),
  );
  print("✅ Mobile Ads جاهزة");

  _adManager.loadAd();
  print("📲 تم تحميل الإعلان");

  _appLifecycleReactor = AppLifecycleReactor(adManager: _adManager);
  _appLifecycleReactor.start();
  print("🌀 Lifecycle Reactor بدأ");

  await initModule();
  print("✅ التهيئة النهائية كاملة");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: user != null ? Routes.homeView : Routes.loginView,
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
