import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:whats_app_clone/testing/test_widget.dart';

import 'core/themes/themes.dart';
import 'core/utils/app_router.dart';
import 'core/utils/dependency_injection.dart';
import 'features/home/logic/notification_cubit.dart';
import 'firebase_options.dart';

late String initialScreen;

void main() async {
  AwesomeNotifications().initialize(
    'resource://drawable/res_app_icon',
    [
      NotificationChannel(
        channelGroupKey: 'chats_channel_group',
        groupKey: 'chats_channel',
        groupSort: GroupSort.Asc,
        channelKey: 'chats_channel',
        channelName: 'chats',
        channelDescription: 'this channel for chats notifications',
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        defaultRingtoneType: DefaultRingtoneType.Ringtone,
        defaultColor: const Color(0xff00a884),
        ledColor: const Color(0xff00a884),
      ),
    ],
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.requestPermission();
  ServicesLocator.init();

  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user != null) {
      initialScreen = '/homeScreen';
    } else {
      initialScreen = '/welcomeScreen';
    }
  });

  runApp(MyApp(appRouter: sl()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) =>
            MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'WhatsApp Clone',
              themeMode: ThemeMode.system,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              onGenerateRoute: appRouter.generateRoute,
              initialRoute: initialScreen,
              // home: const TestWidget(),
            ),
      ),
    );
  }
}
