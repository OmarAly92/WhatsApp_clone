import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/app_router/app_router.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/auth/view/widgets/phone_auth_screen_top_title_section.dart';

import 'widgets/phone_auth_screen_text_form_section.dart';

class PhoneAuthScreen extends StatelessWidget {
  const PhoneAuthScreen({Key? key, required this.themeColors})
      : super(key: key);
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  PhoneAuthScreenTopTitleSection(themeColors: themeColors),
                  SizedBox(height: 5.h),
                  const PhoneAuthScreenTextFormSection(),
                  SizedBox(height: 20.h),
                  Text(
                    'Carrier charges may apply',
                    style: Styles.textStyle14.copyWith(
                      color: themeColors.bodyTextColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColors.greenButton,
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRouter.homeScreen, (route) => false);
                    },
                    child: Text(
                      'Next',
                      style: Styles.textStyle14.copyWith(
                        color: themeColors.backgroundColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
