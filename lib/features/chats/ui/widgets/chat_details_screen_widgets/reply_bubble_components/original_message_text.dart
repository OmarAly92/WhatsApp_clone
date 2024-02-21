part of 'reply_bubble.dart';

class _OriginalMessageText extends StatelessWidget {
  const _OriginalMessageText({
    required this.messageModel,
    required this.themeColors,
  });

  final MessageModel messageModel;
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    if (messageModel.originalMessage.contains('image')) {
      return Row(
        children: [
          SizedBox(width: 2.w),
          Icon(
            Icons.image_rounded,
            color: themeColors.replyOriginalMessageColor,
            size: 15.r,
          ),
          SizedBox(width: 2.w),
          Text(
            'Photo',
            style: Styles.textStyle16().copyWith(
              color: themeColors.replyOriginalMessageColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    } else if (messageModel.originalMessage.contains('voice')) {
      return Row(
        children: [
          Icon(
            Icons.mic_rounded,
            color: themeColors.replyOriginalMessageColor,
            size: 15.r,
          ),
          SizedBox(width: 2.w),
          Text(
            'Voice message (${GlFunctions.timeFormatUsingMillisecondVoiceOnly(messageModel.maxDuration)})',
            style: Styles.textStyle16().copyWith(
              color: themeColors.replyOriginalMessageColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else {
      return Text(
        messageModel.originalMessage,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: Styles.textStyle16().copyWith(
          color: themeColors.replyOriginalMessageColor,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}
