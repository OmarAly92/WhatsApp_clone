part of 'reply_bubble.dart';

class _ReplyBubbleBodyComponent extends StatelessWidget {
  const _ReplyBubbleBodyComponent({
    Key? key,
    required this.themeColors,
    required this.isTheSender,
    required this.isFirstMessage,
    required this.backgroundBlendMode,
    required this.messageModel,
    required this.time,
  }) : super(key: key);
  final ThemeColors themeColors;
  final bool isTheSender;
  final bool isFirstMessage;
  final MessageModel messageModel;
  final String time;
  final BlendMode backgroundBlendMode;

  @override
  Widget build(BuildContext context) {
    Color replyBackgroundColor = isTheSender ? themeColors.myReplyMessage : themeColors.hisReplyMessage;
    Color replyColor = messageModel.replyOriginalName == 'You' ? const Color(0xff068D72) : const Color(0xff8d7ed8);
    return Container(
      padding: isFirstMessage
          ? EdgeInsets.only(
              top: 4.h,
              bottom: 2.h,
              left: isTheSender ? 9.w : 24.w,
              right: isTheSender ? 24.w : 9.w,
            )
          : EdgeInsets.only(
              top: 4.h,
              bottom: 2.h,
              left: isTheSender ? 5.w : 8.w,
              right: isTheSender ? 5.w : 9.w,
            ),
      decoration: BoxDecoration(
        color: isTheSender ? themeColors.myMessage : themeColors.hisMessage,
        backgroundBlendMode: backgroundBlendMode,
        // BlendMode.src => (original)
      ),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(minWidth: 125.w),
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
                      child: Text(
                        messageModel.replyOriginalName,
                        style: Styles.textStyle14.copyWith(fontSize: 13.spMin, color: replyColor),
                      ),
                    ),
                    _OriginalMessageTextComponent(
                      messageModel: messageModel,
                      themeColors: themeColors,
                    ),
                    //45
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(
                    messageModel.message,
                    softWrap: true,
                    style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 7.h, left: 5.5.w),
                  child: Row(
                    children: [
                      Text(
                        time,
                        style: Styles.textStyle12.copyWith(
                          fontWeight: FontWeight.w500,
                          color: isTheSender ? themeColors.myMessageTime : themeColors.hisMessageTime,
                        ),
                      ),
                      isTheSender
                          ? Icon(
                              messageModel.isSeen.isNotEmpty ? Icons.done_all_rounded : Icons.done_all_rounded,
                              size: 17,
                              color: messageModel.isSeen.isNotEmpty
                                  ? const Color(0xff6fadc7)
                                  : themeColors.myMessageTime,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
