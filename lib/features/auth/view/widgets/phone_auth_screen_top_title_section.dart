import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

class PhoneAuthScreenTopTitleSection extends StatelessWidget {
  const PhoneAuthScreenTopTitleSection({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '      ',
              style: Styles.textStyle18,
            ),
            Text(
              'Enter your phone number',
              style: Styles.textStyle18,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: themeColors.bodyTextColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'WhatsApp will need to verify your account. ',
                style: Styles.textStyle12
                    .copyWith(color: themeColors.regularTextColor),
              ),
              TextSpan(
                text: 'What\'s my number?',
                style: Styles.textStyle12.copyWith(
                  color: const Color(0xff66b6d9),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
