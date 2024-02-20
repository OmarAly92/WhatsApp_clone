import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/theme_color.dart';
import '../../../../core/utils/dependency_injection.dart';
import '../../../call/ui/calls_screen.dart';
import '../../../chats/logic/chats_cubit/chats_cubit.dart';
import '../../../chats/ui/chats_screen.dart';
import '../../../updates/ui/updates_screen.dart';

class TabBarViewBody extends StatelessWidget {
  const TabBarViewBody({
    super.key,
    required this.themeColors,
    required this.pageController,
  });

  final ThemeColors themeColors;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsCubit(sl())..getContacts(),
      child: PageView(
        controller: pageController,
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
