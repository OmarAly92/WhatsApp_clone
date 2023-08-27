import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/auth/view_model/authentication_cubit.dart';

import '../../features/auth/view/otp_screen.dart';
import '../../features/auth/view/phone_auth_screen.dart';
import '../../features/auth/view/welcome_screen.dart';
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
  late final GoRouter goRouter;


  AppRouter() {

    FirebaseAuth.instance.authStateChanges().listen((user) {
      String initialScreen;

      if (user == null) {
        initialScreen = '/welcomeScreen';
      } else {
        initialScreen = '/homeScreen';
      }

      goRouter =  GoRouter(
        initialLocation: initialScreen,
        routes: <RouteBase>[
          GoRoute(
            path: phoneAuthScreen,
            builder: (context, state) {
              bool isDarkMode = _checkThemeMode(context);
              return BlocProvider<AuthenticationCubit>.value(
                value: authenticationCubit,
                child: PhoneAuthScreen(
                  themeColors: ThemeColors(isDarkMode: isDarkMode),
                ),
              );
            },
          ),
          GoRoute(
            path: otpScreen,
            builder: (context, state) {
              bool isDarkMode = _checkThemeMode(context);
              return BlocProvider<AuthenticationCubit>.value(
                value: authenticationCubit,
                child: OtpScreen(
                  themeColors: ThemeColors(isDarkMode: isDarkMode),
                  phoneNumber: state.extra as String,
                ),
              );
            },
          ),
          GoRoute(
            path: homeScreen,
            builder: (context, state) {
              bool isDarkMode = _checkThemeMode(context);
              return BlocProvider.value(
                value: chatsCubit,
                child: HomeScreen(
                  themeColors: ThemeColors(isDarkMode: isDarkMode),
                ),
              );
            },
          ),
          GoRoute(
            path: chatDetailScreen,
            builder: (context, state) {
              bool isDarkMode = _checkThemeMode(context);
              return BlocProvider.value(
                value: chatsCubit,
                child: ChatDetailsScreen(
                  themeColors: ThemeColors(isDarkMode: isDarkMode),
                  chatIndex: state.extra as int,
                ),
              );
            },
          ),
          GoRoute(
            path: settingsScreen,
            builder: (context, state) {
              bool isDarkMode = _checkThemeMode(context);
              return SettingsScreen(
                themeColors: ThemeColors(isDarkMode: isDarkMode),
              );
            },
          ),
          GoRoute(
            path: welcomeScreen,
            builder: (context, state) {
              bool isDarkMode = _checkThemeMode(context);
              return WelcomeScreen(
                themeColors: ThemeColors(isDarkMode: isDarkMode),
              );
            },
          ),
        ],
      );

    });
    authenticationCubit = AuthenticationCubit();

  }

  ChatsCubit chatsCubit = ChatsCubit()..getContacts();



 static bool _checkThemeMode(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;
    return isDarkMode;
  }

}




