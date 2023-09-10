import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whats_app_clone/data/model/user_model/user_model.dart';

import '../../../../core/functions/filtering.dart';
import '../../../../data/model/chat_model/chat_model.dart';
import '../../../../data/model/chat_model/message_model.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitial());

  var fireBaseInit = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late List<ChatsModel> chats;

  String getMyPhoneNumber() {
    final String myPhoneNumber =
        firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
    return myPhoneNumber;
  }

  Future<void> getContacts() async {
    emit(ChatsLoading());

    try {
      final String myPhoneNumber = getMyPhoneNumber();

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
    required Timestamp time,
  }) async {
    try {
      List<String> sortedNumber = [phoneNumber, myPhoneNumber]..sort();
      var chatDocument =
          fireBaseInit.collection('chats').doc(sortedNumber.join('-'));
      chatDocument.collection('messages').doc().set({
        'isSeen': false,
        'message': message,
        'theSender': myPhoneNumber,
        'time': time,
      });
      chatDocument.update({
        'lastMessage': message,
        'lastMessageTime': time,
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
      List<ChatsModel> chats = List<ChatsModel>.from(
          (event.docs).map((e) => ChatsModel.fromSnapshot(e)).toList());
      List<UserModel> users = [];
      for (int i = 0; i < chats.length; i++) {
        var docIndexOne = await chats[i].users[0].userDoc.get();
        var docIndexTwo = await chats[i].users[1].userDoc.get();

        users.add(UserModel.fromSnapshot(docIndexOne));
        users.add(UserModel.fromSnapshot(docIndexTwo));
      }
      ChatsModel.getOtherUser(myPhoneNumber, chats);

      this.chats = chats;

      emit(ChatsSuccess(
        chats: chats,
        user: users,
        myPhoneNumber: myPhoneNumber,
      ));
    });
  }

  Future<void> getUserData({required String myPhoneNumber}) async {
    final userSnapshot = fireBaseInit.collection('users');

    List<UserModel> fireBaseUsers =
        await gettingFireBaseUsersData(userSnapshot);

    List<UserModel> contactsList =
        await filteringFirebaseContactsAndLocalContacts(
            fireBaseUsers, myPhoneNumber);

    creatingChatRoom(
      contactsList: contactsList,
      myPhoneNumber: myPhoneNumber,
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

  void getMessages({required String hisNumber}) {
    final String myPhoneNumber = getMyPhoneNumber();
    final chatSnapshot = fireBaseInit.collection('chats');
    List<String> sortedNumber = [hisNumber, myPhoneNumber]..sort();

    var chatSubCollection = chatSnapshot
        .doc(sortedNumber.join('-'))
        .collection('messages')
        .orderBy('time', descending: false);

    chatSubCollection.snapshots().listen((event) {
      List<MessageModel> messages = List<MessageModel>.from(
          (event.docs).map((e) => MessageModel.fromSnapshot(e)));

      emit(ListenToMessage(
        messages: messages,
        myPhoneNumber: myPhoneNumber,
      ));
    });
  }

  void clearMessages() {
    emit(const ListenToMessage(messages: [], myPhoneNumber: ''));
  }

  // Future<UserModel> getMyUserData(
  //   CollectionReference<Map<String, dynamic>> userSnapshot,
  //   String myPhoneNumber,
  // ) async {
  //   var myData =
  //       await userSnapshot.where('userPhone', isEqualTo: myPhoneNumber).get();
  //   UserModel myUserData = UserModel.fromQuerySnapshot(myData);
  //   return myUserData;
  // }

  Future<void> creatingChatRoom({
    required List<UserModel> contactsList,
    required String myPhoneNumber,
  }) async {
    final userSnapshot = fireBaseInit.collection('users');

    // UserModel myUserData = await getMyUserData(userSnapshot, myPhoneNumber);

    final chatSnapshot = fireBaseInit.collection('chats');
    try {
      for (int i = 0; i < contactsList.length; i++) {
        List<String> sortedNumber = [contactsList[i].userPhone, myPhoneNumber]
          ..sort();

        DocumentSnapshot snapshot =
            await chatSnapshot.doc(sortedNumber.join('-')).get();

        if (snapshot.exists) {
          print('Document exists OMAR');
        } else {
          await chatSnapshot.doc(sortedNumber.join('-')).set({
            'chatType': 'private',
            'lastMessage': '',
            'lastMessageTime': DateTime.timestamp(),
            'users': [
              {
                'userDoc': userSnapshot.doc(contactsList[i].userPhone),
              },
              {
                // 'userDoc': myUserData.userPhone,
                'userDoc': userSnapshot.doc(myPhoneNumber),
              },
            ],
            'usersPhones': [contactsList[i].userPhone, myPhoneNumber]
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

// Future<void> creatingChatRoom({
//   required List<UserModel> contactsList,
//   required String myPhoneNumber,
//   required UserModel myUserData,
// }) async {
//   final chatSnapshot = fireBaseInit.collection('chats');
//   try {
//     for (int i = 0; i < contactsList.length; i++) {
//       List<String> sortedNumber = [contactsList[i].userPhone, myPhoneNumber]
//         ..sort();
//
//       DocumentSnapshot snapshot =
//       await chatSnapshot.doc(sortedNumber.join('-')).get();
//
//       if (snapshot.exists) {
//         print('Document exists OMAR');
//       } else {
//         await chatSnapshot.doc(sortedNumber.join('-')).set({
//           'chatType': 'private',
//           'lastMessage': '',
//           'lastMessageTime': DateTime.timestamp(),
//           'users': [
//             {
//               'userId': contactsList[i].userId,
//               'userName': contactsList[i].userName,
//               'userPhone': contactsList[i].userPhone,
//             },
//             {
//               'userId': myUserData.userId,
//               'userName': myUserData.userName,
//               'userPhone': myUserData.userPhone,
//             },
//           ],
//           'usersPhones': [contactsList[i].userPhone, myUserData.userPhone]
//         });
//       }
//     }
//   } catch (failureMessage) {
//     emit(ChatsFailure(failureMessage: '$failureMessage OMAR'));
//   }
// }
