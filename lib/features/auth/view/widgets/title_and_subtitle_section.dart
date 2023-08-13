import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

class WelcomeTitleAndSubtitleSection extends StatelessWidget {
  const WelcomeTitleAndSubtitleSection({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome to WhatsApp Clone',
          style: Styles.textStyle22.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10.h),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Read our ',
                style: Styles.textStyle14.copyWith(
                    color: themeColors.bodyTextColor, fontSize: 13.spMin),
              ),
              TextSpan(
                text: 'Privacy Policy',
                style: Styles.textStyle14.copyWith(
                    color: const Color(0xff50b2e1), fontSize: 13.spMin),
              ),
              TextSpan(
                text: '. Tap "Agree and continue" to accept the ',
                style: Styles.textStyle14.copyWith(
                    color: themeColors.bodyTextColor, fontSize: 13.spMin),
              ),
              TextSpan(
                text: 'Terms of Service',
                style: Styles.textStyle14.copyWith(
                    color: const Color(0xff50b2e1), fontSize: 13.spMin),
              ),
              TextSpan(
                text: '.',
                style: Styles.textStyle14.copyWith(
                    color: themeColors.bodyTextColor, fontSize: 13.spMin),
              ),
            ],
          ),
        ),
        SizedBox(height: 28.h),
      ],
    );
  }
}
