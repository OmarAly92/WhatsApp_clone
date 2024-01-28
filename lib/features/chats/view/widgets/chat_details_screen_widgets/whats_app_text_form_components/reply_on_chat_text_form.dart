import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/data/model/chat_model/message_model.dart';
import 'package:whats_app_clone/features/chats/view_model/chat_details_cubit/chat_detail_parent_cubit.dart';

import '../../../../../../core/functions/global_functions.dart';
import '../../../../../../core/themes/text_style/text_styles.dart';
import '../../../../../../core/themes/theme_color.dart';

class ReplyOnChatTextForm extends StatelessWidget {
  const ReplyOnChatTextForm({
    super.key,
    required this.themeColors,
    required this.replyOriginalMessage,
    required this.replyName,
    required this.replyColor,
  });

  final ThemeColors themeColors;
  final MessageModel replyOriginalMessage;
  final String replyName;
  final Color replyColor;

  @override
  Widget build(BuildContext context) {
    final Color replyBackgroundColor = themeColors.hisReplyMessage;
    return Container(
      margin: EdgeInsets.only(top: 6.h, right: 6.w, left: 6.w),
      padding: EdgeInsets.only(left: 4.w),
      decoration: BoxDecoration(
        color: replyColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Container(
        padding: EdgeInsets.only(right: 5.w, left: 10.w, bottom: 5.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: replyBackgroundColor,
            width: 1.89.r,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.r),
            bottomRight: Radius.circular(8.r),
          ),
          color: replyBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 3.h, bottom: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    replyName,
                    style: Styles.textStyle14.copyWith(fontSize: 13.spMin, color: replyColor),
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<ChatDetailParentCubit>(context).closeReplyMessage();
                    },
                    child: Icon(
                      CupertinoIcons.xmark,
                      size: 13.r,
                      color: themeColors.bodyTextColor,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 180),
              alignment: AlignmentDirectional.bottomStart,
              child: OriginalMessageTextComponent(
                messageModel: replyOriginalMessage,
                themeColors: themeColors,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OriginalMessageTextComponent extends StatelessWidget {
  const OriginalMessageTextComponent({
    super.key,
    required this.messageModel,
    required this.themeColors,
  });

  final MessageModel messageModel;
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    if (messageModel.message.contains('image')) {
      return Row(
        children: [
          SizedBox(width: 2.w),
          Icon(
            Icons.image_rounded,
            color: themeColors.replyOriginalMessageTextFormColor,
            size: 15.r,
          ),
          SizedBox(width: 2.w),
          Text(
            'Photo',
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w500,
              color: themeColors.replyOriginalMessageTextFormColor,
            ),
          ),
        ],
      );
    } else if (messageModel.message.contains('voice')) {
      return Row(
        children: [
          Icon(
            Icons.mic_rounded,
            color: themeColors.replyOriginalMessageTextFormColor,
            size: 15.r,
          ),
          SizedBox(width: 2.w),
          Text(
            'Voice message (${GlFunctions.timeFormatUsingMillisecond(messageModel.maxDuration)})',
            style: Styles.textStyle14.copyWith(
              color: themeColors.replyOriginalMessageTextFormColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else {
      return Text(
        messageModel.message,
        style: Styles.textStyle14.copyWith(
          color: themeColors.replyOriginalMessageTextFormColor,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}
