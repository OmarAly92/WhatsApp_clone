import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final bool isSeen;
  final String message;
  final Timestamp time;
  final String theSender;
  final String type;
  final List<dynamic> waveData;

  const MessageModel({
    required this.isSeen,
    required this.message,
    required this.time,
    required this.theSender,
    required this.type,
    required this.waveData,
  });

  factory MessageModel.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();

    return MessageModel(
      isSeen: data['isSeen'],
      message: data['message'],
      time: data['time'],
      type: data['type'],
      theSender: data['theSender'],
      waveData: data['waveData'] ?? [],
    );
  }

  @override
  List<Object> get props => [
        isSeen,
        message,
        time,
        theSender,
        type,
        waveData,
      ];
}
