part of 'whats_app_ text_form_and_mic_button.dart';

class _TextFormContainer extends StatelessWidget {
  const _TextFormContainer({
    required this.themeColors,
    required this.child,
  });

  final ThemeColors themeColors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 43.h,
      decoration: BoxDecoration(
        color: themeColors.hisMessage,
        borderRadius: BorderRadius.circular(30),
      ),
      // alignment: AlignmentDirectional.bottomCenter,
      child: child,
    );
  }
}
