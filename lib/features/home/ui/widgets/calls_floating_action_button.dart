import 'package:flutter/material.dart';

import '../../../../core/themes/theme_color.dart';


class CallsFloatingActionButton extends StatelessWidget {
  const CallsFloatingActionButton({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(
        Icons.add_call,
        color: themeColors.backgroundColor,
      ),
    );
  }
}
