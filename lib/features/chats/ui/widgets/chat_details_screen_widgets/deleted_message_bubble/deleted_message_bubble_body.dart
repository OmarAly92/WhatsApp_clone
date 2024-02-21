part of 'deleted_message_bubble.dart';

class _DeletedMessageBubbleBody extends StatelessWidget {
  const _DeletedMessageBubbleBody({
    required this.themeColors,
    required this.isTheSender,
    required this.isFirstMessage,
    required this.message,
    required this.time,
    required this.backgroundBlendMode,
  });

  final ThemeColors themeColors;
  final bool isTheSender;
  final bool isFirstMessage;
  final String message;
  final String time;
  final BlendMode backgroundBlendMode;

  @override
  Widget build(BuildContext context) {
    const Color deletedMessageColor = Color(0xff7E8C95);
    return Container(
      padding: isFirstMessage
          ? EdgeInsets.only(
              top: 6.h,
              bottom: 4.h,
              left: isTheSender ? 9.w : 24.w,
              right: isTheSender ? 24.w : 9.w,
            )
          : EdgeInsets.only(
              top: 6.h,
              bottom: 4.h,
              left: isTheSender ? 9.w : 8.w,
              right: isTheSender ? 8.w : 9.w,
            ),
      decoration: BoxDecoration(
        color: isTheSender ? themeColors.myMessage : themeColors.hisMessage,
        backgroundBlendMode: backgroundBlendMode,
      ),
      child: Wrap(
        alignment: WrapAlignment.end,
        direction: Axis.horizontal,
        children: [
          Icon(
            Icons.not_interested,
            size: 21.r,
            color: deletedMessageColor,
          ),
          SizedBox(width: 4.w),
          Text(
            isTheSender ? 'You deleted this message' : 'This message was deleted',
            softWrap: true,
            style: Styles.textStyle18().copyWith(
              color: deletedMessageColor,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 7.h, left: 5.5.w),
            child: Text(
              time,
              style: Styles.textStyle14().copyWith(
                fontWeight: FontWeight.w500,
                color: isTheSender ? themeColors.myMessageTime : themeColors.hisMessageTime,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
