import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data_source/chats/chats_requests.dart';
import '../../../../data/model/chat_model/chat_model.dart';
import '../../../../data/model/chat_model/message_model.dart';
import '../../../../data/model/user_model/user_model.dart';
import '../../repository/chats_repository.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this._chatsRepository, this._chatsRequest) : super(ChatsInitial());
  final ChatsRepository _chatsRepository;
  final ChatsRequest _chatsRequest;
  var firestoreInit = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> getContacts() async {
    emit(ChatsLoading());
    try {
      await _getChats();
    } catch (failureMessage) {
      emit(ChatsFailure(failureMessage: '$failureMessage OMAR'));
    }
  }

  Future<void> _getChats() async {
    final String myPhoneNumber = _getMyPhoneNumber();
    var chats = await _chatsRepository.getChats(myPhoneNumber);
    var result = _getOtherUser(myPhoneNumber, chats);

    emit(ChatsSuccess(
      myPhoneNumber: myPhoneNumber,
      chats: result,
    ));
  }

  List<ChatsModel> _getOtherUser(String myPhoneNumber, List<ChatsModel> chats) {
    for (int index = 0; index < chats.length; index++) {
      chats[index].usersData.removeWhere((key, value) => key == myPhoneNumber);
    }
    return chats;
  }

  Future<UserModel> checkUserNameIsNotEmpty() async {
    final String myPhoneNumber = _getMyPhoneNumber();
    return _chatsRepository.checkUserNameIsNotEmpty(myPhoneNumber);
  }

  void sendUserName(String userName) {
    var userQuerySnapshot = _chatsRequest.getUserCollection().doc();
    userQuerySnapshot.update({'userName': userName});
  }

  void getLastMessage({required String hisNumber}) {
    final String myPhoneNumber = _getMyPhoneNumber();
    var lastMessage = _chatsRepository.getLastMessage(
      hisNumber: hisNumber,
      myPhoneNumber: myPhoneNumber,
    );
    lastMessage.listen((lastMessage) {
      emit(ListenToLastMessage(lastMessage: lastMessage.single));
    });
  }

  String _getMyPhoneNumber() {
    final String myPhoneNumber = _firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
    return myPhoneNumber;
  }
}
