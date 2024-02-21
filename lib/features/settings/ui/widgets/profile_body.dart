import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/text_style/text_styles.dart';
import '../../../../core/themes/theme_color.dart';
import '../../logic/settings_cubit.dart';
import 'custom_size_box_divider.dart';
import 'profile_items.dart';
import 'profile_picture_widget.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key, required this.themeColors}) : super(key: key);
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state is SettingsSuccess) {
          return Column(
            children: [
              SizedBox(height: 28.h),
              ProfilePictureWidget(profileImage: state.user.profilePicture),
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
                            subTitle: state.user.name,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 45.w),
                            child: Text(
                              'This is not your username or pin. This name will be visible to your WhatsApp contacts.',
                              style: Styles.textStyle14().copyWith(
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
                        subTitle: '+2${state.user.phoneNumber}',
                      ),
                    ),
                    SizedBox(height: 11.h),
                  ],
                ),
              ),
            ],
          );
        } else if (state is SettingsFailure) {
          return Center(child: Text(state.failureMessage));
        } else {
          return const Center(child: Text('initial state'));
        }
      },
    );
  }
}
