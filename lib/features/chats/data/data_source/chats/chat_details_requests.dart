import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:whats_app_clone/core/networking/model/chat_model/message_model.dart';

import '../../../../../core/utils/global_functions.dart';
import '../../../../../core/networking/model/user_model/user_model.dart';

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
    final String sortedNumber = GlFunctions.sortPhoneNumbers(hisNumber, myPhoneNumber);
    return getChatsCollection().doc(sortedNumber).collection('messages').orderBy('time', descending: false);
  }

  Future<String> getMessageDocId({
    required String messageId,
    required String chatDocId,
  }) async {
    final data = await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatDocId)
        .collection('messages')
        .where('messageId', isEqualTo: messageId)
        .get();
    String messageDocId = data.docs.single.id;
    return messageDocId;
  }

  Future<void> updateMessageReadStatus({
    required String chatDocId,
    required String messageId,
  }) async {
    final String messageDocId = await getMessageDocId(messageId: messageId, chatDocId: chatDocId);

    await getChatsCollection()
        .doc(chatDocId)
        .collection('messages')
        .doc(messageDocId)
        .update({'isSeen': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  Query<Map<String, dynamic>> getUserInfo({required String phoneNumber}) {
    return getUserCollection().where('userPhone', isEqualTo: phoneNumber);
  }

  Future<void> sendMessage({required String sortedNumber, required MessageModel messageModel}) async {
    final messageDocument = getChatsCollection().doc(sortedNumber).collection('messages').doc();
    await messageDocument.set({
      'isSeen': '',
      'reactEmoji': '',
      'message': messageModel.message,
      'theSender': messageModel.theSender,
      'senderName': messageModel.senderName,
      'time': messageModel.time,
      'messageId': messageModel.messageId,
      'type': messageModel.type,
    });
  }

  Future<void> sendImage({
    required String sortedNumber,
    required MessageModel messageModel,
  }) async {
    await getChatsCollection().doc(sortedNumber).collection('messages').doc().set({
      'isSeen': '',
      'reactEmoji': '',
      'message': messageModel.message,
      'theSender': messageModel.theSender,
      'senderName': messageModel.senderName,
      'time': messageModel.time,
      'messageId': messageModel.messageId,
      'type': messageModel.type,
    });
  }

  Future<void> sendVoice({
    required String sortedNumber,
    required MessageModel messageModel,
  }) async {
    await getChatsCollection().doc(sortedNumber).collection('messages').doc().set({
      'isSeen': '',
      'reactEmoji': '',
      'message': messageModel.message,
      'theSender': messageModel.theSender,
      'senderName': messageModel.senderName,
      'time': messageModel.time,
      'messageId': messageModel.messageId,
      'type': messageModel.type,
      'waveData': messageModel.waveData,
      'maxDuration': messageModel.maxDuration,
    });
  }

  Future<void> sendReplyMessage({
    required String sortedNumber,
    required MessageModel messageModel,
  }) async {
    final messageDocument = getChatsCollection().doc(sortedNumber).collection('messages').doc();
    await messageDocument.set({
      'isSeen': '',
      'reactEmoji': '',
      'originalMessage': messageModel.originalMessage,
      'message': messageModel.message,
      'replyOriginalName': messageModel.replyOriginalName,
      'theSender': messageModel.theSender,
      'senderName': messageModel.senderName,
      'time': messageModel.time,
      'messageId': messageModel.messageId,
      'type': messageModel.type,
    });
  }

  void globalSendingMessage({
    required String sortedNumber,

    required UserModel myUserModel,
    required String hisPushToken,
    required MessageModel messageModel,
  }) async {
    if (messageModel.type == 'message') {
       sendMessage(sortedNumber: sortedNumber, messageModel: messageModel);
    } else if (messageModel.type == 'voice') {
      await sendVoice(sortedNumber: sortedNumber, messageModel: messageModel);
    } else if (messageModel.type == 'image') {
      await sendImage(sortedNumber: sortedNumber, messageModel: messageModel);
    } else if (messageModel.type == 'reply') {
      await sendReplyMessage(sortedNumber: sortedNumber, messageModel: messageModel);
    }


  await  pushNotification(
      myUserModel: myUserModel,
      hisPushToken: hisPushToken,
      messageModel: messageModel,
    );
  }

  Future<void> pushNotification({
    required UserModel myUserModel,
    required String hisPushToken,
    required MessageModel messageModel,
  }) async {
    try {
      Dio dio = Dio();
      const String pushApi = 'https://fcm.googleapis.com/fcm/send';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer AAAAQk7oPtM:APA91bHylG7LFeOCu548jYKk-ZnE8h1AM3pS3WrMLdYVeKJFEATHw9kB-IaT03dCrYihwGeTZBh6Xe3KGb9rpObAdwxN2OpmpIiDgiNcdjlQXQ--HrpacgiogjoFzwCdoXDnVQ-nJ8vC'
      };
      final data = json.encode({
        "to": hisPushToken,
        "data": {
          "title" : messageModel.senderName,
          "body" :  messageModel.message,
          "isOnline": myUserModel.isOnline,
          "lastActive": myUserModel.lastActive,
          "name": myUserModel.name,
          "profilePicture": myUserModel.profilePicture,
          "email": myUserModel.email,
          "phoneNumber": myUserModel.phoneNumber,
          "userId": myUserModel.userId,
          "pushToken": myUserModel.pushToken,
          "path": 'chatDetail',
        }
      });
      final response = await dio.post(
        options: Options(headers: headers),
        pushApi,
        data: data,
      );
      if (response.statusCode == 200) {
        log('OMAR Push Successful');
      }
    } catch (e) {
      log('-----------------------$e-----------------------');
    }
  }
}
