import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/auth/view/otp_screen.dart';
import 'package:whats_app_clone/features/auth/view/welcome_screen.dart';
import 'package:whats_app_clone/features/auth/view_model/authentication_cubit.dart';

import '../../features/auth/view/phone_auth_screen.dart';
import '../../features/chats/view/chat_details_screen.dart';
import '../../features/chats/view_model/chats_cubit/chats_cubit.dart';
import '../../features/home/tab_bar_view.dart';
import '../../features/settings/view/settings_screen.dart';

class AppRouter {
  static const String welcomeScreen = '/welcomeScreen';
  static const String homeScreen = '/homeScreen';
  static const String phoneAuthScreen = '/phoneAuthScreen';
  static const String otpScreen = '/otpScreen';
  static const String chatDetailScreen = '/chatDetailScreen';
  static const String settingsScreen = '/settingsScreen';

  late final AuthenticationCubit authenticationCubit;

  AppRouter() {
    authenticationCubit = AuthenticationCubit();
  }

  ChatsCubit chatsCubit = ChatsCubit()..getContacts();

  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case phoneAuthScreen:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            return BlocProvider<AuthenticationCubit>.value(
              value: authenticationCubit,
              child: PhoneAuthScreen(
                themeColors: ThemeColors(isDarkMode: isDarkMode),
              ),
            );
          },
        );
      case otpScreen:
        final String phoneNumber = settings.arguments.toString();
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            return BlocProvider<AuthenticationCubit>.value(
              value: authenticationCubit,
              child: OtpScreen(
                themeColors: ThemeColors(isDarkMode: isDarkMode),
                phoneNumber: phoneNumber,
              ),
            );
          },
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            return BlocProvider.value(
              value: chatsCubit,
              child: HomeScreen(
                themeColors: ThemeColors(isDarkMode: isDarkMode),
              ),
            );
          },
        );
      case chatDetailScreen:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            final int chatIndex = settings.arguments as int;
            return BlocProvider.value(
              value: chatsCubit,
              child: ChatDetailsScreen(
                themeColors: ThemeColors(isDarkMode: isDarkMode),
                chatIndex: chatIndex,
              ),
            );
          },
        );
      case settingsScreen:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            return SettingsScreen(
              themeColors: ThemeColors(isDarkMode: isDarkMode),
            );
          },
        );
      case welcomeScreen:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            return WelcomeScreen(
              themeColors: ThemeColors(isDarkMode: isDarkMode),
            );
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
