import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record/record.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/data/data_source/chats/chat_details_requests.dart';
import 'package:whats_app_clone/features/auth/view/otp_screen.dart';
import 'package:whats_app_clone/features/auth/view/welcome_screen.dart';
import 'package:whats_app_clone/features/auth/view_model/authentication_cubit.dart';
import 'package:whats_app_clone/features/chats/repository/chat_details_repository.dart';
import 'package:whats_app_clone/features/settings/view/profile_screen.dart';
import 'package:whats_app_clone/features/settings/view_model/settings_cubit.dart';

import '../../features/auth/view/phone_auth_screen.dart';
import '../../features/chats/view/chat_details_screen.dart';
import '../../features/chats/view_model/chat_details_cubit/get_messages/get_messages_cubit.dart';
import '../../features/chats/view_model/chat_details_cubit/send_messages/send_messages_cubit.dart';
import '../../features/home/tab_bar_view.dart';
import '../../features/settings/view/settings_screen.dart';

class AppRouter {
  static const String welcomeScreen = '/welcomeScreen';
  static const String homeScreen = '/homeScreen';
  static const String phoneAuthScreen = '/phoneAuthScreen';
  static const String otpScreen = '/otpScreen';
  static const String chatDetailScreen = '/chatDetailScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String profileScreen = '/profileScreen';

  late final AuthenticationCubit authenticationCubit;
  ChatDetailsRequests chatDetailsRequests = ChatDetailsRequests();
  late final ChatDetailsRepository chatDetailsRepository;
  late final GetMessagesCubit getMessagesCubit;
  late final SendMessagesCubit sendMessagesCubit;

  AppRouter() {
    authenticationCubit = AuthenticationCubit();
    chatDetailsRepository = ChatDetailsRepository(chatDetailsRequests);
    getMessagesCubit = GetMessagesCubit(chatDetailsRepository);
    sendMessagesCubit = SendMessagesCubit(chatDetailsRepository,Record());
  }

  SettingsCubit settingsCubit = SettingsCubit()..getSettingData();

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
            return HomeScreen(
              themeColors: ThemeColors(isDarkMode: isDarkMode),
            );
          },
        );
      case chatDetailScreen:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            final Map arguments = settings.arguments as Map;
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getMessagesCubit),
                BlocProvider(create: (context) => sendMessagesCubit),
              ],
              child: ChatDetailsScreen(
                themeColors: ThemeColors(isDarkMode: isDarkMode),
                hisPhoneNumber: arguments['hisPhoneNumber'],
                hisPicture: arguments['hisPicture'],
                hisName: arguments['hisName'],
              ),
            );
          },
        );
      case settingsScreen:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            return BlocProvider.value(
              value: settingsCubit,
              child: SettingsScreen(
                themeColors: ThemeColors(isDarkMode: isDarkMode),
              ),
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
      case profileScreen:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            return BlocProvider.value(
              value: settingsCubit,
              child: ProfileScreen(
                themeColors: ThemeColors(isDarkMode: isDarkMode),
              ),
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
