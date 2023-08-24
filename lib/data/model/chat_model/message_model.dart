import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final bool isSeen;
  final String message;
  final String time;
  final String theSender;

  const MessageModel({
    required this.isSeen,
    required this.message,
    required this.time,
    required this.theSender,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      isSeen: json['isSeen'],
      message: json['message'],
      time: json['time'],
      theSender: json['theSender'],
    );
  }

  @override
  List<Object> get props => [isSeen, message, time, theSender];
}
