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
      sortedNumbers: sortedNumbers,
      messageModel: messageModel,
    );
  }

  void sendImage({required String sortedNumber, required MessageModel messageModel}) async {
    chatDetailsRequests.sendImage(
      sortedNumber: sortedNumber,
      messageModel: messageModel,
    );
  }

  void sendVoice({required String sortedNumber, required MessageModel messageModel}) {
    chatDetailsRequests.sendVoice(
      sortedNumber: sortedNumber,
      messageModel: messageModel,
    );
  }

  Future<void> sendReplyMessage({
    required String sortedNumber,
    required MessageModel messageModel
  }) async {
    chatDetailsRequests.sendReplyMessage(
      sortedNumber: sortedNumber,
     messageModel: messageModel,
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
