import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatsModel extends Equatable {
  final String chatType;
  final List<dynamic> usersDocs;

  final List usersPhoneNumber;

  const ChatsModel({
    required this.chatType,
    required this.usersDocs,
    required this.usersPhoneNumber,
  });

  factory ChatsModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return ChatsModel(
      chatType: data['chatType'],
      usersPhoneNumber: data['usersPhoneNumber'],
      usersDocs: data['usersDocs'],
    );
  }

  @override
  List<Object?> get props => [
        chatType,
        usersDocs,
        usersPhoneNumber,
      ];
}
