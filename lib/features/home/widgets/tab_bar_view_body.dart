import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/dependency_injection/get_it.dart';
import '../../../core/themes/theme_color.dart';
import '../../call/view/calls_screen.dart';
import '../../chats/view/chats_screen.dart';
import '../../chats/view_model/chats_cubit/chats_cubit.dart';
import '../../updates/view/updates_screen.dart';

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
    return BlocProvider(
      create: (context) => ChatsCubit(sl())..getContacts(),
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
