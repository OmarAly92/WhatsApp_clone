import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/view/otp_screen.dart';
import '../../features/auth/view/phone_auth_screen.dart';
import '../../features/auth/view/welcome_screen.dart';
import '../../features/auth/view_model/authentication_cubit.dart';
import '../../features/chats/view/chat_details_screen.dart';
import '../../features/chats/view/select_contact_screen.dart';
import '../../features/chats/view_model/chat_details_cubit/chat_detail_parent_cubit.dart';
import '../../features/chats/view_model/chat_details_cubit/get_messages/get_messages_cubit.dart';
import '../../features/chats/view_model/chat_details_cubit/send_messages/send_messages_cubit.dart';
import '../../features/chats/view_model/select_contact_cubit/select_contact_cubit.dart';
import '../../features/home/tab_bar_view.dart';
import '../../features/settings/view/profile_screen.dart';
import '../../features/settings/view/settings_screen.dart';
import '../../features/settings/view_model/settings_cubit.dart';
import '../dependency_injection/get_it.dart';
import '../themes/theme_color.dart';

class AppRouter {
  static const String welcomeScreen = '/welcomeScreen';
  static const String homeScreen = '/homeScreen';
  static const String selectContactScreen = '/selectContactScreen';
  static const String phoneAuthScreen = '/phoneAuthScreen';
  static const String otpScreen = '/otpScreen';
  static const String chatDetailScreen = '/chatDetailScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String profileScreen = '/profileScreen';

  late final AuthenticationCubit authenticationCubit;
  late final GetMessagesCubit getMessagesCubit;
  late final ChatDetailParentCubit chatDetailParentCubit;
  late final SendMessagesCubit sendMessagesCubit;

  AppRouter() {
    authenticationCubit = AuthenticationCubit();
    getMessagesCubit = GetMessagesCubit(sl());
    chatDetailParentCubit = ChatDetailParentCubit();
    sendMessagesCubit = SendMessagesCubit(sl());
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
                BlocProvider(create: (context) => chatDetailParentCubit),
              ],
              child: ChatDetailsScreen(
                themeColors: ThemeColors(isDarkMode: isDarkMode),
                hisPhoneNumber: arguments['hisPhoneNumber'],
                hisProfilePicture: arguments['hisPicture'],
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
      case selectContactScreen:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            return BlocProvider(
              create: (context) => SelectContactCubit(sl())..sortingContactData(),
              child: SelectContactScreen(themeColors: ThemeColors(isDarkMode: isDarkMode)),
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
