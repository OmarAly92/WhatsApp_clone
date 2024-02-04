import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/functions/global_functions.dart';

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
    required DocumentReference<Map<String, dynamic>> myDoc,
    required DocumentReference<Map<String, dynamic>> hisDoc,
    required String myPhoneNumber,
    required String hisPhoneNumber,
  }) async {
    final chatCollection = getChatsCollection();

    final String sortedNumber = GlFunctions.sortPhoneNumbers(hisPhoneNumber, myPhoneNumber);

    final DocumentSnapshot snapshot = await chatCollection.doc(sortedNumber).get();

    if (!snapshot.exists) {
      await chatCollection.doc(sortedNumber).set({
        'chatType': 'private',
        'usersDocs': [
          myDoc,
          hisDoc,
        ],
        'usersPhoneNumber': [
          myPhoneNumber,
          hisPhoneNumber,
        ],
      });
    }
  }

  void sendUserName(String userName) {
    final userQuerySnapshot = getUserCollection().doc();
    userQuerySnapshot.update({'userName': userName});
  }

  Future<void> updateActiveStatus({
    required bool isOnline,
  }) async {
    final String myPhoneNumber = await GlFunctions.getMyPhoneNumber();
    final userQuerySnapshot = getUserCollection().doc(myPhoneNumber);
    await userQuerySnapshot.update({
      'isOnline': isOnline,
      'lastActive': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
