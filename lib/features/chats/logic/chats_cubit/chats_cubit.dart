import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/core/networking/model/user_model/user_model.dart';

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
    final chats = await _chatsRepository.getChats(myPhoneNumber);
    chats.listen((chats) async {
      final users = await fetchUserDoc(chats, myPhoneNumber);
      emit(ChatsSuccess(
        myPhoneNumber: myPhoneNumber,
        chats: chats,
        users: users,
      ));
    });
  }

  Future<List<UserModel>> fetchUserDoc(List<ChatsModel> chats, String myPhoneNumber) async {
    final List<UserModel> users = [];
    for (var element in chats) {
      final userDocOne = await element.usersDocs[0].get();
      final userDocTwo = await element.usersDocs[1].get();
      final userModelOne = UserModel.fromQueryDocumentSnapshot(userDocOne);
      final userModelTwo = UserModel.fromQueryDocumentSnapshot(userDocTwo);
      final userModel = userModelOne.phoneNumber != myPhoneNumber ? userModelOne : userModelTwo;
      users.add(userModel);
    }
    return users;
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
