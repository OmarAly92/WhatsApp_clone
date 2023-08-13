import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/auth/view/widgets/buttons_section.dart';
import 'package:whats_app_clone/features/auth/view/widgets/title_and_subtitle_section.dart';

import 'widgets/icon_image_section.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.themeColors});

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeBody(themeColors: themeColors),
    );
  }
}

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key, required this.themeColors});

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 19.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WelcomeIconImageSection(themeColors: themeColors),
            WelcomeTitleAndSubtitleSection(themeColors: themeColors),
            WelcomeButtonsSection(themeColors: themeColors)
          ],
        ),
      ),
    );
  }
}
