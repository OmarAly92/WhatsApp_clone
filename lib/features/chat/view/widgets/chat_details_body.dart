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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Column(
        children: [
          SizedBox(height: 10),
          MessageBubble(themeColors: themeColors, isTheSender: false, message: 'ازيك كيف حالك؟',),
          MessageBubble(themeColors: themeColors, isTheSender: true, message: 'مرحبًا أحمد! أنا بخير، شكرًا. وأنت؟',),
        ],
      ),
          ChatTextFormAndMicButton(themeColors: themeColors),
        ],
      ),
    );
  }
}
