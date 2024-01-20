part of 'image_bubble.dart';

class _ImageBubbleBodyComponent extends StatelessWidget {
  const _ImageBubbleBodyComponent({
    required this.image,
    required this.isTheSender,
    required this.themeColors,
    required this.time, required this.backgroundBlendMode,
  });

  final String image;
  final String time;
  final bool isTheSender;
  final ThemeColors themeColors;
  final BlendMode backgroundBlendMode;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: 250.h,
          ),
          decoration: BoxDecoration(
            color: isTheSender ? themeColors.myMessage : themeColors.hisMessage,
            borderRadius: BorderRadius.circular(23),
            backgroundBlendMode: backgroundBlendMode,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: NetworkImage(image),
                fit: BoxFit.cover,
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
                time,
                style: Styles.textStyle12.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isTheSender ? Colors.white : themeColors.hisMessageTime,
                ),
              ),
              // Icon(
              //   Icons.done,
              //   size: 17,
              //   color: isTheSender ? Colors.white : themeColors.hisMessageTime,
              // ),
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
  }
}
