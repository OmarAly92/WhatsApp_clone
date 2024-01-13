import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/data/model/user_model/user_model.dart';
import 'package:whats_app_clone/features/chats/repository/chats_repository.dart';

import '../../../../data/data_source/chats/chats_requests.dart';
import '../../../../data/model/chat_model/chat_model.dart';
import '../../../../data/model/chat_model/message_model.dart';

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
      final String myPhoneNumber = _getMyPhoneNumber();
       _getChats(myPhoneNumber: myPhoneNumber);
    } catch (failureMessage) {
      emit(ChatsFailure(failureMessage: '$failureMessage OMAR'));
    }
  }
  void _getChats({required String myPhoneNumber})  {
    _chatsRepository.getChats(myPhoneNumber).listen((chats) {
      var result = getOtherUser(myPhoneNumber, chats);
      emit(ChatsSuccess(myPhoneNumber: myPhoneNumber, chats: result));
    });
  }

  List<ChatsModel> getOtherUser(String myPhoneNumber, List<ChatsModel> chats) {
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

  String _getMyPhoneNumber() {
    final String myPhoneNumber = _firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
    return myPhoneNumber;
  }
}
