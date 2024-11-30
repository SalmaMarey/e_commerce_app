
import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/features/splash_onboarding/screens/onboarding_screen.dart';
import 'package:e_commerce_app/features/splash_onboarding/screens/start_screen.dart';
import 'package:flutter/material.dart';


class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (_) =>  const OnboardingScreen(),
        );
       case Routes.start:
        return MaterialPageRoute(
          builder: (_) =>  const StartScreen(),
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