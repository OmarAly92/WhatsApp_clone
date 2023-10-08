import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whats_app_clone/core/functions/global_functions.dart';

import '../../../../data/model/chat_model/message_model.dart';
import '../../repository/chat_details_repository.dart';

part 'chat_details_state.dart';

class ChatDetailsCubit extends Cubit<ChatDetailsState> {
  ChatDetailsCubit(this.chatDetailsRepository) : super(ChatDetailsInitial());
  final ChatDetailsRepository chatDetailsRepository;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void getMessages({required String hisNumber}) {
    final String myPhoneNumber = getMyPhoneNumber();
    chatDetailsRepository.getMessages(hisNumber: hisNumber, myPhoneNumber: myPhoneNumber).listen((messages) {
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
      chatDetailsRepository.sendMessage(
          phoneNumber: phoneNumber, message: message, myPhoneNumber: myPhoneNumber, type: type, time: time);
    } catch (failureMessage) {
      emit(ChatDetailsFailure(failureMessage: '$failureMessage Failed to sendMessage'));
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
    required Timestamp time,
    required String type,
  }) async {
    try {
      var myPhoneNumber = firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
      String imagePath =
          await getImagePathFromStorage(myPhoneNumber: myPhoneNumber, phoneNumber: phoneNumber, time: time);
      chatDetailsRepository.sendImage(
        phoneNumber: phoneNumber,
        time: time,
        type: type,
        myPhoneNumber: myPhoneNumber,
        imagePath: imagePath,
      );
    } catch (e) {
      emit(const ChatDetailsFailure(failureMessage: 'Failed to upload the Image'));
    }
  }

  Future<String> getImagePathFromStorage({
    required String myPhoneNumber,
    required String phoneNumber,
    required Timestamp time,
  }) async {
    final String imageFromGallery = await pickImageFromGallery();

    final File imageFile = File(imageFromGallery);

    List<String> sortedNumber = GlFunctions.sortPhoneNumbers(phoneNumber, myPhoneNumber);
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats')
        .child(sortedNumber.join('-'))
        .child('images')
        .child('${time.microsecondsSinceEpoch}Image.jpg');

    final UploadTask uploadTask = storageReference.putFile(imageFile);

    await uploadTask.whenComplete(() => print('Image uploaded'));

    final imagePath = await storageReference.getDownloadURL();

    return imagePath;
  }

  String getMyPhoneNumber() {
    final String myPhoneNumber = firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
    return myPhoneNumber;
  }

// void startRecord() async {
//   DateTime currentDateTime = DateTime.now();
//
//   int timestamp = currentDateTime.millisecondsSinceEpoch;
//
//    final String voicePath = '${timestamp}audio.mp4';
//
//    try {
//      await recorder.startRecorder(
//        codec: Codec.mp3,
//        toFile: voicePath,
//      );
//    } catch (e) {
//      emit(const ChatDetailsFailure(
//          failureMessage: 'Failed to upload the Voice'));
//    }
//
//    this.voicePath = voicePath;
//  }
//
//  void stopRecord() async {
//    try {
//      await recorder.stopRecorder();
//    } catch (e) {
//      emit(const ChatDetailsFailure(
//          failureMessage: 'Failed to upload the Voice'));
//    }
//  }
//
//  void sendVoice({
//    required String phoneNumber,
//  }) async {
//
//    DateTime currentDateTime = DateTime.now();
//
//    int timestamp = currentDateTime.millisecondsSinceEpoch;
//    var myPhoneNumber =
//        firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
//    List<String> sortedNumber = [phoneNumber, myPhoneNumber]..sort();
//
//    final Reference storageReference = FirebaseStorage.instance
//        .ref()
//        .child('chats')
//        .child(sortedNumber.join('-'))
//        .child('voice')
//        .child('${timestamp}voice.mp3');
//    UploadTask uploadTask = storageReference.putFile(File(voicePath!));
//    uploadTask.whenComplete(() {
//      print('Audio uploaded to Firebase Storage');
//    });
//    // final UploadTask uploadTask = storageReference.putFile(imageFile);
//
//    // await uploadTask.whenComplete(() => print('Image uploaded'));
//
//    final voice = await storageReference.getDownloadURL();
//
//    fireBaseInit
//        .collection('chats')
//        .doc(sortedNumber.join('-'))
//        .collection('messages')
//        .doc()
//        .set({
//      'isSeen': false,
//      'message': voice,
//      'theSender': myPhoneNumber,
//      'time': timestamp,
//      'type': 'voice',
//    });
//  }
}
