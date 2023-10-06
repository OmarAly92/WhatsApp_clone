import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/chats/view/widgets/custom_bubble_parent.dart';

class VoiceBubble extends StatelessWidget {
  const VoiceBubble({
    Key? key,
    required this.themeColors,
    required this.isTheSender,
    required this.voice,
    required this.isFirstMessage,
  }) : super(key: key);
  final ThemeColors themeColors;
  final bool isTheSender;
  final bool isFirstMessage;
  final String voice;

  @override
  Widget build(BuildContext context) {
    return CustomBubbleParent(
      themeColors: themeColors,
      isTheSender: isTheSender,
      isFirstMessage: isFirstMessage,
      widgetBubbleBody:SizedBox()

      // VoiceMessage(
      //   audioSrc: voice,
      //   played: false,
      //   me: isTheSender,
      //   onPlay: () {},
      //   meBgColor: isTheSender ? themeColors.myMessage : themeColors.hisMessage,
      //   meFgColor: Colors.white,
      //   // showDuration: true,
      // ),
    );
  }
}
