import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/features/auth/logic/authentication_cubit.dart';

import '../../features/auth/logic/old/authentication_old_cubit.dart';
import '../../features/auth/logic/old/otp_screen.dart';
import '../../features/auth/logic/old/phone_auth_screen.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/auth/ui/sign_up_screen.dart';
import '../../features/auth/ui/welcome_screen.dart';
import '../../features/chats/logic/chat_details_cubit/chat_detail_parent_cubit.dart';
import '../../features/chats/logic/chat_details_cubit/get_messages/get_messages_cubit.dart';
import '../../features/chats/logic/chat_details_cubit/send_messages/send_messages_cubit.dart';
import '../../features/chats/logic/select_contact_cubit/select_contact_cubit.dart';
import '../../features/chats/ui/chat_details_screen.dart';
import '../../features/chats/ui/select_contact_screen.dart';
import '../../features/home/ui/tab_bar_view.dart';
import '../../features/settings/logic/settings_cubit.dart';
import '../../features/settings/ui/profile_screen.dart';
import '../../features/settings/ui/settings_screen.dart';
import '../dependency_injection/get_it.dart';
import '../themes/theme_color.dart';

class AppRouter {
  static const String welcomeScreen = '/welcomeScreen';
  static const String otpScreen = '/otpScreen';
  static const String phoneAuthScreen = '/phoneAuthScreen';

  static const String signUpScreen = '/signUpScreen';
  static const String loginScreen = '/loginScreen';

  static const String homeScreen = '/homeScreen';
  static const String selectContactScreen = '/selectContactScreen';
  static const String chatDetailScreen = '/chatDetailScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String profileScreen = '/profileScreen';

  late final AuthenticationOldCubit authenticationCubit;
  late final GetMessagesCubit getMessagesCubit;
  late final ChatDetailParentCubit chatDetailParentCubit;
  late final SendMessagesCubit sendMessagesCubit;

  AppRouter() {
    authenticationCubit = AuthenticationOldCubit();
    getMessagesCubit = GetMessagesCubit(sl());
    chatDetailParentCubit = ChatDetailParentCubit();
    sendMessagesCubit = SendMessagesCubit(sl());
  }

  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case phoneAuthScreen:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            return BlocProvider<AuthenticationOldCubit>.value(
              value: authenticationCubit,
              child: PhoneAuthScreen(
                themeColors: ThemeColors(isDarkMode: isDarkMode),
              ),
            );
          },
        );
      case signUpScreen:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            return BlocProvider(
              create: (context) => AuthenticationCubit(),
              child: SignUpScreen(
                themeColors: ThemeColors(isDarkMode: isDarkMode),
              ),
            );
          },
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            return BlocProvider(
              create: (context) => AuthenticationCubit(),
              child: LoginScreen(
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
            return BlocProvider<AuthenticationOldCubit>.value(
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
      case settingsScreen:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            return BlocProvider(
              create: (context) => SettingsCubit()..getSettingData(),
              child: SettingsScreen(
                themeColors: ThemeColors(isDarkMode: isDarkMode),
              ),
            );
          },
        );
      case profileScreen:
        return MaterialPageRoute(
          builder: (context) {
            bool isDarkMode = _checkThemeMode(context);
            return BlocProvider(
              create: (context) => SettingsCubit()..getSettingData(),
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
