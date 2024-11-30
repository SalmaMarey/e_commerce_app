import 'package:e_commerce_app/core/utils/assets.dart';
import 'package:e_commerce_app/features/splash_onboarding/widgets/dots_indicator.dart';
import 'package:e_commerce_app/features/splash_onboarding/widgets/onboarding_details.dart';
import 'package:e_commerce_app/features/splash_onboarding/widgets/skip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          OnboardingDetails(
            image: Assets.purchaseOnline,
            title: 'Purchase Online !!',
            description:
                'Discover thousands of amazing products at unbeatable prices. Shopping made simple, fast, and enjoyable!',
            shape: Assets.shape1,
            isFirstOnboarding: true,
          ),
          OnboardingDetails(
            shape: Assets.shape2,
            image: Assets.trackOrder,
            title: 'Shop & Order with Ease !!',
            description:
                'From browsing to checkout, enjoy a simple, fast, and convenient shopping process!',
            isSecondOnboarding: true,
          ),
          OnboardingDetails(
            shape: Assets.shape3,
            image: Assets.getYourOrder,
            title: 'Purchase Online !!',
            description:
                'Browse your favorite products from the comfort of your home and place an order with ease!',
            // isThirdOnboarding: true,
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.5.h, horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DotsIndicator(
                currentIndex: _currentIndex,
                itemCount: 3,
              ),
            ),
            const SkipButton(),
          ],
        ),
      ),
    );
  }
}
