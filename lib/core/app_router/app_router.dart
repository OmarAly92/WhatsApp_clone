import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

import '../../features/chat/view/chat_details_screen.dart';
import '../../features/home/tab_bar_view.dart';
import '../../features/settings/view/settings_screen.dart';

abstract class AppRouter {
  static const String homeScreen = '/';
  static const String chatDetail = '/chatDetail';
  static const String settingsScreen = '/settingsScreen';

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            return HomeScreen(
              themeColors: ThemeColors(isDarkMode: isDarkMode),
            );
          },
        );
      case chatDetail:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            return ChatDetailsScreen(
              themeColors: ThemeColors(isDarkMode: isDarkMode),
            );
          },
        );
      case settingsScreen:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);

            return SettingsScreen(
                themeColors: ThemeColors(isDarkMode: isDarkMode));
          },
        );
    }
    return null;
  }

  static bool _checkThemeMode(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;
    return isDarkMode;
  }
}
