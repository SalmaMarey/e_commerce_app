import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/screens/login_screen.dart';
import 'package:e_commerce_app/features/auth/register/presentation/screens/register_screen.dart';
import 'package:e_commerce_app/features/home/presentation/screens/layout_screen.dart';
import 'package:e_commerce_app/features/splash_onboarding/screens/onboarding_screen.dart';
import 'package:e_commerce_app/features/splash_onboarding/screens/start_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case Routes.start:
        return MaterialPageRoute(
          builder: (_) => const StartScreen(),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case Routes.layout:
        return MaterialPageRoute(
          builder: (_) => const LayoutScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}
