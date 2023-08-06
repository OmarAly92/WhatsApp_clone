import 'package:flutter/material.dart';

import '../../../../core/themes/text_style/text_styles.dart';
import '../../../../core/themes/theme_color.dart';

class ChatItemBody extends StatelessWidget {
  const ChatItemBody({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Omar Aly (You)', style: Styles.textStyle16),
              Text(
                'Yesterday',
                style: Styles.textStyle12.copyWith(
                  color: themeColors.bodyTextColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tmm',
                style: Styles.textStyle14.copyWith(
                  color: themeColors.bodyTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
