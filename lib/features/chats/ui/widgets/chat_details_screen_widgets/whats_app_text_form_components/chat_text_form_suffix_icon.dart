part of 'whats_app_ text_form_and_mic_button.dart';

class _ChatTextFormSuffixIcon extends StatelessWidget {
  const _ChatTextFormSuffixIcon({
    required this.themeColors,
    required this.hisUserModel,
  });

  final ThemeColors themeColors;
  final UserModel hisUserModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              showCupertinoModalPopup(
                barrierColor: Colors.transparent,
                context: context,
                builder: (context) => BlocProvider(
                  create: (context) => SendMessagesCubit(sl()),
                  child: ClipButtonPopUp(
                    themeColors: themeColors,
                    hisUserModel: hisUserModel,
                  ),
                ),
              );
            },
            icon: Icon(
              CupertinoIcons.paperclip,
              color: themeColors.bodyTextColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.camera_alt_rounded,
              color: themeColors.bodyTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
