part of 'message_bubble.dart';

class _MessageBubbleBody extends StatelessWidget {
  const _MessageBubbleBody({
    required this.themeColors,
    required this.isTheSender,
    required this.isFirstMessage,
    required this.backgroundBlendMode,
    required this.messageModel,
  });

  final ThemeColors themeColors;
  final bool isTheSender;
  final bool isFirstMessage;
  final MessageModel messageModel;
  final BlendMode backgroundBlendMode;

  @override
  Widget build(BuildContext context) {
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
              left: isTheSender ? 9.w : 8.w,
              right: isTheSender ? 8.w : 9.w,
            ),
      decoration: BoxDecoration(
        color: isTheSender ? themeColors.myMessage : themeColors.hisMessage,
        backgroundBlendMode: backgroundBlendMode,
        // BlendMode.src => (original)
      ),
      child: Wrap(
        alignment: WrapAlignment.end,
        direction: Axis.horizontal,
        children: [
          Text(
            messageModel.message,
            softWrap: true,
            style: Styles.textStyle18().copyWith(fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: EdgeInsets.only(top: 7.h, left: 5.5.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  GlFunctions.timeFormat(messageModel.time),
                  style: Styles.textStyle14().copyWith(
                    fontWeight: FontWeight.w500,
                    color: isTheSender ? themeColors.myMessageTime : themeColors.hisMessageTime,
                  ),
                ),
                isTheSender
                    ? Icon(
                        messageModel.isSeen.isNotEmpty ? Icons.done_all_rounded : Icons.done_all_rounded,
                        size: 16.r,
                        color: messageModel.isSeen.isNotEmpty
                            ? themeColors.messageReadStatusColor
                            : themeColors.myMessageTime,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
