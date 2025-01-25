import 'package:e_commerce_app/core/utils/assets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;

  const LoginBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Assets.login),
        Positioned(
          top: 438.h,
          left: 20.w,
          right: 20.w,
          child: child,
        ),
      ],
    );
  }
}