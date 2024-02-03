import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../user_model/user_model.dart';

class ChatsModel extends Equatable {
  final String chatType;
  final Map<String, UserModel> usersData;
  final List usersPhoneNumber;


  const ChatsModel({
    required this.chatType,
    required this.usersData,
    required this.usersPhoneNumber,
  });

  factory ChatsModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    Map<String, UserModel> usersData = (data['usersData'] as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, UserModel.fromJson(value as Map<String, dynamic>)));

    return ChatsModel(
      chatType: data['chatType'],
      usersPhoneNumber: data['usersPhoneNumber'],
      usersData: usersData,
    );
  }

  @override
  List<Object?> get props => [
        chatType,
        usersData,
        usersPhoneNumber,
      ];
}
