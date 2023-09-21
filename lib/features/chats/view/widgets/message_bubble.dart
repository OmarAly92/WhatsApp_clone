import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Padding(
      padding: isFirstMessage
          ? EdgeInsets.only(top: 5.h)
          : const EdgeInsets.symmetric(vertical: 0),
      child: Align(
        alignment: isTheSender ? Alignment.centerRight : Alignment.centerLeft,
        child: isFirstMessage
            ? Padding(
                padding: isTheSender
                    ? EdgeInsets.only(left: 38.w, top: 1.2.h, bottom: 1.2.h)
                    : EdgeInsets.only(right: 38.w, top: 1.2.h, bottom: 1.2.h),
                child: ClipPath(
                  clipper: UpperNipMessageClipperTwo(
                    isTheSender ? MessageType.send : MessageType.receive,
                  ),
                  child: MessageBubbleBody(
                    themeColors: themeColors,
                    isTheSender: isTheSender,
                    message: message,
                    time: time,
                    isTheFirst: isFirstMessage,
                  ),
                ),
              )
            : Padding(
                padding: isTheSender
                    ? EdgeInsets.only(
                        left: 38.w, right: 15.w, top: 1.2.h, bottom: 1.2.h)
                    : EdgeInsets.only(
                        right: 38.w, left: 15.w, top: 1.2.h, bottom: 1.2.h),
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9.r),
                    ),
                  ),
                  child: MessageBubbleBody(
                    themeColors: themeColors,
                    isTheSender: isTheSender,
                    message: message,
                    time: time,
                    isTheFirst: isFirstMessage,
                  ),
                ),
              ),
      ),
    );
  }
}
