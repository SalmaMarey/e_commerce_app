
import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/features/splash_onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';


class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      


      // case Routes.favourite:
      //   return MaterialPageRoute(
      //     builder: (_) => const FavoriteScreen(),
      //   );
      // case Routes.profile:
      //   return MaterialPageRoute(
      //     builder: (_) => const ProfileScreen(),
      //   );

      // case Routes.settings:
      //   return MaterialPageRoute(
      //     builder: (_) => const Placeholder(),
      //   );

    

  

 default:
        // Fallback or error handling
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