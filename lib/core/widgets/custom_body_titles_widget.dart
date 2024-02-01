import 'package:flutter/cupertino.dart';

import '../themes/theme_color.dart';

class CustomBodyTitlesWidget extends StatelessWidget {
  const CustomBodyTitlesWidget({
    super.key,
    required this.textTitle,
    required this.textSubTitle,
    required this.themeColors,
  });

  final Widget textTitle;
  final Widget textSubTitle;
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [textTitle, textSubTitle],
    );
  }
}
