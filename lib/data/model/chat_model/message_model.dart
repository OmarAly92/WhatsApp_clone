import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final bool isSeen;
  final String message;
  final Timestamp time;
  final String theSender;
  final String type;

  const MessageModel({
    required this.isSeen,
    required this.message,
    required this.time,
    required this.theSender,
    required this.type,
  });

  factory MessageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return MessageModel(
      isSeen: data['isSeen'],
      message: data['message'],
      time: data['time'],
      type: data['type'],
      theSender: data['theSender'],
    );
  }

  @override
  List<Object> get props => [isSeen, message, time, theSender];
}
