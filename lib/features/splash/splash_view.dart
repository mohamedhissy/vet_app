import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/app_open_ad_manager.dart';
import '../../../../routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    print("⏳ SplashView بدأت...");
    await Future.delayed(const Duration(seconds: 2));

    if (!GetPlatform.isWeb) {
      print("📢 محاولة عرض الإعلان...");
      try {
        await AppOpenAdManager().showAdIfAvailable().timeout(
          const Duration(seconds: 5),
          onTimeout: () => print("⏱ الإعلان تأخر أو غير جاهز... نكمل"),
        );
      } catch (e) {
        print("⚠️ خطأ أثناء عرض الإعلان: $e");
      }
    }

    _redirectUser();
  }

  void _redirectUser() {
    final user = Supabase.instance.client.auth.currentSession?.user;
    print("👤 المستخدم الحالي: ${user?.email}");

    if (user != null) {
      print("➡️ التوجيه إلى Home");
      Get.offAllNamed(Routes.homeView);
    } else {
      print("➡️ التوجيه إلى Login");
      Get.offAllNamed(Routes.loginView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
