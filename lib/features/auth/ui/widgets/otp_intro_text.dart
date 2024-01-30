import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/text_style/text_styles.dart';
import '../../../../core/themes/theme_color.dart';

class OTPIntroText extends StatelessWidget {
  const OTPIntroText({
    super.key,
    required this.themeColors,
    required this.phoneNumber,
  });

  final ThemeColors themeColors;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify your phone number',
          style: Styles.textStyle24.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 25.h),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
              text: 'Enter your 6 digit code number sent to ',
              style: Styles.textStyle18
                  .copyWith(height: 1.4, color: themeColors.regularTextColor),
              children: <TextSpan>[
                TextSpan(
                  // text: phoneNumber,
                  text: phoneNumber,
                  style: Styles.textStyle14.copyWith(
                    color: const Color(0xff66b6d9),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
