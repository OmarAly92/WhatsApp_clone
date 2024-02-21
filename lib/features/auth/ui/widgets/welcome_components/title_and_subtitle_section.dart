import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/text_style/text_styles.dart';
import '../../../../../core/themes/theme_color.dart';

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
          style: Styles.textStyle24().copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10.h),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Read our ',
                style: Styles.textStyle16().copyWith(
                    color: themeColors.bodyTextColor),
              ),
              TextSpan(
                text: 'Privacy Policy',
                style: Styles.textStyle16().copyWith(
                    color: const Color(0xff50b2e1)),
              ),
              TextSpan(
                text: '. Tap "Agree and continue" to accept the ',
                style: Styles.textStyle16().copyWith(
                    color: themeColors.bodyTextColor),
              ),
              TextSpan(
                text: 'Terms of Service',
                style: Styles.textStyle16().copyWith(
                    color: const Color(0xff50b2e1)),
              ),
              TextSpan(
                text: '.',
                style: Styles.textStyle16().copyWith(
                    color: themeColors.bodyTextColor),
              ),
            ],
          ),
        ),
        SizedBox(height: 28.h),
      ],
    );
  }
}
