import 'package:animalsapp/features/auth/presentation/view/login_view.dart';
import 'package:animalsapp/features/auth/presentation/view/sign_up_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/dependancy_injection.dart';
import '../features/home/presentation/view/home_view.dart';
import '../features/splash/splash_view.dart';

class Routes {
  static const String splashScreen = '/splash_view';
  static const String outBoardingView = '/out_boarding_view';
  static const String loginView = '/login_view';
  static const String registerView = '/sign_up_view';
  static const String homeView = '/home_view';
  static const String questionView = '/question_view';
  static const String scoreView = '/score_view';
  static const String cartView = '/cart_view';
  static const String brandView = '/view_details';

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.splashScreen:
      //   return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.homeView:
        initHome();
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.loginView:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.registerView:
        return MaterialPageRoute(builder: (_) => SignUpView());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text("Not found Route")),
      ),
    );
  }
}

