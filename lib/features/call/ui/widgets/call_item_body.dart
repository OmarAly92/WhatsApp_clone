import 'package:flutter/material.dart';
import '../../../../core/themes/text_style/text_styles.dart';
import '../../../../core/themes/theme_color.dart';



class CallItemBody extends StatelessWidget {
  const CallItemBody({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Eng Kareem😎',
          style: Styles.textStyle16.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.call_made,
              color: Color(0xff25bc63),
              size: 18,
            ),
            Text(
              'August 2, 11:45 PM',
              style: Styles.textStyle14.copyWith(
                color: themeColors.bodyTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
