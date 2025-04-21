import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_font_weight.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../routes/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ تسجيل الدخول ناجح')),
        );
        Get.offAllNamed(Routes.homeView);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ فشل تسجيل الدخول: المستخدم غير موجود')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ خطأ في تسجيل الدخول: $e')),
      );
      print('❌ Login error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("🚀 LoginView تم عرضه");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ManagerColors.primaryColor,
        centerTitle: true,
        title: const Text("تسجيل الدخول"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "البريد الإلكتروني"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "كلمة المرور"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text("دخول"),
              style: ElevatedButton.styleFrom(
                backgroundColor: ManagerColors.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed(Routes.registerView);
                  },
                  child: Text(
                    ManagerStrings.signUp,
                    style: TextStyle(
                      fontWeight: ManagerFontWeight.regular,
                      fontSize: ManagerFontSizes.s16,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  ManagerStrings.dontHaveAnAccount,
                  style: TextStyle(
                    fontSize: ManagerFontSizes.s16,
                    fontWeight: ManagerFontWeight.w400,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
