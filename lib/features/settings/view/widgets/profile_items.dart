import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

class ProfileItems extends StatelessWidget {
  const ProfileItems({
    super.key,
    required this.themeColors,
    required this.leadingIcon,
    required this.title,
    required this.subTitle,
  });

  final ThemeColors themeColors;
  final IconData leadingIcon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              leadingIcon,
              color: themeColors.bodyTextColor,
            ),
            SizedBox(width: 25.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Styles.textStyle14.copyWith(
                    color: themeColors.bodyTextColor,
                  ),
                ),
                Text(
                  subTitle,
                  style: Styles.textStyle16,
                ),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.edit,
            color: themeColors.greenButton,
          ),
        ),
      ],
    );
  }
}