import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/functions/global_functions.dart';
import '../../../../../core/networking/model/user_model/user_model.dart';


class ChatsRequest {
  late final FirebaseFirestore _firebaseFirestore;

  ChatsRequest() {
    _firebaseFirestore = FirebaseFirestore.instance;
  }

  Query<Map<String, dynamic>> getChatsFromFireStore(String myPhoneNumber) {
    return _firebaseFirestore.collection('chats').where(
          'usersPhoneNumber',
          arrayContains: myPhoneNumber,
        );
  }

  CollectionReference<Map<String, dynamic>> getUserCollection() {
    return _firebaseFirestore.collection('users');
  }

  CollectionReference<Map<String, dynamic>> getChatsCollection() {
    return _firebaseFirestore.collection('chats');
  }

  Future<List<Contact>> getLocalContact() async {
    final PermissionStatus status = await Permission.contacts.request();
    if (status.isGranted) {
      return await ContactsService.getContacts();
    } else {
      throw Exception();
    }
  }

  Query<Map<String, dynamic>> getLastMessage({required String hisNumber, required String myPhoneNumber}) {
    String sortedNumber = GlFunctions.sortPhoneNumbers(hisNumber, myPhoneNumber);
    return _firebaseFirestore
        .collection('chats')
        .doc(sortedNumber)
        .collection('messages')
        .orderBy('time', descending: true)
        .limit(1);
  }

  Future<void> creatingChatRoom({
    required UserModel friendContactUserModel,
    required UserModel myContactUserModel,
  }) async {
    final chatCollection = getChatsCollection();

    String sortedNumber =
        GlFunctions.sortPhoneNumbers(friendContactUserModel.userPhone, myContactUserModel.userPhone);

    DocumentSnapshot snapshot = await chatCollection.doc(sortedNumber).get();

    if (!snapshot.exists) {
      await chatCollection.doc(sortedNumber).set({
        'chatType': 'private',
        'lastMessage': '',
        'lastMessageTime': DateTime.timestamp(),
        'usersData': {
          myContactUserModel.userPhone: {
            'isOnline': true,
            'userId': myContactUserModel.userId,
            'userName': myContactUserModel.userName,
            'userPhone': myContactUserModel.userPhone,
            'profileImage': myContactUserModel.profilePicture,
          },
          friendContactUserModel.userPhone: {
            'isOnline': true,
            'userId': friendContactUserModel.userId,
            'userName': friendContactUserModel.userName,
            'userPhone': friendContactUserModel.userPhone,
            'profileImage': friendContactUserModel.profilePicture,
          },
        },
        'usersPhoneNumber': [
          friendContactUserModel.userPhone,
          myContactUserModel.userPhone,
        ],
      });
    }
  }

  void sendUserName(String userName) {
    var userQuerySnapshot = getUserCollection().doc();
    userQuerySnapshot.update({'userName': userName});
  }
}
