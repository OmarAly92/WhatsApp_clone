
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/app_router/app_router.dart';
import 'core/networking/model/user_model/user_model.dart';

class FirebaseNotification {
  static int id = 1;

  static final _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    id += id;
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          groupKey: 'chats_channel',
          id: id,
          channelKey: 'chats_channel',
          title: message.data['title'],
          body: message.data['body'],
          category: NotificationCategory.Message,
          wakeUpScreen: true,
          fullScreenIntent: true,
          autoDismissible: false,
          color: const Color(0xff00A884),
          backgroundColor: const Color(0xff00A884),
        ),
        actionButtons: [
          NotificationActionButton(key: 'Reply', label: 'Reply'),
          NotificationActionButton(key: 'Mark as read', label: 'Mark as read'),
          NotificationActionButton(key: 'Mute', label: 'Mute'),
        ]);
  }

  static void handleMessage(RemoteMessage? message, BuildContext context) {
    if (message == null) return;
    if (message.data['path'] == 'chatDetail') {
      Navigator.pushNamed(
        context,
        AppRouter.chatDetailScreen,
        arguments: {
          'userModel': UserModel(
            isOnline: bool.parse(message.data['isOnline']),
            lastActive: int.parse(message.data['lastActive']),
            userId: message.data['userId'],
            pushToken: message.data['pushToken'],
            name: message.data['name'],
            email: message.data['email'],
            phoneNumber: message.data['phoneNumber'],
            profilePicture: message.data['profilePicture'],
          ),
        },
      );
    }
  }

  static Future _initPushNotification(BuildContext context) async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _firebaseMessaging.getInitialMessage().then(
      (message) {
        handleMessage(message, context);
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        handleMessage(message, context);
      },
    );
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      id += id;
      AwesomeNotifications().createNotification(
          content: NotificationContent(
            groupKey: 'chats_channel',
            id: id,
            channelKey: 'chats_channel',
            title: message.data['title'],
            body: message.data['body'],
            category: NotificationCategory.Message,
            wakeUpScreen: true,
            fullScreenIntent: true,
            autoDismissible: false,
            color: const Color(0xff00A884),
            backgroundColor: const Color(0xff00A884),

          ),
          actionButtons: [
            NotificationActionButton(key: 'Reply', label: 'Reply'),
            NotificationActionButton(key: 'Mark as read', label: 'Mark as read'),
            NotificationActionButton(key: 'Mute', label: 'Mute'),
          ]);
    });
  }

  static void initNotifications(BuildContext context) {
    _initPushNotification(context);
  }
}
