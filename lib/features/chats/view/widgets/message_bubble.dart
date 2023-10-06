import 'package:flutter/material.dart';
import 'package:whats_app_clone/features/chats/view/widgets/custom_bubble_parent.dart';

import '../../../../core/themes/theme_color.dart';
import 'message_bubble_body.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.themeColors,
    required this.isTheSender,
    required this.message,
    required this.time,
    required this.isFirstMessage,
  }) : super(key: key);
  final ThemeColors themeColors;
  final bool isTheSender;
  final String message;
  final String time;
  final bool isFirstMessage;

  @override
  Widget build(BuildContext context) {
    return CustomBubbleParent(
      isFirstMessage: isFirstMessage,
      themeColors: themeColors,
      isTheSender: isTheSender,
      widgetBubbleBody: MessageBubbleBody(
        isTheFirst: isFirstMessage,
        themeColors: themeColors,
        isTheSender: isTheSender,
        message: message,
        time: time,
      ),
    );
  }
}
