import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:whats_app_clone/core/networking/model/chat_model/message_model.dart';
import 'package:whats_app_clone/core/networking/model/user_model/user_model.dart';

import '../../../../../core/utils/global_functions.dart';
import '../../../data/repository/chat_details_repository.dart';

part 'send_messages_state.dart';

class SendMessagesCubit extends Cubit<SendMessagesState> {
  SendMessagesCubit(this._chatDetailsRepository) : super(SendMessagesInitial()) {
    _initialiseController();
  }

  StreamSubscription? pushTokenSub;

  final ChatDetailsRepository _chatDetailsRepository;
  final Uuid _uuid = const Uuid();
  late final RecorderController _recorderController;

  late String pushToken;

  void getHisPushToken({required String hisPhoneNumber}) {
    pushTokenSub = _chatDetailsRepository.getHisPushToken(phoneNumber: hisPhoneNumber).listen((pushToken) {
      this.pushToken = pushToken;
    });
  }

  void sendMessage({
    required UserModel hisUserModel,
    required String message,
    required String type,
    required Timestamp time,
  }) async {
    try {
      final myUserData = await GlFunctions.getMyUserData();
      final String sortedNumbers = GlFunctions.sortPhoneNumbers(hisUserModel.phoneNumber, myUserData.phoneNumber);

      final MessageModel messageModel = MessageModel(
        isSeen: '',
        emojiReact: '',
        message: message,
        time: time,
        messageId: _uuid.v4(),
        theSender: myUserData.phoneNumber,
        type: type,
        waveData: const [],
        maxDuration: 0,
        originalMessage: '',
        replyOriginalName: '',
        senderName: myUserData.name,
      );

      _chatDetailsRepository.globalSendMessage(
        sortedNumber: sortedNumbers,
        messageModel: messageModel,
        hisPushToken: pushToken,
        myUserModel: myUserData,
      );
    } catch (failureMessage) {
      emit(SendMessagesFailure(failureMessage: '$failureMessage Failed to sendMessage'));
    }
  }

  void sendReplyMessage({
    required UserModel hisUserModel,
    required String originalMessage,
    required String message,
    required String replyOriginalName,
    required String type,
    required Timestamp time,
  }) async {
    try {
      final myUserData = await GlFunctions.getMyUserData();
      final sortedNumber = GlFunctions.sortPhoneNumbers(hisUserModel.phoneNumber, myUserData.phoneNumber);

      MessageModel messageModel = MessageModel(
        isSeen: '',
        emojiReact: '',
        message: message,
        time: time,
        messageId: _uuid.v4(),
        theSender: myUserData.phoneNumber,
        type: type,
        waveData: const [],
        maxDuration: 0,
        originalMessage: originalMessage,
        replyOriginalName: replyOriginalName,
        senderName: myUserData.name,
      );

      _chatDetailsRepository.globalSendMessage(
        sortedNumber: sortedNumber,
        messageModel: messageModel,
        hisPushToken: pushToken,
        myUserModel: myUserData,
      );
    } catch (failureMessage) {
      emit(SendMessagesFailure(failureMessage: '$failureMessage Failed to send reply message'));
    }
  }

  void sendImage({
    required UserModel hisUserModel,
    required Timestamp time,
    required String type,
  }) async {
    try {
      final myUserData = await GlFunctions.getMyUserData();
      final sortedNumber = GlFunctions.sortPhoneNumbers(hisUserModel.phoneNumber, myUserData.phoneNumber);

      final String imagePath = await _getImagePathFromStorage(
          myPhoneNumber: myUserData.phoneNumber, phoneNumber: hisUserModel.phoneNumber, time: time);

      MessageModel messageModel = MessageModel(
        isSeen: '',
        emojiReact: '',
        message: imagePath,
        time: time,
        messageId: _uuid.v4(),
        theSender: myUserData.phoneNumber,
        type: type,
        waveData: const [],
        maxDuration: 0,
        originalMessage: '',
        replyOriginalName: '',
        senderName: myUserData.name,
      );

      _chatDetailsRepository.globalSendMessage(
        sortedNumber: sortedNumber,
        messageModel: messageModel,
        hisPushToken: pushToken,
        myUserModel: myUserData,
      );
    } catch (e) {
      emit(const SendMessagesFailure(failureMessage: 'Failed to upload the Image'));
    }
  }

  Future<void> updateMessageReadStatus({
    required String messageId,
    required String hisPhoneNumber,
  }) async {
    final String myPhoneNumber = await GlFunctions.getMyPhoneNumber();
    final String chatDocId = GlFunctions.sortPhoneNumbers(myPhoneNumber, hisPhoneNumber);
    await _chatDetailsRepository.updateMessageReadStatus(chatDocId: chatDocId, messageId: messageId);
  }

  Future<void> stopRecording({
    required UserModel hisUserModel,
    required Timestamp time,
    required int maxDuration,
  }) async {
    List<double> waveData = _recorderController.waveData.toList();

    final String? path = await _recorderController.stop();
    final UserModel myUserData = await GlFunctions.getMyUserData();

    try {
      final finalPath = await _uploadVoiceToStorage(
          myPhoneNumber: myUserData.phoneNumber,
          phoneNumber: hisUserModel.phoneNumber,
          time: time,
          voicePathFromStopMethod: path!);
      final String sortedNumber = GlFunctions.sortPhoneNumbers(hisUserModel.phoneNumber, myUserData.phoneNumber);

      final MessageModel messageModel = MessageModel(
        isSeen: '',
        emojiReact: '',
        message: finalPath,
        time: time,
        messageId: _uuid.v4(),
        theSender: myUserData.phoneNumber,
        type: 'voice',
        waveData: waveData,
        maxDuration: maxDuration,
        originalMessage: '',
        replyOriginalName: '',
        senderName: myUserData.name,
      );

      _chatDetailsRepository.globalSendMessage(
        sortedNumber: sortedNumber,
        messageModel: messageModel,
        hisPushToken: pushToken,
        myUserModel: myUserData,
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

  @override
  Future<void> close() {
    pushTokenSub?.cancel();
    return super.close();
  }
}
