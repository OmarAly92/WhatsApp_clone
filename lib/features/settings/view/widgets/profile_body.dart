import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/settings/view/widgets/custom_size_box_divider.dart';
import 'package:whats_app_clone/features/settings/view/widgets/profile_items.dart';
import 'package:whats_app_clone/features/settings/view/widgets/profile_picture_widget.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key, required this.themeColors}) : super(key: key);
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 28.h),
        const ProfilePictureWidget(),
        SizedBox(height: 28.h),
        InkWell(
          onTap: () {},
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  children: [
                    ProfileItems(
                      themeColors: themeColors,
                      leadingIcon: Icons.person,
                      title: 'Name',
                      subTitle: 'Omar Aly',
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 45.w),
                      child: Text(
                        'This is not your username or pin. This name will be visible to your WhatsApp contacts.',
                        style: Styles.textStyle12.copyWith(
                          color: themeColors.bodyTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 11.h),
            ],
          ),
        ),
        CustomProfileDivider(themeColors: themeColors),
        InkWell(
          onTap: () {},
          child: Column(
            children: [
              SizedBox(height: 11.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: ProfileItems(
                  themeColors: themeColors,
                  leadingIcon: Icons.info_outline,
                  title: 'About',
                  subTitle: 'Available',
                ),
              ),
              SizedBox(height: 11.h),
            ],
          ),
        ),
        CustomProfileDivider(themeColors: themeColors),
        InkWell(
          onTap: () {},
          child: Column(
            children: [
              SizedBox(height: 11.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: ProfileItems(
                  themeColors: themeColors,
                  leadingIcon: Icons.phone,
                  title: 'Phone',
                  subTitle: '+20 101 453 1739',
                ),
              ),
              SizedBox(height: 11.h),
            ],
          ),
        ),
      ],
    );
  }
}
