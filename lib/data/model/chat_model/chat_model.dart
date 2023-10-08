import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:whats_app_clone/data/model/user_model/user_model.dart';

class ChatsModel extends Equatable {
  final String chatType;
  final String lastMessage;
  final Timestamp lastMessageTime;
  final List<DocumentReference<Map<String, dynamic>>> usersDocument;
  final UserModel? users;

  const ChatsModel({
    required this.chatType,
    required this.usersDocument,
    required this.lastMessage,
    required this.lastMessageTime,
    this.users,
  });

  factory ChatsModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ChatsModel(
      chatType: data['chatType'],
      usersDocument: List<DocumentReference<Map<String, dynamic>>>.from(data['users']),
      lastMessage: data['lastMessage'],
      lastMessageTime: data['lastMessageTime'],
    );
  }

  @override
  List<Object> get props => [
        chatType,
        lastMessage,
        lastMessageTime,
        usersDocument,
      ];
}
