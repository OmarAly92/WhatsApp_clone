import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/themes/theme_color.dart';
import '../../../../core/widgets/custom_body_titles_widget.dart';

class SettingsProfileLoading extends StatelessWidget {
  const SettingsProfileLoading({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: themeColors.bodyTextColor.withOpacity(.45),
      highlightColor: themeColors.backgroundColor,
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
                  child: Container(
                    height: 49.r,
                    width: 49.r,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                CustomBodyTitlesWidget(
                  textTitle: Container(
                    width: 200.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(
                        20.r,
                      ),
                    ),
                  ),
                  textSubTitle: Container(
                    margin: EdgeInsets.symmetric(vertical: 3.5.h),
                    width: 80.w,
                    height: 9.h,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(
                        20.r,
                      ),
                    ),
                  ),
                  themeColors: themeColors,
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.qr_code,
                color: const Color(0xff18ad8b),
                size: 27.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
