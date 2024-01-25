import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/functions/global_functions.dart';
import '../../../repository/chat_details_repository.dart';

part 'send_messages_state.dart';

class SendMessagesCubit extends Cubit<SendMessagesState> {
  SendMessagesCubit(this.chatDetailsRepository) : super(SendMessagesInitial()) {
    initialiseController();
  }

  final ChatDetailsRepository chatDetailsRepository;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final Uuid uuid = const Uuid();
  late final RecorderController recorderController;

  void sendMessage({
    required String phoneNumber,
    required String message,
    required String myPhoneNumber,
    required String type,
    required Timestamp time,
  }) async {
    try {
      chatDetailsRepository.sendMessage(
        phoneNumber: phoneNumber,
        message: message,
        myPhoneNumber: myPhoneNumber,
        type: type,
        time: time,
        messageId: uuid.v4(),
      );
    } catch (failureMessage) {
      emit(SendMessagesFailure(failureMessage: '$failureMessage Failed to sendMessage'));
    }
  }

  void sendReplyMessage({
    required String phoneNumber,
    required String originalMessage,
    required String message,
    required String replyOriginalName,
    required String theSender,
    required String type,
    required Timestamp time,
  }) async {
    try {
      chatDetailsRepository.sendReplyMessage(
        phoneNumber: phoneNumber,
        originalMessage: originalMessage,
        message: message,
        replyOriginalName: replyOriginalName,
        theSender: theSender,
        type: type,
        time: time,
        messageId: uuid.v4(),
      );
    } catch (failureMessage) {
      emit(SendMessagesFailure(failureMessage: '$failureMessage Failed to send reply message'));
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
        messageId: uuid.v4(),
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

    String sortedNumber = GlFunctions.sortPhoneNumbers(phoneNumber, myPhoneNumber);
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats')
        .child(sortedNumber)
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

  /// this is the new record methods in  wave_audio package
  void initialiseController() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 16000;
  }

  void startRecording() async {
    final path = await getVoiceFilePath();

    await recorderController.record(path: path);
  }

  Future<void> stopRecording(Timestamp time, String phoneNumber, int maxDuration) async {
    List<double> waveData = recorderController.waveData.toList();

    String? path = await recorderController.stop();
    String myPhoneNumber = getMyPhoneNumber();

    try {
      var finalPath = await _uploadVoiceToStorage(
          myPhoneNumber: myPhoneNumber, phoneNumber: phoneNumber, time: time, voicePathFromStopMethod: path!);

      chatDetailsRepository.sendVoice(
        phoneNumber: phoneNumber,
        time: time,
        type: 'voice',
        myPhoneNumber: myPhoneNumber,
        voicePath: finalPath,
        waveData: waveData,
        maxDuration: maxDuration,
        messageId: uuid.v4(),
      );

      emit(SendMessagesInitial());
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<String> _uploadVoiceToStorage({
    required String myPhoneNumber,
    required String phoneNumber,
    required Timestamp time,
    required String voicePathFromStopMethod,
  }) async {
    final String voicePathFromStop = voicePathFromStopMethod;

    final File voiceFile = File(voicePathFromStop);

    String sortedNumber = GlFunctions.sortPhoneNumbers(phoneNumber, myPhoneNumber);
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats')
        .child(sortedNumber)
        .child('voice')
        .child('${time.microsecondsSinceEpoch}');

    final UploadTask uploadTask = storageReference.putFile(voiceFile);

    await uploadTask.whenComplete(() => print('voice uploaded'));

    final voicePath = await storageReference.getDownloadURL();

    return voicePath;
  }
}
