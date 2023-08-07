import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/chat/view/widgets/chat_text_form_and_mic_button.dart';

import 'message_bubble.dart';

class ChatDetailsBody extends StatelessWidget {
  const ChatDetailsBody({Key? key, required this.themeColors})
      : super(key: key);
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(themeColors.chatBackGroundImage),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MessageBubble(themeColors: themeColors, isTheSender: true),
          MessageBubble(themeColors: themeColors, isTheSender: false),
          MessageBubble(themeColors: themeColors, isTheSender: true),
          MessageBubble(themeColors: themeColors, isTheSender: false),
          ChatTextFormAndMicButton(themeColors: themeColors),
        ],
      ),
    );
  }
}
