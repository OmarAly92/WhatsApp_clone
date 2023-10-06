import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whats_app_clone/data/model/chat_model/chat_model.dart';

import '../../../data/model/user_model/user_model.dart';

abstract class BassChatsRepository {
  Stream<List<ChatsModel>> getChats(String myPhoneNumber);

  Future<List<UserModel>> getUserData();

  Future<List<Contact>> getLocalContact();

  Future<UserModel> checkUserNameIsNotEmpty();
}

class ChatsRepository extends BassChatsRepository {
  late final FirebaseFirestore _firebaseFirestore;
  late final FirebaseAuth _firebaseAuth;

  ChatsRepository() {
    _firebaseFirestore = FirebaseFirestore.instance;
    _firebaseAuth = FirebaseAuth.instance;
  }

  @override
  Stream<List<ChatsModel>> getChats(String myPhoneNumber) {
    return _firebaseFirestore
        .collection('chats')
        .where(
          'usersPhones',
          arrayContains: myPhoneNumber,
        )
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ChatsModel.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<List<UserModel>> getUserData() async {
    List<UserModel> fireBaseUsers = [];
    final userSnapshot = await _firebaseFirestore.collection('users').get();

    if (userSnapshot.docs.isNotEmpty) {
      for (var userDoc in userSnapshot.docs) {
        UserModel userModel = UserModel.fromSnapshot(userDoc);
        fireBaseUsers.add(userModel);
      }
    }
    return fireBaseUsers;
  }

  @override
  Future<List<Contact>> getLocalContact() async {
    final PermissionStatus status = await Permission.contacts.request();
    if (status.isGranted) {
      return await ContactsService.getContacts();
    } else {
      throw Exception();
    }
  }

  @override
  Future<UserModel> checkUserNameIsNotEmpty() async {
    String myPhoneNumber =
        _firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
    var userQuerySnapshot = await _firebaseFirestore
        .collection('users')
        .where('userPhone', isEqualTo: myPhoneNumber)
        .get();
    UserModel user = UserModel.fromQuerySnapshot(userQuerySnapshot);
    return user;
  }
}
