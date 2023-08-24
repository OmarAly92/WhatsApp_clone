import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

import '../../../../core/themes/text_style/text_styles.dart';

class MessageBubbleBody extends StatelessWidget {
  const MessageBubbleBody({
    super.key,
    required this.themeColors,
    required this.isTheSender,
    required this.message,
    required this.time,
  });

  final ThemeColors themeColors;
  final bool isTheSender;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 4.h,
        bottom: 2.h,
        left: isTheSender ? 9.w : 24.w,
        right: isTheSender ? 24.w : 9.w,
      ),
      decoration: BoxDecoration(
          color: isTheSender ? themeColors.myMessage : themeColors.hisMessage),
      child: Wrap(
        alignment: WrapAlignment.end,
        direction: Axis.horizontal,
        children: [
          Text(
            message,
            softWrap: true,
            style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: EdgeInsets.only(top: 7.h, left: 5.5.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: Styles.textStyle12.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isTheSender
                        ? themeColors.myMessageTime
                        : themeColors.hisMessageTime,
                  ),
                ),
                Icon(
                  Icons.done,
                  size: 17,
                  color: isTheSender
                      ? themeColors.myMessageTime
                      : themeColors.hisMessageTime,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
