import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whats_app_clone/data/model/user_model/user_model.dart';

import '../../../../core/functions/filtering.dart';
import '../../../../data/model/chat_model/chat_model.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitial());

  var fireBaseInit = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late List<ChatModel> chats;

  Future<void> getContacts() async {
    emit(ChatsLoading());

    try {
      final String myPhoneNumber =
          firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');

      await getUserData(myPhoneNumber: myPhoneNumber);
      await getChats(myPhoneNumber: myPhoneNumber);
    } catch (failureMessage) {
      emit(ChatsFailure(failureMessage: '$failureMessage OMAR'));
    }
  }

  Future<void> sendMessage({
    required String phoneNumber,
    required String message,
    required String myPhoneNumber,
    required String time,
  }) async {
    try {
      List<String> sortedNumber = [phoneNumber, myPhoneNumber]..sort();

      fireBaseInit.collection('chats').doc(sortedNumber.join('-')).update({
        'messages': FieldValue.arrayUnion([
          {
            'isSeen': false,
            'message': message,
            'theSender': myPhoneNumber,
            'time': time,
          },
        ])
      });

    } catch (failureMessage) {
      emit(ChatsFailure(failureMessage: '$failureMessage OMAR'));
    }
  }

  Future<void> getChats({required String myPhoneNumber}) async {
    final chatsSnapshot = fireBaseInit.collection('chats').where(
          'usersPhones',
          arrayContains: myPhoneNumber,
        );

    chatsSnapshot.snapshots().listen((event) async {
      List<ChatModel> chats = List<ChatModel>.from(
          (event.docs).map((e) => ChatModel.fromSnapshot(e)).toList());
      ChatModel.getOtherUser(myPhoneNumber, chats);
      this.chats = chats;
      emit(ChatsSuccess(chats: chats, myPhoneNumber: myPhoneNumber));
    });
  }

  Future<void> getUserData({required String myPhoneNumber}) async {
    final userSnapshot = fireBaseInit.collection('users');

    List<UserModel> fireBaseUsers =
        await gettingFireBaseUsersData(userSnapshot);

    List<UserModel> contactsList =
        await filteringFirebaseContactsAndLocalContacts(
            fireBaseUsers, myPhoneNumber);

    UserModel myUserData = await getMyUserData(userSnapshot, myPhoneNumber);
    creatingChatRoom(
      contactsList: contactsList,
      myPhoneNumber: myPhoneNumber,
      myUserData: myUserData,
    );
  }

  Future<List<UserModel>> gettingFireBaseUsersData(
      CollectionReference<Map<String, dynamic>> userSnapshot) async {
    List<UserModel> fireBaseUsers = [];

    var userQuerySnapshot = await userSnapshot.get();
    if (userQuerySnapshot.docs.isNotEmpty) {
      for (var userDoc in userQuerySnapshot.docs) {
        UserModel userModel = UserModel.fromSnapshot(userDoc);
        fireBaseUsers.add(userModel);
      }
    }
    return fireBaseUsers;
  }

  Future<List<UserModel>> filteringFirebaseContactsAndLocalContacts(
      List<UserModel> fireBaseUsers, String myPhoneNumber) async {
    final PermissionStatus status = await Permission.contacts.request();
    if (status.isGranted) {
      List<Contact> localContacts = await ContactsService.getContacts();
      Set<String> contactsPhoneNumbers =
          Filtering.extractContactsPhoneNumbers(localContacts);
      Set<String> userPhoneNumbersSet =
          Filtering.extractUserPhoneNumbers(fireBaseUsers);
      Set<String> commonPhoneNumbers = Filtering.findCommonPhoneNumbers(
        contactsPhoneNumbers,
        userPhoneNumbersSet,
      );

      List<UserModel> contactsList = Filtering.filterUserPhoneNumber(
        fireBaseUsers,
        commonPhoneNumbers,
        myPhoneNumber,
      );

      return contactsList;
    } else {
      throw Exception();
    }
  }

  Future<UserModel> getMyUserData(
    CollectionReference<Map<String, dynamic>> userSnapshot,
    String myPhoneNumber,
  ) async {
    var myData =
        await userSnapshot.where('userPhone', isEqualTo: myPhoneNumber).get();
    UserModel myUserData = UserModel.fromQuerySnapshot(myData);
    return myUserData;
  }

  Future<void> creatingChatRoom({
    required List<UserModel> contactsList,
    required String myPhoneNumber,
    required UserModel myUserData,
  }) async {
    final chatSnapshot = fireBaseInit.collection('chats');
    try {


      for (int i = 0; i < contactsList.length; i++) {


        List<String> sortedNumber = [contactsList[i].userPhone, myPhoneNumber]..sort();

        DocumentSnapshot snapshot = await chatSnapshot.doc(sortedNumber.join('-'))
            .get();
        if (snapshot.exists) {
          print('Document exists OMAR');
        } else {
          await chatSnapshot
              .doc(sortedNumber.join('-'))
              .set({
            'chatType': 'private',
            'messages': [
              {
                'isSeen': false,
                'message': '',
                'theSender': '',
                'time': '',
              },
            ],
            'users': [
              {
                'userId': contactsList[i].userId,
                'userName': contactsList[i].userName,
                'userPhone': contactsList[i].userPhone,
              },
              {
                'userId': myUserData.userId,
                'userName': myUserData.userName,
                'userPhone': myUserData.userPhone,
              },
            ],
            'usersPhones': [contactsList[i].userPhone, myUserData.userPhone]
          });
        }
      }
    } catch (failureMessage) {
      emit(ChatsFailure(failureMessage: '$failureMessage OMAR'));
    }
  }

  Future<UserModel> checkUserNameIsNotEmpty() async {
    String myPhoneNumber =
        firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
    var userQuerySnapshot = await fireBaseInit
        .collection('users')
        .where('userPhone', isEqualTo: myPhoneNumber)
        .get();
    UserModel user = UserModel.fromQuerySnapshot(userQuerySnapshot);
    return user;
  }

  void sendUserName(String userName) {
    var userQuerySnapshot = fireBaseInit.collection('users').doc();
    userQuerySnapshot.update({
      'userName': userName,
    });
  }
}
