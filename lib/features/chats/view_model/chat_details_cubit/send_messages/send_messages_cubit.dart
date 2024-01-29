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
  SendMessagesCubit(this._chatDetailsRepository) : super(SendMessagesInitial()) {
    _initialiseController();
  }

  final ChatDetailsRepository _chatDetailsRepository;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Uuid _uuid = const Uuid();
  late final RecorderController _recorderController;

  void sendMessage({
    required String phoneNumber,
    required String message,
    required String myPhoneNumber,
    required String type,
    required Timestamp time,
  }) async {
    try {
      _chatDetailsRepository.sendMessage(
        phoneNumber: phoneNumber,
        message: message,
        myPhoneNumber: myPhoneNumber,
        type: type,
        time: time,
        messageId: _uuid.v4(),
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
      _chatDetailsRepository.sendReplyMessage(
        phoneNumber: phoneNumber,
        originalMessage: originalMessage,
        message: message,
        replyOriginalName: replyOriginalName,
        theSender: theSender,
        type: type,
        time: time,
        messageId: _uuid.v4(),
      );
    } catch (failureMessage) {
      emit(SendMessagesFailure(failureMessage: '$failureMessage Failed to send reply message'));
    }
  }

  void sendImage({
    required String phoneNumber,
    required Timestamp time,
    required String type,
  }) async {
    try {
      var myPhoneNumber = _firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
      String imagePath =
          await _getImagePathFromStorage(myPhoneNumber: myPhoneNumber, phoneNumber: phoneNumber, time: time);
      _chatDetailsRepository.sendImage(
        phoneNumber: phoneNumber,
        time: time,
        type: type,
        myPhoneNumber: myPhoneNumber,
        imagePath: imagePath,
        messageId: _uuid.v4(),
      );
    } catch (e) {
      emit(const SendMessagesFailure(failureMessage: 'Failed to upload the Image'));
    }
  }

  Future<void> updateMessageReadStatus({
    required String messageId,
    required String hisPhoneNumber,
  }) async {
    final String myPhoneNumber =  GlFunctions.getMyPhoneNumber();
    final String chatDocId = GlFunctions.sortPhoneNumbers(myPhoneNumber, hisPhoneNumber);
    await _chatDetailsRepository.updateMessageReadStatus(chatDocId: chatDocId, messageId: messageId);
  }

  Future<void> stopRecording(Timestamp time, String phoneNumber, int maxDuration) async {
    List<double> waveData = _recorderController.waveData.toList();

    String? path = await _recorderController.stop();
    String myPhoneNumber =  GlFunctions.getMyPhoneNumber();

    try {
      var finalPath = await _uploadVoiceToStorage(
          myPhoneNumber: myPhoneNumber, phoneNumber: phoneNumber, time: time, voicePathFromStopMethod: path!);

      _chatDetailsRepository.sendVoice(
        phoneNumber: phoneNumber,
        time: time,
        type: 'voice',
        myPhoneNumber: myPhoneNumber,
        voicePath: finalPath,
        waveData: waveData,
        maxDuration: maxDuration,
        messageId: _uuid.v4(),
      );

      emit(SendMessagesInitial());
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  void startRecording() async {
    final path = await _getVoiceFilePath();

    await _recorderController.record(path: path);
  }

  Future<String> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String imagePath = pickedFile.path;
      return imagePath;
    } else {
      throw Exception();
    }
  }

  Future<String> _getImagePathFromStorage({
    required String myPhoneNumber,
    required String phoneNumber,
    required Timestamp time,
  }) async {
    final String imageFromGallery = await _pickImageFromGallery();

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



  Future<String> _getVoiceFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/myFile.m4a';
  }

  void _initialiseController() {
    _recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 16000;
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
