import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/text_style/text_styles.dart';
import '../../../../core/themes/theme_color.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.themeColors, required this.icon, required this.title, required this.titleFontSize, required this.subtitle, required this.subtitleFontSize, required this.onTap,
  });

  final ThemeColors themeColors;
  final IconData icon;
  final String title;
  final double titleFontSize;
  final String subtitle;
  final double subtitleFontSize;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: themeColors.bodyTextColor),
      title: Text(title, style: Styles.textStyle16.copyWith(
        fontSize: titleFontSize
      )),
      subtitle: Text(
        subtitle,
        style: Styles.textStyle12.copyWith(
          color: themeColors.bodyTextColor,
          fontSize:subtitleFontSize,
        ),
      ),
      minLeadingWidth: 28.w,
      onTap: onTap,
    );

  }
}
