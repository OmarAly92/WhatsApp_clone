part of 'whats_app_ text_form_and_mic_button.dart';

class _ChatTextFormPrefixIcon extends StatelessWidget {
  const _ChatTextFormPrefixIcon({
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {

      },
      icon: Icon(CupertinoIcons.smiley_fill, color: themeColors.bodyTextColor),
    );
  }
}
