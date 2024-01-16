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
  });

  void sendImage({
    required String phoneNumber,
    required Timestamp time,
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
  }) async {
    chatDetailsRequests.sendMessage(
        phoneNumber: phoneNumber, message: message, myPhoneNumber: myPhoneNumber, type: type, time: time);
  }

  @override
  void sendImage({
    required String phoneNumber,
    required Timestamp time,
    required String type,
    required String myPhoneNumber,
    required String imagePath,
  }) async {
    String sortedNumber = GlFunctions.sortPhoneNumbers(phoneNumber, myPhoneNumber);
    fireBaseInit.collection('chats').doc(sortedNumber).collection('messages').doc().set({
      'isSeen': false,
      'message': imagePath,
      'theSender': myPhoneNumber,
      'time': time,
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
    required List<double> waveData,
    required int maxDuration,
  }) {
    String sortedNumber = GlFunctions.sortPhoneNumbers(phoneNumber, myPhoneNumber);



    fireBaseInit.collection('chats').doc(sortedNumber).collection('messages').doc().set({
      'isSeen': false,
      'message': voicePath,
      'theSender': myPhoneNumber,
      'time': time,
      'type': type,
      'waveData':waveData,
      'maxDuration':maxDuration,
    });


  }
}
