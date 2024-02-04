import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/functions/global_functions.dart';

import '../../../../core/app_router/app_router.dart';
import '../../../../core/themes/text_style/text_styles.dart';
import '../../../../core/themes/theme_color.dart';
import '../../../auth/logic/old/authentication_old_cubit.dart';
import 'custom_list_tile.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          themeColors: themeColors,
          icon: Icons.key,
          title: 'Account',
          titleFontSize: 16.sp,
          subtitle: 'Security notification, changes number',
          subtitleFontSize: 12.5.sp,
          onTap: () {},
        ),
        CustomListTile(
          themeColors: themeColors,
          icon: Icons.lock_rounded,
          title: 'Privacy',
          titleFontSize: 16.sp,
          subtitle: 'Block contacts, disappearing messages',
          subtitleFontSize: 12.5.sp,
          onTap: () {},
        ),
        CustomListTile(
          themeColors: themeColors,
          icon: Icons.person_2,
          title: 'Avatar',
          titleFontSize: 16.sp,
          subtitle: 'Create, edit, profile photo',
          subtitleFontSize: 12.5.sp,
          onTap: () {},
        ),
        CustomListTile(
          themeColors: themeColors,
          icon: Icons.chat,
          title: 'Chat',
          titleFontSize: 16.sp,
          subtitle: 'Theme, wallpapers, chat history',
          subtitleFontSize: 12.5.sp,
          onTap: () {},
        ),
        CustomListTile(
          themeColors: themeColors,
          icon: Icons.notifications,
          title: 'Notification',
          titleFontSize: 16.sp,
          subtitle: 'Message, group & call tones',
          subtitleFontSize: 12.5.sp,
          onTap: () {},
        ),
        CustomListTile(
          themeColors: themeColors,
          icon: Icons.incomplete_circle_rounded,
          title: 'Storage and data',
          titleFontSize: 16.sp,
          subtitle: 'Network usage, auto-download',
          subtitleFontSize: 12.5.sp,
          onTap: () {},
        ),
        CustomListTile(
          themeColors: themeColors,
          icon: Icons.language,
          title: 'App language',
          titleFontSize: 16.sp,
          subtitle: 'English (device\'s language)',
          subtitleFontSize: 12.5.sp,
          onTap: () {},
        ),
        CustomListTile(
          themeColors: themeColors,
          icon: Icons.help_outline,
          title: 'Help',
          titleFontSize: 16.sp,
          subtitle: 'Help center, contact us, privacy policy',
          subtitleFontSize: 12.5.sp,
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.people_rounded, color: themeColors.bodyTextColor),
          title: Text('Invite a friend', style: Styles.textStyle16),
          minLeadingWidth: 28.w,
          onTap: () {},
        ),
        BlocProvider<AuthenticationOldCubit>(
          create: (context) => AuthenticationOldCubit(),
          child: ListTile(
            leading: const Icon(Icons.people_rounded, color: Colors.red),
            title: Text(
              'Logout',
              style: Styles.textStyle16.copyWith(
                color: Colors.red,
              ),
            ),
            minLeadingWidth: 28.w,
            onTap: () {
              AuthenticationOldCubit authenticationCubit = AuthenticationOldCubit();
              authenticationCubit.logOut();
              GlFunctions.updateActiveStatus(isOnline: false);
              Navigator.pushReplacementNamed(context, AppRouter.welcomeScreen);
            },
          ),
        ),
      ],
    );
  }
}
