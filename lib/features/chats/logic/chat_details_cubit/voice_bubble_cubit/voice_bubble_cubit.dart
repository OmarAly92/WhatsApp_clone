import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../core/functions/global_functions.dart';

part 'voice_bubble_state.dart';

class VoiceBubbleCubit extends Cubit<VoiceBubbleState> {
  VoiceBubbleCubit() : super(VoiceBubbleInitial()) {
    dio = Dio();
  }

  StreamSubscription? currentDurationChangedSubscription;
  StreamSubscription? playerStateChangedSubscription;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final PlayerController audioPlayerController = PlayerController();
  late final Dio dio;

  String checkVoicePath = '';

  Future<void> checkIfFileExistsAndPlayOrDownload({
    required String voiceUrl,
    required String hisPhoneNumber,
  }) async {
    final Directory? appDocDir = await getDownloadsDirectory();
    final String myPhoneNumber = await GlFunctions.getMyPhoneNumber();

    final String voiceFileName = _gettingNameForVoiceFile(
      voiceUrl: voiceUrl,
      hisPhoneNumber: hisPhoneNumber,
      myPhoneNumber: myPhoneNumber,
    );
    final String voiceFilePath = '${appDocDir?.path}/$voiceFileName';
    final bool fileExists = await File(voiceFilePath).exists();

    if (fileExists) {
      try {
        emit(VoiceBubbleVoiceExistence(voiceFilePath: voiceFilePath, isExisted: true));
        // emit(VoiceBubbleLoading(progress: 0));
      } catch (error) {
        emit(VoiceBubbleError(errorMessage: 'Player initialization failed: $error'));
      }
    } else {
      emit(VoiceBubbleVoiceExistence(voiceFilePath: voiceFilePath, isExisted: false));
      try {
        await downloadVoiceFile(
          voiceUrl: voiceUrl,
          hisPhoneNumber: hisPhoneNumber,
        );
      } catch (error) {
        emit(VoiceBubbleError(errorMessage: 'Download failed: $error'));
      }
    }
  }

  Future<void> downloadVoiceFile({
    required String voiceUrl,
    required String hisPhoneNumber,
  }) async {
    emit(const VoiceBubbleLoading(progress: 0));
    final String myPhoneNumber = await GlFunctions.getMyPhoneNumber();

    final String finalVoiceFileName = _gettingNameForVoiceFile(
      voiceUrl: voiceUrl,
      hisPhoneNumber: hisPhoneNumber,
      myPhoneNumber: myPhoneNumber,
    );
    final Directory? appDocDir = await getDownloadsDirectory();

    try {
      final Response response = await dio.download(voiceUrl, '${appDocDir?.path}/$finalVoiceFileName');
      if (response.statusCode == 200) {
        emit(VoiceBubbleVoiceExistence(
          voiceFilePath: '${appDocDir?.path}/$finalVoiceFileName',
          isExisted: true,
        ));
      } else {
        emit(const VoiceBubbleError(errorMessage: 'else: Failed to download voice file'));
      }
    } catch (error) {
      emit(VoiceBubbleError(errorMessage: 'Failed to download voice file: $error'));
    }
  }

  void playAndPause({
    required String voiceUrl,
    required String hisPhoneNumber,
    required int maxDurationMilliSec,
  }) async {
    final String myPhoneNumber = await GlFunctions.getMyPhoneNumber();

    final String finalVoiceFileName = _gettingNameForVoiceFile(
      voiceUrl: voiceUrl,
      hisPhoneNumber: hisPhoneNumber,
      myPhoneNumber: myPhoneNumber,
    );
    final Directory? appDocDir = await getDownloadsDirectory();

    await _preparePlayerControllerRecording(
      voiceFilePath: '${appDocDir?.path}/$finalVoiceFileName',
    );

    playerStateChangedSubscription = audioPlayerController.onPlayerStateChanged.listen((playerState) {
      if (playerState == PlayerState.playing) {
        emit(const VoiceBubblePlayerState(isPlaying: true, duration: '0:00'));
      } else {
        emit(const VoiceBubblePlayerState(isPlaying: false, duration: '0:00'));
      }
    });

    currentDurationChangedSubscription = audioPlayerController.onCurrentDurationChanged.listen((milliseconds) {
      final String formattedTime = GlFunctions.timeFormatUsingMillisecondVoiceOnly(milliseconds);

      emit(VoiceBubblePlayerState(isPlaying: true, duration: formattedTime));
    });

    if (audioPlayerController.playerState == PlayerState.playing) {
      await audioPlayerController.pausePlayer();
    } else {
      await audioPlayerController.startPlayer(finishMode: FinishMode.pause);
    }
  }

  Future<void> _preparePlayerControllerRecording({
    required String voiceFilePath,
  }) async {
    if (checkVoicePath == voiceFilePath) {
      return;
    } else {
      checkVoicePath = voiceFilePath;
      try {
        audioPlayerController.dispose();

        await audioPlayerController.preparePlayer(path: voiceFilePath);
      } catch (error) {
        emit(VoiceBubbleError(errorMessage: 'Player preparation failed: $error'));
      }
    }
  }

  String _gettingNameForVoiceFile(
      {required String voiceUrl, required String hisPhoneNumber, required String myPhoneNumber}) {
    final String sortedNumbers = GlFunctions.sortPhoneNumbers(hisPhoneNumber, myPhoneNumber);

    final String finalVoiceFileName = voiceUrl.replaceAll(
        // 'https://firebasestorage.googleapis.com/v0/b/whats-app-clone-4fe8a.appspot.com/o/chats%2F$sortedNumbers%2Fvoice%2F',
        'https://firebasestorage.googleapis.com/v0/b/whats-app-clone-4fe8a.appspot.com/o/chats%2F$sortedNumbers%2F',
        '');
    // return finalVoiceFileName.substring(0, 16);
    return finalVoiceFileName.substring(8, 16);
  }

  Future<void> _stopPlayerController() async {
    playerStateChangedSubscription?.cancel();
    currentDurationChangedSubscription?.cancel();
    await audioPlayerController.stopPlayer();
  }

  @override
  Future<void> close() async {
    await _stopPlayerController();
    return super.close();
  }
}
