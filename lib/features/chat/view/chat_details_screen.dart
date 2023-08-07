import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

import 'widgets/chat_details_app_bar_leading.dart';
import 'widgets/chat_details_app_bar_title.dart';
import 'widgets/chat_details_body.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({Key? key, required this.themeColors})
      : super(key: key);

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChatDetailsAppBar(),
      body: ChatDetailsBody(themeColors: themeColors),
    );
  }

  AppBar buildChatDetailsAppBar() {
    List<Widget> actions = [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.videocam_rounded,
          color: themeColors.privateChatAppBarColor,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.call_rounded,
          color: themeColors.privateChatAppBarColor,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.more_vert,
          color: themeColors.privateChatAppBarColor,
        ),
      ),
    ];
    return AppBar(
      toolbarHeight: 50.h,
      leading: ChatDetailsAppBarLeading(themeColors: themeColors),
      leadingWidth: 65.w,
      titleSpacing: 1.w,
      title: ChatDetailsAppBarTitle(themeColors: themeColors),
      actions: actions,
    );
  }
}
