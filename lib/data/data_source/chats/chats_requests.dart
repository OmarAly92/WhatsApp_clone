import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whats_app_clone/core/functions/global_functions.dart';

import '../../model/user_model/user_model.dart';

class ChatsRequest {
  late final FirebaseFirestore _firebaseFirestore;

  ChatsRequest() {
    _firebaseFirestore = FirebaseFirestore.instance;
  }

  Query<Map<String, dynamic>> getChatsFromFireStore(String myPhoneNumber) {
    final userCollection = getUserCollection();

    return _firebaseFirestore.collection('chats').where(
          'users',
          arrayContains: userCollection.doc(myPhoneNumber),
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

  Future<void> creatingChatRoom({
    required List<UserModel> contactsList,
    required String myPhoneNumber,
  }) async {
    final userCollection = getUserCollection();

    final chatCollection = getChatsCollection();

    for (int i = 0; i < contactsList.length; i++) {
      List<String> sortedNumber = GlFunctions.sortPhoneNumbers(contactsList[i].userPhone, myPhoneNumber);

      DocumentSnapshot snapshot = await chatCollection.doc(sortedNumber.join('-')).get();

      if (!snapshot.exists) {
        await chatCollection.doc(sortedNumber.join('-')).set({
          'chatType': 'private',
          'lastMessage': '',
          'lastMessageTime': DateTime.timestamp(),
          'users': [
            {
              'userDoc': userCollection.doc(contactsList[i].userPhone),
            },
            {
              'userDoc': userCollection.doc(myPhoneNumber),
            },
          ],
        });
      }
    }
  }
}
