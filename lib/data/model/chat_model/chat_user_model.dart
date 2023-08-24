import 'package:equatable/equatable.dart';

class ChatUser extends Equatable {
  final String userId;
  final String userName;
  final String userPhone;

  const ChatUser({
    required this.userId,
    required this.userName,
    required this.userPhone,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      userId: json['userId'],
      userName: json['userName'],
      userPhone: json['userPhone'],
    );
  }

  @override
  List<Object> get props => [userId, userName, userPhone];
}
