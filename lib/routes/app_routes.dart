import 'dart:developer';

import 'package:ambulancecheckup/routes/routes.dart';
import 'package:ambulancecheckup/screens/checkup_screen.dart';
import 'package:ambulancecheckup/screens/login_screen.dart';
import 'package:ambulancecheckup/screens/main_screen.dart';
import 'package:ambulancecheckup/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  // static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainScreen:
        log(Routes.mainScreen);

        // final args = settings.arguments as MainScreen;

        return MaterialPageRoute(
            builder: (context) => const MainScreen(), settings: settings);

      case Routes.loginScreen:
        log(Routes.loginScreen);
        return MaterialPageRoute(
            builder: (context) => const LoginScreen(), settings: settings);

      case Routes.splashScreen:
        log(Routes.splashScreen);

        return MaterialPageRoute(
            builder: (context) => const SplashScreen(), settings: settings);

      case Routes.checkupScreen:
        log(Routes.checkupScreen);

        return MaterialPageRoute(
            builder: (context) => const CheckUpScreen(), settings: settings);
    }
    return null;
  }
}
