import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../../../core/themes/text_style/text_styles.dart';
import '../../../../../../core/themes/theme_color.dart';

class IconItemWidget extends StatelessWidget {
  const IconItemWidget({
    super.key,
    required this.themeColors,
    required this.icons,
    required this.gradient,
    required this.title,
    required this.onTap,
  });

  final ThemeColors themeColors;
  final IconData icons;
  final List<Color> gradient;
  final String title;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(25.5.r),
          onTap: onTap,
          child: Container(
            height: 51.r,
            width: 51.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.5.r),
              gradient: SweepGradient(
                colors: gradient,
              ),
            ),
            child: Icon(
              icons,
              size: 22.r,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          title,
          style: Styles.textStyle16().copyWith(
            color: themeColors.bodyTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
