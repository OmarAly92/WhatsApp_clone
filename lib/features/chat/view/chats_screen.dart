import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/app_router/app_router.dart';

import '../../../../core/themes/theme_color.dart';
import 'widgets/chat_item.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key, required this.themeColors});

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, AppRouter.chatDetail),
          child: ChatItem(themeColors: themeColors),
        ),
      ],
    );
  }
}
