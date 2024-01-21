import 'package:flutter/material.dart';

import '../../../core/app_router/app_router.dart';
import '../../../core/themes/theme_color.dart';

class ChatsFloatingActionButton extends StatelessWidget {
  const ChatsFloatingActionButton({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, AppRouter.selectContactScreen);
      },
      child: Icon(
        Icons.message,
        color: themeColors.backgroundColor,
      ),
    );
  }
}
