import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  ///this for all message bubbles
  final String isSeen;
  final String emojiReact;
  final String message;
  final Timestamp time;
  final String theSender;
  final String senderName;
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
    required this.emojiReact,
    required this.message,
    required this.time,
    required this.messageId,
    required this.theSender,
    required this.senderName,
    required this.type,
    required this.waveData,
    required this.maxDuration,
    required this.originalMessage,
    required this.replyOriginalName,
  });

  factory MessageModel.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();

    return MessageModel(
      isSeen: data['isSeen'].toString(),
      message: data['message'] ?? '',
      time: data['time'],
      type: data['type'],
      theSender: data['theSender'],
      senderName:  data['senderName']??'',
      waveData: data['waveData'] ?? [],
      maxDuration: data['maxDuration'] ?? 0,
      messageId: data['messageId'] ?? '',
      originalMessage: data['originalMessage'] ?? '',
      replyOriginalName: data['replyOriginalName'] ?? '',
      emojiReact: data['emojiReact'] ?? '',
    );
  }

  @override
  List<Object> get props => [
        isSeen,
        emojiReact,
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
