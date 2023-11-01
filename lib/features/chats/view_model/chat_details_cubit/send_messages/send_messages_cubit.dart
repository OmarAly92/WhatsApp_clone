import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import '../../../../../core/functions/global_functions.dart';
import '../../../repository/chat_details_repository.dart';

part 'send_messages_state.dart';

class SendMessagesCubit extends Cubit<SendMessagesState> {
  SendMessagesCubit(this.chatDetailsRepository, this.record) : super(SendMessagesInitial());
  final ChatDetailsRepository chatDetailsRepository;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final Record record;

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
      emit(SendMessagesFailure(failureMessage: '$failureMessage Failed to sendMessage'));
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
      emit(const SendMessagesFailure(failureMessage: 'Failed to upload the Image'));
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

  Future<String> getVoiceFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/myFile.m4a';
  }

  Future<void> startRecording() async {
    final status = await Permission.microphone.status;
    await Permission.microphone.request();

    if (status.isGranted) {
      final filePath = await getVoiceFilePath();

      try {
        await record.start(
          path: filePath,
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          samplingRate: 44100,
        );
        emit(SendMessagesRecordStart());
      } catch (e) {
        print('Error starting recording: $e');
      }
    }
  }

  Future<String> uploadVoiceToStorage({
    required String myPhoneNumber,
    required String phoneNumber,
    required Timestamp time,
    required String voicePathFromStopMethod,
  }) async {
    final String voicePathFromStop = voicePathFromStopMethod;

    final File voiceFile = File(voicePathFromStop);

    List<String> sortedNumber = GlFunctions.sortPhoneNumbers(phoneNumber, myPhoneNumber);
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats')
        .child(sortedNumber.join('-'))
        .child('voice')
        .child('${time.microsecondsSinceEpoch}Voice.mp3');

    final UploadTask uploadTask = storageReference.putFile(voiceFile);

    await uploadTask.whenComplete(() => print('voice uploaded'));

    final voicePath = await storageReference.getDownloadURL();

    return voicePath;
  }

  Future<void> stopRecording(Timestamp time, String phoneNumber) async {
    try {
      String? path = await record.stop();
      String myPhoneNumber = getMyPhoneNumber();
      uploadVoiceToStorage(
          myPhoneNumber: myPhoneNumber, phoneNumber: phoneNumber, time: time, voicePathFromStopMethod: path!);
      chatDetailsRepository.sendVoice(
          phoneNumber: phoneNumber, time: time, type: 'voice', myPhoneNumber: myPhoneNumber, voicePath: path);
      emit(SendMessagesInitial());
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }
}
