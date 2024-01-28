import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/functions/global_functions.dart';

class ChatDetailsRequests {
  late final FirebaseFirestore _firebaseFirestore;

  ChatDetailsRequests() {
    _firebaseFirestore = FirebaseFirestore.instance;
  }

  CollectionReference<Map<String, dynamic>> getUserCollection() {
    return _firebaseFirestore.collection('users');
  }

  CollectionReference<Map<String, dynamic>> getChatsCollection() {
    return _firebaseFirestore.collection('chats');
  }

  Query<Map<String, dynamic>> getMessagesData(String hisNumber, String myPhoneNumber) {
    String sortedNumber = GlFunctions.sortPhoneNumbers(hisNumber, myPhoneNumber);
    return getChatsCollection().doc(sortedNumber).collection('messages').orderBy('time', descending: false);
  }

  Future<void> sendMessage({
    required String phoneNumber,
    required String message,
    required String myPhoneNumber,
    required String type,
    required String messageId,
    required Timestamp time,
  }) async {
    String sortedNumber = GlFunctions.sortPhoneNumbers(phoneNumber, myPhoneNumber);
    var chatDocument = getChatsCollection().doc(sortedNumber);
    var messageDocument = getChatsCollection().doc(sortedNumber).collection('messages').doc();
    messageDocument.set({
      'isSeen': '',
      'reactEmoji': '',
      'message': message,
      'theSender': myPhoneNumber,
      'time': time,
      'messageId': messageId,
      'type': type,
    });
    chatDocument.update({
      'lastMessage': message,
      'lastMessageTime': time,
    });
  }

  void sendImage({
    required String phoneNumber,
    required String type,
    required String myPhoneNumber,
    required String imagePath,
    required Timestamp time,
    required String messageId,
  }) async {
    String sortedNumber = GlFunctions.sortPhoneNumbers(phoneNumber, myPhoneNumber);
    getChatsCollection().doc(sortedNumber).collection('messages').doc().set({
      'isSeen': '',
      'reactEmoji': '',
      'message': imagePath,
      'theSender': myPhoneNumber,
      'time': time,
      'messageId': messageId,
      'type': type,
    });
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
    String sortedNumber = GlFunctions.sortPhoneNumbers(phoneNumber, myPhoneNumber);

    getChatsCollection().doc(sortedNumber).collection('messages').doc().set({
      'isSeen': '',
      'reactEmoji': '',
      'message': voicePath,
      'theSender': myPhoneNumber,
      'time': time,
      'messageId': messageId,
      'type': type,
      'waveData': waveData,
      'maxDuration': maxDuration,
    });
  }

  void sendReplyMessage({
    required String phoneNumber,
    required String originalMessage,
    required String message,
    required String replyOriginalName,
    required String theSender,
    required String type,
    required Timestamp time,
    required String messageId,
  }) {
    String sortedNumber = GlFunctions.sortPhoneNumbers(phoneNumber, theSender);
    var chatDocument = getChatsCollection().doc(sortedNumber);
    var messageDocument = getChatsCollection().doc(sortedNumber).collection('messages').doc();
    messageDocument.set({
      'isSeen': '',
      'reactEmoji': '',
      'originalMessage': originalMessage,
      'message': message,
      'replyOriginalName': replyOriginalName,
      'theSender': theSender,
      'time': time,
      'messageId': messageId,
      'type': type,
    });
    chatDocument.update({
      'lastMessage': message,
      'lastMessageTime': time,
    });
  }

  void updateMessageReadStatus() {
    getChatsCollection().doc();
  }
}
