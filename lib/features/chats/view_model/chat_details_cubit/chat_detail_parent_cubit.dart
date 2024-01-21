import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/global_functions.dart';

part 'chat_detail_parent_state.dart';

class ChatDetailParentCubit extends Cubit<ChatDetailParentState> {
  ChatDetailParentCubit() : super(const ChatDetailParentInitial());
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  int selectedItemCount = 0;
  List<String> messagesId = [];
  List<String> fileUrl = [];

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
    emit(const ChatDetailParentInitial());
  }

  Future<void> deleteSelectedMessages({required String hisPhoneNumber}) async {
    try {
      final String myPhoneNumber = _getMyPhoneNumber();
      final String docId = GlFunctions.sortPhoneNumbers(myPhoneNumber, hisPhoneNumber);

      for (int i = 0; i < fileUrl.length; i++) {
        if (fileUrl[i].contains('https://firebasestorage')) {
          await _deleteFileFromStorage(fileUrl[i]);
        }
      }

      for (int i = 0; i < messagesId.length; i++) {
        _deleteMessageFromFirestore(
          docId: docId,
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
      print("Error deleting file: $e");
    }
  }

  Future<void> _deleteMessageFromFirestore({
    required String messageId,
    required String docId,
  }) async {
    final String messageDocId = await _getDocIdForDelete(messageId: messageId, docId: docId);

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(docId)
        .collection('messages')
        .doc(messageDocId)
        .delete();
  }

  Future<String> _getDocIdForDelete({
    required String messageId,
    required String docId,
  }) async {
    var data = await FirebaseFirestore.instance
        .collection('chats')
        .doc(docId)
        .collection('messages')
        .where('messageId', isEqualTo: messageId)
        .get();
    String messageDocId = data.docs.first.id;
    return messageDocId;
  }

  String _getMyPhoneNumber() {
    final String myPhoneNumber = firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
    return myPhoneNumber;
  }
}
