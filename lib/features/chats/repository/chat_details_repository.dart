import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/functions/global_functions.dart';
import '../../../data/data_source/chats/chat_details_requests.dart';
import '../../../data/model/chat_model/message_model.dart';

abstract class BaseChatDetailsRepository {
  Stream<List<MessageModel>> getMessages({required String hisPhoneNumber, required String myPhoneNumber});

  Future<void> sendMessage({
    required String phoneNumber,
    required String message,
    required String myPhoneNumber,
    required String type,
    required Timestamp time,
    required String messageId,
  });

  Future<void> sendReplyMessage({
    required String phoneNumber,
    required String originalMessage,
    required String message,
    required String replyOriginalName,
    required String theSender,
    required String type,
    required Timestamp time,
    required String messageId,
  });

  void sendImage({
    required String phoneNumber,
    required Timestamp time,
    required String messageId,
    required String type,
    required String myPhoneNumber,
    required String imagePath,
  });

  void sendVoice({
    required String phoneNumber,
    required Timestamp time,
    required String type,
    required String myPhoneNumber,
    required String voicePath,
    required String messageId,
    required List<double> waveData,
    required int maxDuration,
  });
}

class ChatDetailsRepository extends BaseChatDetailsRepository {
  final ChatDetailsRequests chatDetailsRequests;

  ChatDetailsRepository(this.chatDetailsRequests);

  var fireBaseInit = FirebaseFirestore.instance;

  @override
  Stream<List<MessageModel>> getMessages({required String hisPhoneNumber, required String myPhoneNumber}) {
    var chatSubCollection = chatDetailsRequests.getMessagesData(hisPhoneNumber, myPhoneNumber);
    return chatSubCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => MessageModel.fromSnapshot(doc)).toList();
    });
  }

  @override
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

  @override
  void sendImage({
    required String phoneNumber,
    required String type,
    required String myPhoneNumber,
    required String imagePath,
    required Timestamp time,
    required String messageId,
  }) async {
    String sortedNumber = GlFunctions.sortPhoneNumbers(phoneNumber, myPhoneNumber);
    fireBaseInit.collection('chats').doc(sortedNumber).collection('messages').doc().set({
      'isSeen': false,
      'message': imagePath,
      'theSender': myPhoneNumber,
      'time': time,
      'messageId': messageId,
      'type': type,
    });
  }

  @override
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
    String sortedNumber = GlFunctions.sortPhoneNumbers(phoneNumber, myPhoneNumber);

    fireBaseInit.collection('chats').doc(sortedNumber).collection('messages').doc().set({
      'isSeen': false,
      'message': voicePath,
      'theSender': myPhoneNumber,
      'time': time,
      'messageId': messageId,
      'type': type,
      'waveData': waveData,
      'maxDuration': maxDuration,
    });
  }

  @override
  Future<void> sendReplyMessage({
    required String phoneNumber,
    required String originalMessage,
    required String message,
    required String replyOriginalName,
    required String theSender,
    required String type,
    required Timestamp time,
    required String messageId,
  }) async {
    chatDetailsRequests.sendReplyMessage(
      phoneNumber: phoneNumber,
      originalMessage: originalMessage,
      message: message,
      theSender: theSender,
      type: type,
      time: time,
      messageId: messageId,
      replyOriginalName: replyOriginalName,
    );
  }
}
