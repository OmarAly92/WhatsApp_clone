import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/theme_color.dart';
import 'buttons_section.dart';
import 'icon_image_section.dart';
import 'title_and_subtitle_section.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key, required this.themeColors});

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 19.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WelcomeIconImageSection(themeColors: themeColors),
              WelcomeTitleAndSubtitleSection(themeColors: themeColors),
              WelcomeButtonsSection(themeColors: themeColors)
            ],
          ),
        ),
      ),
    );
  }
}
