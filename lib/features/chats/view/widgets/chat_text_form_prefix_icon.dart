import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/theme_color.dart';

class ChatTextFormPrefixIcon extends StatelessWidget {
  const ChatTextFormPrefixIcon({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(CupertinoIcons.smiley_fill, color: themeColors.bodyTextColor),
    );
  }
}
