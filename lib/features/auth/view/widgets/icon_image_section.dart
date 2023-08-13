import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/core/utils/assets_data.dart';

class WelcomeIconImageSection extends StatelessWidget {
  const WelcomeIconImageSection({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert, color: themeColors.bodyTextColor)),
          ],
        ),
        SizedBox(height: 20.h),
        Center(
          child: Container(
            height: 250.r,
            width: 250.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(250.r),
              image: const DecorationImage(
                image: AssetImage(kWelcomeImage),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
        SizedBox(height: 45.h),
      ],
    );
  }
}
