import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../core/functions/global_functions.dart';

part 'image_bubble_state.dart';

class ImageBubbleCubit extends Cubit<ImageBubbleState> {
  ImageBubbleCubit() : super(ImageBubbleInitial()) {
    dio = Dio();
  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late final Dio dio;

  String checkImagePath = '';

  Future<void> checkIfFileExistsAndPlayOrDownload({
    required String imageUrl,
    required String hisPhoneNumber,
  }) async {
    final Directory? appDocDir = await getDownloadsDirectory();
    final String imageFileName = _gettingNameForImageFile(imageUrl, hisPhoneNumber);
    final String imageFilePath = '${appDocDir?.path}/$imageFileName';
    final bool fileExists = await File(imageFilePath).exists();

    if (fileExists) {
      try {
        emit(ImageBubbleImageExistence(imageFilePath: imageFilePath, isExisted: true));
        // emit(ImageBubbleLoading(progress: 0));
      } catch (error) {
        emit(ImageBubbleError(errorMessage: 'Player initialization failed: $error'));
      }
    } else {

      emit(ImageBubbleImageExistence(imageFilePath: imageFilePath, isExisted: false));
      try {
        await downloadImageFile(
          imageUrl: imageUrl,
          hisPhoneNumber: hisPhoneNumber,
        );
      } catch (error) {
        emit(ImageBubbleError(errorMessage: 'Download failed: $error'));
      }
    }
  }

  Future<void> downloadImageFile({
    required String imageUrl,
    required String hisPhoneNumber,
  }) async {
    emit(const ImageBubbleLoading(progress: 0));
    final String finalImageFileName = _gettingNameForImageFile(imageUrl, hisPhoneNumber);
    final Directory? appDocDir = await getDownloadsDirectory();
    try {
      final Response response = await dio.download(imageUrl, '${appDocDir?.path}/$finalImageFileName');
      if (response.statusCode == 200) {
        emit(ImageBubbleImageExistence(
          imageFilePath: '${appDocDir?.path}/$finalImageFileName',
          isExisted: true,
        ));
      } else {
        emit(const ImageBubbleError(errorMessage: 'else: Failed to download Image file'));
      }
    } catch (error) {
      emit(ImageBubbleError(errorMessage: 'Failed to download Image file: $error'));
    }
  }

  String _gettingNameForImageFile(String imageUrl, String hisPhoneNumber) {
    final String myPhoneNumber = _getMyPhoneNumber();

    final String sortedNumbers = GlFunctions.sortPhoneNumbers(hisPhoneNumber, myPhoneNumber);

    final String finalImageFileName = imageUrl.replaceAll(
        'https://firebasestorage.googleapis.com/v0/b/whats-app-clone-4fe8a.appspot.com/o/chats%2F$sortedNumbers%2F',
        '');

    return finalImageFileName.substring(8, 16);
  }

  String _getMyPhoneNumber() {
    final String myPhoneNumber = firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
    return myPhoneNumber;
  }
}
