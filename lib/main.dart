import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/app_router/app_router.dart';
import 'package:whats_app_clone/core/dependency_injection/get_it.dart';

import 'core/themes/themes.dart';
import 'firebase_options.dart';

late String initialScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var result = await FlutterNotificationChannel.registerNotificationChannel(
    description: 'Your channel description',
    id: 'chat',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'Chat',
    visibility: NotificationVisibility.VISIBILITY_PUBLIC,
    allowBubbles: true,
    enableVibration: true,
    enableSound: true,
    showBadge: true,
  );
  print(result);
  ServicesLocator.init();

  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      initialScreen = '/welcomeScreen';
    } else {
      initialScreen = '/homeScreen';
    }
  });

  runApp(MyApp(appRouter: sl()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WhatsApp Clone',
        themeMode: ThemeMode.system,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: initialScreen,
        // home: MyTest(themeColors: ThemeColors(isDarkMode: true)),
      ),
    );
  }
}
