import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
    required String type,
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
        'type': type,
      });
      chatDocument.update({
        'lastMessage': message,
        'lastMessageTime': time,
      });
    } catch (failureMessage) {
      emit(ChatDetailsFailure(failureMessage: '$failureMessage OMAR'));
    }
  }

  Future<String> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String imagePath = pickedFile.path;
      return imagePath;
    } else {
      throw Exception();
    }
  }

  void sendImage({
    required String phoneNumber,
    required String type,
    required Timestamp time,
  }) async {
    try {
      final String imagePath = await pickImageFromGallery();
      var myPhoneNumber =
          firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
      List<String> sortedNumber = [phoneNumber, myPhoneNumber]..sort();
      final File imageFile = File(imagePath);

      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('chats')
          .child('images')
          .child(sortedNumber.join('-'))
          .child('${time.microsecondsSinceEpoch}.jpg');

      final UploadTask uploadTask = storageReference.putFile(imageFile);

      await uploadTask.whenComplete(() => print('Image uploaded'));

      final image = await storageReference.getDownloadURL();

      fireBaseInit
          .collection('chats')
          .doc(sortedNumber.join('-'))
          .collection('messages')
          .doc()
          .set({
        'isSeen': false,
        'message': image,
        'theSender': myPhoneNumber,
        'time': time,
        'type': type,
      });
    } catch (e) {
      emit(const ChatDetailsFailure(
          failureMessage: 'Failed to upload the Image'));
    }
  }

  String getMyPhoneNumber() {
    final String myPhoneNumber =
        firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
    return myPhoneNumber;
  }
}
