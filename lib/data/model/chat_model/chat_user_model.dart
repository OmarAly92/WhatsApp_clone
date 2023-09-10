import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatUser extends Equatable {
  final DocumentReference<Map<String, dynamic>> userDoc;

  const ChatUser({
    required this.userDoc,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      userDoc: json['userDoc'],
    );
  }

  @override
  List<Object> get props => [userDoc];
}