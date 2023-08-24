import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'chat_user_model.dart';
import 'message_model.dart';

class ChatModel extends Equatable {
  final String chatType;
  final List<ChatUser> users;
  final List<MessageModel> messages;

  const ChatModel({
    required this.chatType,
    required this.users,
    required this.messages,
  });

  static List<ChatModel> getOtherUser(
      String phoneNumber, List<ChatModel> chatModel) {
    List<ChatModel> chat = chatModel;
    for (int x = 0; x < chat.length; x++) {
      for (int i = 0; i < chat[x].users.length; i++) {
        if (chat[x].users[i].userPhone == phoneNumber) {
          chat[x].users.removeAt(i);
        } else {}
      }
    }
    return chat;
  }

  factory ChatModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    final List<MessageModel> messages = data['messages'] != null
        ? List<MessageModel>.from((data['messages'] as List<dynamic>)
            .map((e) => MessageModel.fromJson(e)))
        : [];

    final List<ChatUser> users = data['users'] != null
        ? List<ChatUser>.from(
            (data['users'] as List<dynamic>).map((e) => ChatUser.fromJson(e)))
        : [];

    return ChatModel(
      chatType: data['chatType'],
      users: users,
      messages: messages,
    );
  }

  @override
  List<Object> get props => [chatType, users, messages];
}
