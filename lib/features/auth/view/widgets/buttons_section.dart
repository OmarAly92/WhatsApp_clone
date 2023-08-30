import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/app_router/app_router.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

class WelcomeButtonsSection extends StatelessWidget {
  const WelcomeButtonsSection({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 250.w,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              fixedSize: Size(250.w, 30.h),
              backgroundColor: themeColors.greenButton,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              // GoRouter.of(context).push(AppRouter.phoneAuthScreen);
              Navigator.pushNamed(context, AppRouter.phoneAuthScreen);
            },
            child: Text(
              'Agree and continue',
              style: TextStyle(color: themeColors.backgroundColor),
            ),
          ),
        ),
        SizedBox(height: 40.h),
        Container(
          height: 33.h,
          width: 125.w,
          decoration: BoxDecoration(
            color: themeColors.secondaryButton,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.language, color: themeColors.greenButton),
              const SizedBox(width: 9),
              Text(
                'English',
                style: Styles.textStyle14.copyWith(
                  color: themeColors.greenButton,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 9),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: themeColors.greenButton,
              )
            ],
          ),
        ),
      ],
    );
  }
}
