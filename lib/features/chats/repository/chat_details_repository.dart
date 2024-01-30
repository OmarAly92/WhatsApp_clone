import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/data_source/chats/chat_details_requests.dart';
import '../../../data/model/chat_model/message_model.dart';

class ChatDetailsRepository {
  final ChatDetailsRequests chatDetailsRequests;

  ChatDetailsRepository(this.chatDetailsRequests);

  var fireBaseInit = FirebaseFirestore.instance;

  Stream<List<MessageModel>> getMessages({required String hisPhoneNumber, required String myPhoneNumber}) {
    var chatSubCollection = chatDetailsRequests.getMessagesData(hisPhoneNumber, myPhoneNumber);
    return chatSubCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => MessageModel.fromSnapshot(doc)).toList();
    });
  }

  Future<void> sendMessage({
    required String phoneNumber,
    required String message,
    required String myPhoneNumber,
    required String type,
    required Timestamp time,
    required String messageId,
  }) async {
    chatDetailsRequests.sendMessage(
      phoneNumber: phoneNumber,
      message: message,
      myPhoneNumber: myPhoneNumber,
      type: type,
      time: time,
      messageId: messageId,
    );
  }

  void sendImage({
    required String phoneNumber,
    required String type,
    required String myPhoneNumber,
    required String imagePath,
    required Timestamp time,
    required String messageId,
  }) async {
    chatDetailsRequests.sendImage(
      phoneNumber: phoneNumber,
      type: type,
      myPhoneNumber: myPhoneNumber,
      imagePath: imagePath,
      time: time,
      messageId: messageId,
    );
  }

  void sendVoice({
    required String phoneNumber,
    required Timestamp time,
    required String type,
    required String myPhoneNumber,
    required String voicePath,
    required String messageId,
    required List<double> waveData,
    required int maxDuration,
  }) {
    chatDetailsRequests.sendVoice(
      phoneNumber: phoneNumber,
      time: time,
      type: type,
      myPhoneNumber: myPhoneNumber,
      voicePath: voicePath,
      messageId: messageId,
      waveData: waveData,
      maxDuration: maxDuration,
    );
  }

  Future<void> sendReplyMessage({
    required String phoneNumber,
    required String originalMessage,
    required String message,
    required String replyOriginalName,
    required String theSenderNumber,
    required String type,
    required Timestamp time,
    required String messageId,
  }) async {
    chatDetailsRequests.sendReplyMessage(
      phoneNumber: phoneNumber,
      originalMessage: originalMessage,
      message: message,
      theSender: theSenderNumber,
      type: type,
      time: time,
      messageId: messageId,
      replyOriginalName: replyOriginalName,
    );
  }

  Future<void> updateMessageReadStatus({
    required String chatDocId,
    required String messageId,
  }) async {
    await chatDetailsRequests.updateMessageReadStatus(
      chatDocId: chatDocId,
      messageId: messageId,
    );
  }
}
