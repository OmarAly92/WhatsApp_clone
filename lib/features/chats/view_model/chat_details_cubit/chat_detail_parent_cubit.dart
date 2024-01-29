import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/data/model/chat_model/message_model.dart';

import '../../../../core/functions/global_functions.dart';

part 'chat_detail_parent_state.dart';

class ChatDetailParentCubit extends Cubit<ChatDetailParentState> {
  ChatDetailParentCubit() : super(const ChatDetailParentInitial());
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  int selectedItemCount = 0;
  List<String> messagesId = [];
  List<String> fileUrl = [];

  bool isReplying = false;
  List<bool> isTheSender = [];
  List<MessageModel> replyOriginalMessage = [];
  List<String> messageType = [];

  void checkLongPressedState(int isSelectedLongPress) {
    if (selectedItemCount <= 0) {
      if (isSelectedLongPress == -1) {
        emit(const ChatDetailParentInitial());
      } else {
        emit(ChatDetailParentLongPressedAppbar(selectedItemCount: selectedItemCount));
      }
    } else {
      emit(ChatDetailParentLongPressedAppbar(selectedItemCount: selectedItemCount));
    }
  }

  void closeLongPressedAppbar() {
    selectedItemCount = 0;
    messagesId = [];
    fileUrl = [];
    isTheSender = [];
    replyOriginalMessage = [];
    messageType = [];
    emit(const ChatDetailParentInitial());
  }

  void replyMessageTrigger({
    required MessageModel replyMessage,
    required String hisName,
    required Color replyColor,
  }) {
    emit(ChatDetailParentReplying(
      originalMessage: replyMessage,
      hisName: hisName,
      replyColor: replyColor,
    ));
  }

  void closeReplyMessage() {
    emit(const ChatDetailParentNotReplying());
  }

  Future<void> deleteSelectedMessages({required String hisPhoneNumber}) async {
    try {
      final String myPhoneNumber =  GlFunctions.getMyPhoneNumber();
      final String chatCollectionDocId = GlFunctions.sortPhoneNumbers(myPhoneNumber, hisPhoneNumber);

      for (int i = 0; i < fileUrl.length; i++) {
        if (fileUrl[i].contains('https://firebasestorage')) {
          await _deleteFileFromStorage(fileUrl[i]);
        }
      }

      for (int i = 0; i < messagesId.length; i++) {
        _deleteMessageFromFirestore(
          chatCollectionDocId: chatCollectionDocId,
          messageId: messagesId[i],
        );
      }
      closeLongPressedAppbar();
    } catch (e) {
      emit(ChatDetailParentFailure(failureMessage: 'failed to delete selected messages: $e'));
    }
  }

  Future<void> _deleteFileFromStorage(String voiceUrl) async {
    try {
      await FirebaseStorage.instance.refFromURL(voiceUrl).delete();
    } catch (e) {
      emit(ChatDetailParentFailure(failureMessage: 'failed in _deleteFileFromStorage method: $e'));
    }
  }

  Future<void> _deleteMessageFromFirestore({
    required String messageId,
    required String chatCollectionDocId,
  }) async {
    final String messageDocId = await _getDocIdForDelete(messageId: messageId, chatCollectionDocId: chatCollectionDocId);

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatCollectionDocId)
        .collection('messages')
        .doc(messageDocId)
        .update({'type': 'deleted'});
  }

  Future<String> _getDocIdForDelete({
    required String messageId,
    required String chatCollectionDocId,
  }) async {
    var data = await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatCollectionDocId)
        .collection('messages')
        .where('messageId', isEqualTo: messageId)
        .get();
    String messageDocId = data.docs.first.id;
    return messageDocId;
  }


}
