part of 'image_bubble.dart';

class _ImageBubbleBody extends StatelessWidget {
  const _ImageBubbleBody({
    required this.messageModel,
    required this.isTheSender,
    required this.themeColors,
    required this.backgroundBlendMode,
    required this.hisPhoneNumber,
  });

  final String hisPhoneNumber;
  final MessageModel messageModel;
  final bool isTheSender;
  final ThemeColors themeColors;
  final BlendMode backgroundBlendMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBubbleCubit, ImageBubbleState>(buildWhen: (previous, current) {
      if (current is ImageBubbleLoading) {
        return true;
      } else if (current is ImageBubbleImageExistence) {
        return true;
      } else if (current is ImageBubbleError) {
        return true;
      } else {
        return false;
      }
    }, builder: (context, state) {
      return Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: 250.h,
            width: 225.w,
            decoration: BoxDecoration(
              color: isTheSender ? themeColors.myMessage : themeColors.hisMessage,
              borderRadius: BorderRadius.circular(16.r),
              backgroundBlendMode: backgroundBlendMode,
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: CachedNetworkImage(
                  imageUrl: messageModel.message,
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 250),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 7.h, right: 10.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  GlFunctions.timeFormat(messageModel.time),
                  style: Styles.textStyle12.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isTheSender ? Colors.white : themeColors.hisMessageTime,
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
      );
    });
  }
}
