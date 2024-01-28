import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/functions/global_functions.dart';
import 'package:whats_app_clone/data/model/chat_model/message_model.dart';

import '../../../../../../core/themes/text_style/text_styles.dart';
import '../../../../../../core/themes/theme_color.dart';
import '../custom_bubble_parent.dart';

part 'message_bubble_body.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.themeColors,
    required this.isTheSender,
    required this.isFirstMessage,
    required this.backgroundBlendMode, required this.messageModel,
  }) : super(key: key);
  final ThemeColors themeColors;
  final bool isTheSender;
  final MessageModel messageModel;
  final bool isFirstMessage;
  final BlendMode backgroundBlendMode;

  @override
  Widget build(BuildContext context) {
    return CustomBubbleParent(
      isFirstMessage: isFirstMessage,
      themeColors: themeColors,
      isTheSender: isTheSender,
      widgetBubbleBody: _MessageBubbleBodyComponent(
        isFirstMessage: isFirstMessage,
        themeColors: themeColors,
        isTheSender: isTheSender,

        backgroundBlendMode: backgroundBlendMode, messageModel: messageModel,
      ),
    );
  }
}
