import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

class CustomProfileDivider extends StatelessWidget {
  const CustomProfileDivider({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: themeColors.dividerColor,
          thickness: .09,
          indent: 45.w,
        ),
      ],
    );
  }
}
