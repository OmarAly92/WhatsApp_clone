import 'package:flutter/material.dart';

import '../../../../core/themes/theme_color.dart';

import 'calls_floating_action_button.dart';
import 'chats_floating_action_button.dart';
import 'updates_floating_action_button.dart';

class TabsFloatingActionButton extends StatelessWidget {
  const TabsFloatingActionButton({
    super.key,
    required this.currentPageIndex ,
    required this.themeColors,
  }) ;

  final int currentPageIndex;
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    if (currentPageIndex == 0) {
      return ChatsFloatingActionButton(themeColors: themeColors);
    } else if (currentPageIndex == 1) {
      return UpdatesFloatingActionButton(themeColors: themeColors);
    } else {
      return CallsFloatingActionButton(themeColors: themeColors);
    }
  }
}
