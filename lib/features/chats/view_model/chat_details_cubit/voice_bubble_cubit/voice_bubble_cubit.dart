import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whats_app_clone/core/functions/global_functions.dart';

part 'voice_bubble_state.dart';

class VoiceBubbleCubit extends Cubit<VoiceBubbleState> {
  VoiceBubbleCubit() : super(VoiceBubbleInitial()) {
    playerController = PlayerController();
  }

  StreamSubscription? subscription;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late PlayerController playerController;

  Future<void> checkIfFileExistsAndPlayOrDownload(
      {required String voiceUrl, required String hisPhoneNumber}) async {
    Directory? appDocDir = await getDownloadsDirectory();
    String voiceFileName = _gettingNameForVoiceFile(voiceUrl, hisPhoneNumber);

    var voiceFilePath = '${appDocDir?.path}/$voiceFileName';

    bool fileExists = await File(voiceFilePath).exists();

    if (fileExists) {
      _preparePlayerControllerRecording(voiceFilePath);
      emit(VoiceBubbleVoiceExists(voiceFilePath: voiceFilePath));
    } else {
      emit(VoiceBubbleVoiceNotExists());

      downloadVoiceFile(voiceUrl: voiceUrl, hisPhoneNumber: hisPhoneNumber);
    }
  }

  void downloadVoiceFile({required String voiceUrl, required String hisPhoneNumber}) async {
    emit(const VoiceBubbleLoading(progress: 0));
    String finalVoiceFileName = _gettingNameForVoiceFile(voiceUrl, hisPhoneNumber);
    Directory? appDocDir = await getDownloadsDirectory();

    Dio dio = Dio();
    try {
      Response response = await dio.download(voiceUrl, '${appDocDir?.path}/$finalVoiceFileName');
      if (response.statusCode == 200) {
        _preparePlayerControllerRecording('${appDocDir?.path}/$finalVoiceFileName');
        emit(VoiceBubbleVoiceExists(voiceFilePath: '${appDocDir?.path}/$finalVoiceFileName'));
      } else {
        throw Exception('Failed to download voice file');
      }
    } catch (e) {
      throw Exception('Failed to download voice file: $e');
    }
  }

  void playAndPause() async {
    subscription = playerController.onPlayerStateChanged.listen((playerState) {
      if (playerState == PlayerState.playing) {
        emit(VoiceBubbleIsPlaying());
      } else {
        emit(VoiceBubbleIsNotPlaying());
      }
    });

    if (playerController.playerState == PlayerState.playing) {
      await playerController.pausePlayer();
    } else {
      await playerController.startPlayer(finishMode: FinishMode.pause);
    }
  }

  Future<void> _preparePlayerControllerRecording(String voiceFilePath) async =>
      await playerController.preparePlayer(path: voiceFilePath);

  String _getMyPhoneNumber() {
    final String myPhoneNumber = firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
    return myPhoneNumber;
  }

  String _gettingNameForVoiceFile(String voiceUrl, String hisPhoneNumber) {
    String myPhoneNumber = _getMyPhoneNumber();

    String sortedNumbers = GlFunctions.sortPhoneNumbers(hisPhoneNumber, myPhoneNumber);

    String finalVoiceFileName = voiceUrl.replaceAll(
        'https://firebasestorage.googleapis.com/v0/b/whats-app-clone-4fe8a.appspot.com/o/chats%2F$sortedNumbers%2Fvoice%2F',
        '');

    return finalVoiceFileName.substring(0, 16);
  }
}
