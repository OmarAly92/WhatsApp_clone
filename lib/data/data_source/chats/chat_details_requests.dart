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
    return getChatsCollection()
        .doc(sortedNumber)
        .collection('messages')
        .orderBy('time', descending: false);
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
      'isSeen': false,
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
}
