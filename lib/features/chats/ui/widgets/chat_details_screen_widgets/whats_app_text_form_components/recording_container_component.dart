part of 'whats_app_ text_form_and_mic_button.dart';

class _RecordingContainerComponent extends StatelessWidget {
  const _RecordingContainerComponent({
    required this.themeColors,
    required this.redMicIcon,
    required this.recordTimeText,
  });

  final ThemeColors themeColors;
  final Color redMicIcon;
  final String recordTimeText;
  static const Color grey = Color(0xFF8c959b);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 43.h,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: themeColors.hisMessage,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: AlignmentDirectional.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.mic,
                color: redMicIcon,
                size: 28,
              ),
              const SizedBox(width: 15),
              Text(
                recordTimeText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: grey,
                ),
              ),
            ],
          ),
          Row(
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedTextCustom(
                    speed: const Duration(milliseconds: 180),
                    '< Slide to cancel',
                    textStyle: TextStyle(
                      fontSize: 16.spMin,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Horizon',
                    ),
                    colors: [
                      themeColors.bodyTextColor,
                      themeColors.hisMessage,
                      themeColors.bodyTextColor,
                      themeColors.hisMessage,
                      themeColors.bodyTextColor,
                    ],
                  ),
                ],
                repeatForever: true,
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}
