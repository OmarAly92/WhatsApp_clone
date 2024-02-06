import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial()) {
    initNotifications();
  }

  int _id = 1;

  final _firebaseMessaging = FirebaseMessaging.instance;

  void initNotifications() {
    _initPushNotification();
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    emit(NotificationReceived(data: message.data));
    _id += _id;
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          groupKey: 'chats_channel',
          id: _id,
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

  void _handleMessage(RemoteMessage? message) {
    if (message == null) return;
    if (message.data['path'] == 'chatDetail') {}
  }

  Future _initPushNotification() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _firebaseMessaging.getInitialMessage().then(
          (message) => _handleMessage(message),
        );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) => _handleMessage(message),
    );
    FirebaseMessaging.onMessage.listen((message) {
      emit(NotificationReceived(data: message.data));

      AwesomeNotifications().createNotification(
          content: NotificationContent(
            groupKey: 'chats_channel',
            id: 2,
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

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
