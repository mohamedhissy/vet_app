import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_font_weight.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../routes/routes.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SignUpView({super.key});

  void _signUp(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final response = await Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ تم إنشاء الحساب، تحقق من بريدك.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ فشل إنشاء الحساب')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ManagerColors.primaryColor,
          centerTitle: true,
          title: const Text("إنشاء حساب"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "ايميل")),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: "كلمة المرور"), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _signUp(context),
              child: const Text("تسجيل"),
              style: ElevatedButton.styleFrom(
                backgroundColor: ManagerColors.primaryColor, //  هنا
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, Routes.loginView);
                  },
                  child: Text(
                    ManagerStrings.login,
                    style: TextStyle(
                      fontWeight: ManagerFontWeight.regular,
                      fontSize: ManagerFontSizes.s16,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Text(
                  ManagerStrings.HaveAnAccount,
                  style: TextStyle(
                      fontSize: ManagerFontSizes.s16,
                      fontWeight: ManagerFontWeight.w400),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
