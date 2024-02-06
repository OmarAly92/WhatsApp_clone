part of 'notification_cubit.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationReceived extends NotificationState {
  final Map<String, dynamic> data;

  const NotificationReceived({required this.data});

  @override
  List<Object> get props => [data];
}
