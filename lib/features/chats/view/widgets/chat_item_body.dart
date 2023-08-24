import 'package:flutter/material.dart';

import '../../../../core/themes/text_style/text_styles.dart';
import '../../../../core/themes/theme_color.dart';

class ChatItemBody extends StatelessWidget {
  const ChatItemBody({
    super.key,
    required this.themeColors, required this.contactName, required this.time, required this.lastMessage,
  });

  final ThemeColors themeColors;
  final String contactName;
  final String time;
  final String lastMessage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(contactName, style: Styles.textStyle16),
              Text(
                time,
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
                lastMessage,
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
