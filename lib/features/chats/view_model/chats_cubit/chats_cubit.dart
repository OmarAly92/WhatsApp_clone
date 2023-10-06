import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/data/model/user_model/user_model.dart';
import 'package:whats_app_clone/features/chats/repository/chats_repository.dart';

import '../../../../core/functions/filtering.dart';
import '../../../../data/model/chat_model/chat_model.dart';
import '../../../../data/model/chat_model/message_model.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this._chatsRepository) : super(ChatsInitial());
  final ChatsRepository _chatsRepository;
  final _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String getMyPhoneNumber() {
    final String myPhoneNumber =
        _firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
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

  Future<void> getChats({required String myPhoneNumber}) async {
    _chatsRepository.getChats(myPhoneNumber).listen((chats) async {
      final List<ChatsModel> chatsReady = [];
      for (int i = 0; i < chats.length; i++) {
        final userDocOne = await chats[i].usersDocument[0].userDoc.get();
        final userDocTwo = await chats[i].usersDocument[1].userDoc.get();
        final UserModel userOne = UserModel.fromSnapshot(userDocOne);
        final UserModel userTwo = UserModel.fromSnapshot(userDocTwo);
        final UserModel otherUser =
            userOne.userPhone == myPhoneNumber ? userTwo : userOne;
        final ChatsModel chatModel = ChatsModel(
          chatType: chats[i].chatType,
          usersDocument: chats[i].usersDocument,
          lastMessage: chats[i].lastMessage,
          lastMessageTime: chats[i].lastMessageTime,
          users: otherUser,
        );
        chatsReady.add(chatModel);
      }

      emit(ChatsSuccess(
        myPhoneNumber: myPhoneNumber,
        chats: chatsReady,
      ));
    });
  }

  Future<void> getUserData({required String myPhoneNumber}) async {
    List<UserModel> fireBaseUsers = await _chatsRepository.getUserData();

    List<UserModel> contactsList =
        await filteringFirebaseContactsAndLocalContacts(
      fireBaseUsers,
      myPhoneNumber,
    );

    creatingChatRoom(
      contactsList: contactsList,
      myPhoneNumber: myPhoneNumber,
    );
  }

  Future<List<UserModel>> filteringFirebaseContactsAndLocalContacts(
      List<UserModel> fireBaseUsers, String myPhoneNumber) async {
    List<Contact> localContacts = await _chatsRepository.getLocalContact();
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
  }

  Future<void> creatingChatRoom({
    required List<UserModel> contactsList,
    required String myPhoneNumber,
  }) async {
    final userSnapshot = _firebaseFirestore.collection('users');

    final chatSnapshot = _firebaseFirestore.collection('chats');
    try {
      for (int i = 0; i < contactsList.length; i++) {
        List<String> sortedNumber = [contactsList[i].userPhone, myPhoneNumber]
          ..sort();

        DocumentSnapshot snapshot =
            await chatSnapshot.doc(sortedNumber.join('-')).get();

        if (!snapshot.exists) {
          await chatSnapshot.doc(sortedNumber.join('-')).set({
            'chatType': 'private',
            'lastMessage': '',
            'lastMessageTime': DateTime.timestamp(),
            'users': [
              {
                'userDoc': userSnapshot.doc(contactsList[i].userPhone),
              },
              {
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
    return _chatsRepository.checkUserNameIsNotEmpty();
  }

  void sendUserName(String userName) {
    var userQuerySnapshot = _firebaseFirestore.collection('users').doc();
    userQuerySnapshot.update({
      'userName': userName,
    });
  }
}