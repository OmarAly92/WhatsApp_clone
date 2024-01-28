part of 'image_bubble.dart';

class _ImageBubbleBodyComponent extends StatelessWidget {
  const _ImageBubbleBodyComponent({
    required this.image,
    required this.isTheSender,
    required this.themeColors,
    required this.time,
    required this.backgroundBlendMode,
    required this.hisPhoneNumber,
  });

  final String image;
  final String hisPhoneNumber;
  final Timestamp time;
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
                  imageUrl: image,
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
                  GlFunctions.timeFormat(time),
                  style: Styles.textStyle12.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isTheSender ? Colors.white : themeColors.hisMessageTime,
                  ),
                ),
                isTheSender
                    ? Icon(
                        Icons.done,
                        size: 17,
                        color: themeColors.myMessageTime,
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
