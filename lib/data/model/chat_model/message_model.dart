import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  ///this for all message bubbles
  final bool isSeen;
  final String message;
  final Timestamp time;
  final String theSender;
  final String type;
  final String messageId;

  ///this for voice
  final int maxDuration;
  final List<dynamic> waveData;

  ///this for reply message
  final String originalMessage;
  final String replyOriginalName;

  const MessageModel({
    required this.isSeen,
    required this.message,
    required this.time,
    required this.messageId,
    required this.theSender,
    required this.type,
    required this.waveData,
    required this.maxDuration,
    required this.originalMessage,
    required this.replyOriginalName,
  });

  factory MessageModel.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();

    return MessageModel(
      isSeen: data['isSeen'],
      message: data['message'] ?? '',
      time: data['time'],
      type: data['type'],
      theSender: data['theSender'],
      waveData: data['waveData'] ?? [],
      maxDuration: data['maxDuration'] ?? 0,
      messageId: data['messageId'] ?? '',
      originalMessage: data['originalMessage'] ?? '',
      replyOriginalName: data['replyOriginalName'] ?? '',
    );
  }

  @override
  List<Object> get props => [
        isSeen,
        message,
        time,
        theSender,
        type,
        messageId,
        maxDuration,
        waveData,
        originalMessage,
        replyOriginalName,
      ];
}
