import 'package:flutter/material.dart';

import '../../../core/themes/theme_color.dart';
import 'calls_floating_action_button.dart';
import 'chats_floating_action_button.dart';
import 'updates_floating_action_button.dart';

class TabsFloatingActionButton extends StatelessWidget {
  const TabsFloatingActionButton({
    super.key,
    required TabController tabController,
    required this.themeColors,
  }) : _tabController = tabController;

  final TabController _tabController;
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    if (_tabController.index == 0) {
      return ChatsFloatingActionButton(themeColors: themeColors);
    } else if (_tabController.index == 1) {
      return UpdatesFloatingActionButton(themeColors: themeColors);
    } else {
      return CallsFloatingActionButton(themeColors: themeColors);
    }
  }
}
