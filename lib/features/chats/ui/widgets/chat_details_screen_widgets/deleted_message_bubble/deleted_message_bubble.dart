import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/themes/text_style/text_styles.dart';
import '../../../../../../core/themes/theme_color.dart';
import '../custom_bubble_parent.dart';

part 'deleted_message_bubble_body.dart';

class DeletedMessageBubble extends StatelessWidget {
  const DeletedMessageBubble({
    Key? key,
    required this.message,
    required this.time,
    required this.isTheSender,
    required this.isFirstMessage,
    required this.themeColors,
    required this.backgroundBlendMode,
  }) : super(key: key);
  final String message;
  final String time;
  final bool isTheSender;
  final bool isFirstMessage;
  final ThemeColors themeColors;
  final BlendMode backgroundBlendMode;

  @override
  Widget build(BuildContext context) {
    return CustomBubbleParent(
      themeColors: themeColors,
      isTheSender: isTheSender,
      isFirstMessage: isFirstMessage,
      widgetBubbleBody: _DeletedMessageBubbleBody(
        themeColors: themeColors,
        isTheSender: isTheSender,
        isFirstMessage: isFirstMessage,
        message: message,
        time: time,
        backgroundBlendMode: backgroundBlendMode,
      ),
    );
  }
}
