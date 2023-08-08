import 'package:flutter/cupertino.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

class StatusItemBody extends StatelessWidget {
  const StatusItemBody({
    super.key,
    required this.textTitle,
    required this.textSubTitle,
    required this.themeColors,
  });

  final String textTitle;
  final String textSubTitle;
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(textTitle, style: Styles.textStyle16),
        Text(
          textSubTitle,
          style: Styles.textStyle14.copyWith(
            color: themeColors.bodyTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
