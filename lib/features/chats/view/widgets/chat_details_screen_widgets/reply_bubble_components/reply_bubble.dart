import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/data/model/chat_model/message_model.dart';

import '../../../../../../core/themes/text_style/text_styles.dart';
import '../../../../../../core/themes/theme_color.dart';
import '../custom_bubble_parent.dart';

part 'reply_bubble_body_component.dart';

class ReplyBubble extends StatelessWidget {
  const ReplyBubble({
    Key? key,
    required this.themeColors,
    required this.isTheSender,
    required this.isFirstMessage,
    required this.backgroundBlendMode,
    required this.messageModel, required this.time,
  }) : super(key: key);
  final ThemeColors themeColors;
  final bool isTheSender;
  final MessageModel messageModel;
  final String time;

  final bool isFirstMessage;
  final BlendMode backgroundBlendMode;

  @override
  Widget build(BuildContext context) {
    return CustomBubbleParent(
      isFirstMessage: isFirstMessage,
      themeColors: themeColors,
      isTheSender: isTheSender,
      widgetBubbleBody: _ReplyBubbleBodyComponent(
        isFirstMessage: isFirstMessage,
        themeColors: themeColors,
        isTheSender: isTheSender,
        backgroundBlendMode: backgroundBlendMode,
        messageModel: messageModel, time: time,
      ),
    );
  }
}
