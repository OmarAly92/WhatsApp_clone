import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/updates/view/updates_screen.dart';

import '../../call/view/calls_screen.dart';
import '../../chats/view/chats_screen.dart';
import '../../chats/view_model/chats_cubit/chats_cubit.dart';

class TabBarViewBody extends StatelessWidget {
  const TabBarViewBody({
    super.key,
    required this.themeColors,
    required this.tabController,
  });

  final ThemeColors themeColors;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChatsCubit()..getContacts()),
      ],
      child: TabBarView(
        controller: tabController,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0.h),
            child: ChatsScreen(themeColors: themeColors),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
            child: UpdatesScreen(
              themeColors: themeColors,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
            child: CallsScreen(themeColors: themeColors),
          ),
        ],
      ),
    );
  }
}
