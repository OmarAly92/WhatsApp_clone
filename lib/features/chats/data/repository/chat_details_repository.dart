import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whats_app_clone/core/networking/model/user_model/user_model.dart';

import '../../../../core/networking/model/chat_model/message_model.dart';
import '../data_source/chats/chat_details_requests.dart';

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
    required String sortedNumbers,
    required MessageModel messageModel,
  }) async {
    chatDetailsRequests.sendMessage(
      sortedNumbers:  sortedNumbers,
      messageModel: messageModel,
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

  Stream<List<UserModel>> getUserInfo({
    required String email,
  }) {
    final rawUserInfo = chatDetailsRequests.getUserInfo(email: email);
    return rawUserInfo.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromQueryDocumentSnapshot(doc)).toList();
    });
  }


}
