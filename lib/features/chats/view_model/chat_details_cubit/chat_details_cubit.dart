import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/chat_model/message_model.dart';

part 'chat_details_state.dart';

class ChatDetailsCubit extends Cubit<ChatDetailsState> {
  ChatDetailsCubit() : super(ChatDetailsInitial());

  var fireBaseInit = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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

      emit(ChatDetailsSuccess(
        messages: messages,
        myPhoneNumber: myPhoneNumber,
      ));
    });
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
      emit(ChatDetailsFailure(failureMessage: '$failureMessage OMAR'));
    }
  }

  String getMyPhoneNumber() {
    final String myPhoneNumber =
        firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
    return myPhoneNumber;
  }
}
