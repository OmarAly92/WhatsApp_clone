import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/features/chats/view/widgets/chat_details_screen_widgets/custom_bubble_parent.dart';

import '../../../../../../core/themes/text_style/text_styles.dart';
import '../../../../../../core/themes/theme_color.dart';

part 'message_bubble_body.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.themeColors,
    required this.isTheSender,
    required this.message,
    required this.time,
    required this.isFirstMessage,
    required this.backgroundBlendMode,
  }) : super(key: key);
  final ThemeColors themeColors;
  final bool isTheSender;
  final String message;
  final String time;
  final bool isFirstMessage;
  final BlendMode backgroundBlendMode;

  @override
  Widget build(BuildContext context) {
    return CustomBubbleParent(
      isFirstMessage: isFirstMessage,
      themeColors: themeColors,
      isTheSender: isTheSender,
      widgetBubbleBody: _MessageBubbleBodyComponent(
        isTheFirst: isFirstMessage,
        themeColors: themeColors,
        isTheSender: isTheSender,
        message: message,
        time: time,
        backgroundBlendMode: backgroundBlendMode,
      ),
    );
  }
}
