import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/global_functions.dart';
import '../../../../../core/themes/text_style/text_styles.dart';
import '../../../../../core/themes/theme_color.dart';
import '../../../logic/chats_cubit/chats_cubit.dart';

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
            style: Styles.textStyle16().copyWith(
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
            GlFunctions.timeFormatUsingMillisecondVoiceOnly(state.lastMessage.maxDuration),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Styles.textStyle16().copyWith(
              color: themeColors.bodyTextColor,
            ),
          ),
        ],
      );
    } else if (state.lastMessage.type == 'deleted') {
      return Row(
        children: [
          Icon(
            Icons.not_interested,
            color: themeColors.bodyTextColor,
            // color: Color(0xff868d8f),
            size: 20.r,
          ),
          SizedBox(width: 2.w),
          Text(
            'This message was deleted',
            overflow: TextOverflow.ellipsis,
            style: Styles.textStyle16().copyWith(
              color: themeColors.bodyTextColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      );
    } else {
      return Text(
        state.lastMessage.message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Styles.textStyle16().copyWith(
          color: themeColors.bodyTextColor,
        ),
      );
    }
  }
}
