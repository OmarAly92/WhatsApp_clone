import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

import '../../call/view/calls_screen.dart';
import '../../chat/view/chats_screen.dart';




class TabBarViewBody extends StatelessWidget {
  const TabBarViewBody({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
          child: ChatsScreen(themeColors: themeColors),
        ),
        const Center(child: Text('Updates')),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
          child: CallsScreen(themeColors: themeColors),
        ),
      ],
    );
  }
}
