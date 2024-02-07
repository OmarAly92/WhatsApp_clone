import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whats_app_clone/core/networking/model/user_model/user_model.dart';

import '../../../../core/networking/model/chat_model/message_model.dart';
import '../data_source/chats/chat_details_requests.dart';

class ChatDetailsRepository {
  final ChatDetailsRequests chatDetailsRequests;

  ChatDetailsRepository(this.chatDetailsRequests);



  Stream<List<MessageModel>> getMessages({required String hisPhoneNumber, required String myPhoneNumber}) {
    var chatSubCollection = chatDetailsRequests.getMessagesData(hisPhoneNumber, myPhoneNumber);
    return chatSubCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => MessageModel.fromSnapshot(doc)).toList();
    });
  }

  Future<void> globalSendMessage({
    required String sortedNumber,
    required UserModel myUserModel,
    required String hisPushToken,
    required MessageModel messageModel,
  }) async {
    chatDetailsRequests.globalSendingMessage(
      sortedNumber: sortedNumber,
      messageModel: messageModel,
      myUserModel: myUserModel,
      hisPushToken:hisPushToken,
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
    required String phoneNumber,
  }) {
    final rawUserInfo = chatDetailsRequests.getUserInfo(phoneNumber: phoneNumber);
    return rawUserInfo.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromQueryDocumentSnapshot(doc)).toList();
    });
  }


  Stream<dynamic> getHisPushToken({required String phoneNumber}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .snapshots()
        .map((snapshot) => snapshot['pushToken']);
  }
}
