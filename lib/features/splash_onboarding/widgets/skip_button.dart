import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../../core/routing/routes.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, Routes.start);
      },
      child: Row(
        children: [
          Text(
            'Skip',
            style: AppTextStyles.font18Bold,
          ),
        ],
      ),
    );
  }
}
