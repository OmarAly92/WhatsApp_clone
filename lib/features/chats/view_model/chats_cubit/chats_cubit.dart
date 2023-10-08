import 'dart:async';

import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/data/model/user_model/user_model.dart';
import 'package:whats_app_clone/features/chats/repository/chats_repository.dart';

import '../../../../core/functions/filtering.dart';
import '../../../../data/data_source/chats/chats_requests.dart';
import '../../../../data/model/chat_model/chat_model.dart';
import '../../../../data/model/chat_model/message_model.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this._chatsRepository, this._chatsRequest) : super(ChatsInitial());
  final ChatsRepository _chatsRepository;
  final ChatsRequest _chatsRequest;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String _getMyPhoneNumber() {
    final String myPhoneNumber = _firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
    return myPhoneNumber;
  }

  Future<void> getContacts() async {
    emit(ChatsLoading());
    try {
      final String myPhoneNumber = _getMyPhoneNumber();
      await _getUserData(myPhoneNumber: myPhoneNumber);
      await _getChats(myPhoneNumber: myPhoneNumber);
    } catch (failureMessage) {
      emit(ChatsFailure(failureMessage: '$failureMessage OMAR'));
    }
  }

  Future<UserModel> getOtherUser(int index, String myPhoneNumber, List<ChatsModel> chats) async {
    final userDocOne = await chats[index].usersDocument[0].get();
    final userDocTwo = await chats[index].usersDocument[1].get();
    final UserModel userOne = UserModel.fromSnapshot(userDocOne);
    final UserModel userTwo = UserModel.fromSnapshot(userDocTwo);
    final UserModel otherUser = userOne.userPhone == myPhoneNumber ? userTwo : userOne;
    return otherUser;
  }

  Future<void> _getChats({required String myPhoneNumber}) async {
    _chatsRepository.getChats(myPhoneNumber).listen((chats) async {
      final List<ChatsModel> chatsReady = [];
      for (int i = 0; i < chats.length; i++) {
        UserModel otherUser = await getOtherUser(i, myPhoneNumber, chats);
        final ChatsModel chatModel = ChatsModel(
          chatType: chats[i].chatType,
          usersDocument: chats[i].usersDocument,
          lastMessage: chats[i].lastMessage,
          lastMessageTime: chats[i].lastMessageTime,
          users: otherUser,
        );
        chatsReady.add(chatModel);
      }
      emit(ChatsSuccess(myPhoneNumber: myPhoneNumber, chats: chatsReady));
    });
  }

  Future<void> _getUserData({required String myPhoneNumber}) async {
    List<UserModel> fireBaseUsers = await _chatsRepository.getUserData();

    List<UserModel> contactsList = await _filteringFirebaseContactsAndLocalContacts(
      fireBaseUsers,
      myPhoneNumber,
    );
    _creatingChatRoom(contactsList: contactsList, myPhoneNumber: myPhoneNumber);
  }

  Future<List<UserModel>> _filteringFirebaseContactsAndLocalContacts(
      List<UserModel> fireBaseUsers, String myPhoneNumber) async {
    List<Contact> localContacts = await _chatsRepository.getLocalContact();
    Set<String> contactsPhoneNumbers = Filtering.extractContactsPhoneNumbers(localContacts);
    Set<String> userPhoneNumbersSet = Filtering.extractUserPhoneNumbers(fireBaseUsers);
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

  Future<void> _creatingChatRoom({required List<UserModel> contactsList, required String myPhoneNumber}) async {
    try {
      await _chatsRepository.creatingChatRoom(contactsList: contactsList, myPhoneNumber: myPhoneNumber);
    } catch (failureMessage) {
      emit(ChatsFailure(failureMessage: '$failureMessage ERROR _creatingChatRoom OMAR'));
    }
  }

  Future<UserModel> checkUserNameIsNotEmpty() async {
    final String myPhoneNumber = _getMyPhoneNumber();
    return _chatsRepository.checkUserNameIsNotEmpty(myPhoneNumber);
  }

  void sendUserName(String userName) {
    var userQuerySnapshot = _chatsRequest.getUserCollection().doc();
    userQuerySnapshot.update({'userName': userName});
  }
}
