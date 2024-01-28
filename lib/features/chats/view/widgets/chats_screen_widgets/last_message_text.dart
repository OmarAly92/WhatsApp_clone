import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/functions/global_functions.dart';
import '../../../../../core/themes/text_style/text_styles.dart';
import '../../../../../core/themes/theme_color.dart';
import '../../../view_model/chats_cubit/chats_cubit.dart';

class LastMessageText extends StatelessWidget {
  const LastMessageText({super.key, required this.state, required this.themeColors});

  final ListenToLastMessage state;
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    if (state.lastMessage.type == 'image') {
      return Row(
        children: [
          Icon(
            Icons.image_rounded,
            color: themeColors.bodyTextColor,
            // color: Color(0xff868d8f),
            size: 20.r,
          ),
          SizedBox(width: 2.w),
          Text(
            'Photo',
            style: Styles.textStyle14.copyWith(
              color: themeColors.bodyTextColor,
            ),
          ),
        ],
      );
    } else if (state.lastMessage.type == 'voice') {
      return Row(
        children: [
          Icon(
            Icons.mic_rounded,
            color: themeColors.bodyTextColor,
            // color: Color(0xff868d8f),
            size: 20.r,
          ),
          SizedBox(width: 2.w),
          Text(
            GlFunctions.timeFormatUsingMillisecond(state.lastMessage.maxDuration),
            style: Styles.textStyle14.copyWith(
              color: themeColors.bodyTextColor,
            ),
          ),
        ],
      );
    } else {
      return Text(
        state.lastMessage.message,
        style: Styles.textStyle14.copyWith(
          color: themeColors.bodyTextColor,
        ),
      );
    }
  }
}
