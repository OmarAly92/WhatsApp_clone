part of 'reply_on_chat_text_form.dart';

class _OriginalMessageTextComponent extends StatelessWidget {
  const _OriginalMessageTextComponent({
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
            color: themeColors.replyOriginalMessageColor,
            size: 15.r,
          ),
          SizedBox(width: 2.w),
          Text(
            'Photo',
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w500,
              color: themeColors.replyOriginalMessageColor,
            ),
          ),
        ],
      );
    } else if (messageModel.message.contains('voice')) {
      return Row(
        children: [
          Icon(
            Icons.mic_rounded,
            color: themeColors.replyOriginalMessageColor,
            size: 15.r,
          ),
          SizedBox(width: 2.w),
          Text(
            'Voice message (${GlFunctions.timeFormatUsingMillisecond(messageModel.maxDuration)})',
            style: Styles.textStyle14.copyWith(
              color: themeColors.replyOriginalMessageColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else {
      return Text(
        messageModel.message,
        style: Styles.textStyle14.copyWith(
          color: themeColors.replyOriginalMessageColor,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}
