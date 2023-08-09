import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

class TheAuthor extends StatelessWidget {
  const TheAuthor({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 18.h),
        Text('from',
            style:
                Styles.textStyle14.copyWith(color: themeColors.bodyTextColor)),
        Text('EG0',
            style: Styles.textStyle14.copyWith(
                color: themeColors.theAuthorTextColor, fontSize: 15.spMin)),
        SizedBox(height: 40.h),
      ],
    );
  }
}
