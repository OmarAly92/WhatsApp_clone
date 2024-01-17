part of 'message_bubble.dart';

class _MessageBubbleBodyComponent extends StatelessWidget {
  const _MessageBubbleBodyComponent({
    required this.themeColors,
    required this.isTheSender,
    required this.message,
    required this.time,
    required this.isTheFirst,
  });

  final ThemeColors themeColors;
  final bool isTheSender;
  final bool isTheFirst;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isTheFirst
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
      decoration: BoxDecoration(color: isTheSender ? themeColors.myMessage : themeColors.hisMessage),
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
                    color: isTheSender ? themeColors.myMessageTime : themeColors.hisMessageTime,
                  ),
                ),
                isTheSender
                    ? Icon(Icons.done, size: 17, color: themeColors.myMessageTime)
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
