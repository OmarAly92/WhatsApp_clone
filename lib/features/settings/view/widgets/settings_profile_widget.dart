import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/app_router/app_router.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/core/widgets/custom_circle_image.dart';

import '../../../../core/widgets/custom_body_titles_widget.dart';

class SettingsProfileWidget extends StatelessWidget {
  const SettingsProfileWidget({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRouter.profileScreen);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 60.r,
                  width: 60.r,
                  child: const CustomCircleImage(),
                ),
                const SizedBox(width: 20),
                CustomBodyTitlesWidget(
                  textTitle: Text(
                    'Omar Aly',
                    style: Styles.textStyle18,
                  ),
                  textSubTitle: Text(
                    'Available',
                    style: Styles.textStyle12
                        .copyWith(color: themeColors.bodyTextColor),
                  ),
                  themeColors: themeColors,
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.qr_code,
                color: Color(0xff18ad8b),
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
