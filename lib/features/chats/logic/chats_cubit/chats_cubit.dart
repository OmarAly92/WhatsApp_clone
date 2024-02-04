import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/global_functions.dart';
import '../../../../core/networking/model/chat_model/chat_model.dart';
import '../../../../core/networking/model/chat_model/message_model.dart';
import '../../data/repository/chats_repository.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this._chatsRepository) : super(ChatsInitial());
  final ChatsRepository _chatsRepository;
  var firestoreInit = FirebaseFirestore.instance;

  Future<void> getContacts() async {
    emit(ChatsLoading());
    try {
      await _getChats();
    } catch (failureMessage) {
      emit(ChatsFailure(failureMessage: '$failureMessage OMAR'));
    }
  }

  Future<void> _getChats() async {
    final String myPhoneNumber = await GlFunctions.getMyPhoneNumber();
    var chats = await _chatsRepository.getChats(myPhoneNumber);
    chats.listen((chats) {
      var result = _getOtherUser(myPhoneNumber, chats);
      emit(ChatsSuccess(
        myPhoneNumber: myPhoneNumber,
        chats: result,
      ));
    });
  }

  List<ChatsModel> _getOtherUser(String myPhoneNumber, List<ChatsModel> chats) {
    for (int index = 0; index < chats.length; index++) {
      chats[index].usersData.removeWhere((key, value) => key == myPhoneNumber);
    }
    return chats;
  }

  void sendUserName(String userName) {
    _chatsRepository.sendUserName;
  }

  void getLastMessage({required String hisNumber}) async {
    final String myPhoneNumber = await GlFunctions.getMyPhoneNumber();
    var lastMessage = _chatsRepository.getLastMessage(
      hisNumber: hisNumber,
      myPhoneNumber: myPhoneNumber,
    );
    lastMessage.listen((lastMessage) {
      if (lastMessage.toList().singleOrNull != null) {
        emit(ListenToLastMessage(lastMessage: lastMessage.first));
      }
    });
  }

  Future<void> updateActiveStatus({required bool isOnline}) async {
    await _chatsRepository.updateActiveStatus(isOnline: isOnline);
  }
}
