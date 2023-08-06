import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

import 'widgets/tab_bar_view_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.themeColors});

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: buildHomeAppBar(),
        body: TabBarViewBody(themeColors: themeColors),
      ),
    );
  }

  AppBar buildHomeAppBar() {
    return AppBar(
      title: const Text('WhatsApp'),
      actions: [
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined)),
        IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ],
      bottom: TabBar(
        unselectedLabelColor: themeColors.appbarTextColor,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(
            child: Text(
              'Chats',
              style: Styles.textStyle14.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
              ),
            ),
          ),
          Tab(
            child: Text(
              'Updates',
              style: Styles.textStyle14.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
              ),
            ),
          ),
          Tab(
            child: Text(
              'Calls',
              style: Styles.textStyle14.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

