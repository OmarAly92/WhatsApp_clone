import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:whats_app_clone/data/model/user_model/user_model.dart';

import 'chat_user_model.dart';

class ChatsModel extends Equatable {
  final String chatType;
  final String lastMessage;
  final Timestamp lastMessageTime;
  final List<ChatUser> usersDocument;
  final UserModel? users;

  const ChatsModel({
    required this.chatType,
    required this.usersDocument,
    required this.lastMessage,
    required this.lastMessageTime,
    this.users,
  });

  static List<ChatsModel> getOtherUser(
      String phoneNumber, List<ChatsModel> chatModel) {
    List<ChatsModel> chat = chatModel;
    for (int x = 0; x < chat.length; x++) {
      for (int i = 0; i < chat[x].usersDocument.length; i++) {
        // if (chat[x].users[i].userPhone == phoneNumber) {
        //   chat[x].users.removeAt(i);
        // } else {}
      }
    }
    return chat;
  }

  factory ChatsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    final List<ChatUser> users = data['users'] != null
        ? List<ChatUser>.from(
            (data['users'] as List<dynamic>).map((e) => ChatUser.fromJson(e)))
        : [];

    // final List<UserModel> users = data['users'] != null
    //     ? List<UserModel>.from((data['users'] as List<dynamic>)
    //         .map((e) => UserModel.fromSnapshot(e)))
    //     : [];

    return ChatsModel(
      chatType: data['chatType'],
      usersDocument: users,
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
