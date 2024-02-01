part of '../../login_screen.dart';

class _CircleImage extends StatelessWidget {
  const _CircleImage({required this.themeColors});

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 275.r,
      height: 275.r,
      margin: EdgeInsets.symmetric(vertical: 30.h),
      child: Image(
        image: const AssetImage(kWelcomeImage),
        color: themeColors.greenButton,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
