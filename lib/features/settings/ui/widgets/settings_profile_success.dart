import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_router/app_router.dart';
import '../../../../core/themes/text_style/text_styles.dart';
import '../../../../core/themes/theme_color.dart';
import '../../../../core/widgets/custom_body_titles_widget.dart';
import '../../../../core/widgets/custom_circle_image.dart';
import '../../logic/settings_cubit.dart';

class SettingsProfileSuccess extends StatelessWidget {
  const SettingsProfileSuccess({
    super.key,
    required this.themeColors, required this.state,
  });

  final ThemeColors themeColors;
  final SettingsSuccess state;

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
                  child: CustomCircleImage(profileImage: state.user.profilePicture),
                ),
                const SizedBox(width: 20),
                CustomBodyTitlesWidget(
                  textTitle: Text(
                    state.user.name,
                    style: Styles.textStyle18,
                  ),
                  textSubTitle: Text(
                    'Available',
                    style: Styles.textStyle12.copyWith(color: themeColors.bodyTextColor),
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
