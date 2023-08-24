import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/theme_color.dart';
import 'message_bubble_body.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.themeColors,
    required this.isTheSender,
    required this.message,
    required this.time,
  }) : super(key: key);
  final ThemeColors themeColors;
  final bool isTheSender;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Align(
        alignment: isTheSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: isTheSender
              ? const EdgeInsets.only(left: 40)
              : const EdgeInsets.only(right: 40),
          child: ClipPath(
            clipper: UpperNipMessageClipperTwo(
                isTheSender ? MessageType.send : MessageType.receive),
            child: MessageBubbleBody(
                themeColors: themeColors,
                isTheSender: isTheSender,
                message: message, time: time,),
          ),
        ),
      ),
    );
  }
}
