import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/model/chat_model/message_model.dart';
import '../../../repository/chat_details_repository.dart';

part 'get_messages_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  GetMessagesCubit(this.chatDetailsRepository) : super(GetMessagesInitial());

  final ChatDetailsRepository chatDetailsRepository;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  StreamSubscription<List<MessageModel>>? messagesSubscription;

  void getMessages({required String hisPhoneNumber}) async {
    final String myPhoneNumber = getMyPhoneNumber();

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



  String getMyPhoneNumber() {
    final String myPhoneNumber = firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
    return myPhoneNumber;
  }
}