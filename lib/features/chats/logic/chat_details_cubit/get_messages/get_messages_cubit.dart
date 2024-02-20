import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/core/utils/global_functions.dart';
import 'package:whats_app_clone/core/networking/model/user_model/user_model.dart';

import '../../../../../core/networking/model/chat_model/message_model.dart';
import '../../../data/repository/chat_details_repository.dart';

part 'get_messages_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  GetMessagesCubit(this.chatDetailsRepository) : super(GetMessagesInitial());

  final ChatDetailsRepository chatDetailsRepository;
  StreamSubscription<List<MessageModel>>? messagesSubscription;

  void getMessages({required String hisPhoneNumber}) async {
    final String myPhoneNumber = await GlFunctions.getMyPhoneNumber();

    await messagesSubscription?.cancel();

    messagesSubscription = chatDetailsRepository
        .getMessages(hisPhoneNumber: hisPhoneNumber, myPhoneNumber: myPhoneNumber)
        .listen((messages) {
      emit(GetMessagesSuccess(
        messages: messages,
        myPhoneNumber: myPhoneNumber,
      ));
    });
  }

  void getUserInfo({required String phoneNumber}) async {
    chatDetailsRepository.getUserInfo(phoneNumber: phoneNumber).listen((userInfo) {
      emit(GetUserInfo(userInfo: userInfo.first));
    });
  }
}
