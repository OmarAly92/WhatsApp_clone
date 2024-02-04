import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/functions/global_functions.dart';
import '../../../core/networking/model/user_model/user_model.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> getSettingData() async {
    try {
      final String myPhoneNumber = await GlFunctions.getMyPhoneNumber();

      final userRawData = await _firebaseFirestore.collection('users').doc(myPhoneNumber).get();

      final UserModel user = UserModel.fromQueryDocumentSnapshot(userRawData);

      emit(SettingsSuccess(user: user));
    } catch (e) {
      emit(const SettingsFailure(failureMessage: 'Failure when getting data'));
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

  void changeProfilePicture() async {
    try {
      final String imagePath = await pickImageFromGallery();
      final String myEmail = await GlFunctions.getMyEmail();

      // final String myPhoneNumber = await GlFunctions.getMyPhoneNumber();
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('users')
          .child(myEmail)
          .child('profile_picture')
          .child('user_profile_picture.jpg');

      final File imageFile = File(imagePath);
      final UploadTask uploadTask = storageReference.putFile(imageFile);

      await uploadTask.whenComplete(() => log('Image uploaded'));

      final image = await storageReference.getDownloadURL();

      _firebaseFirestore.collection('users').doc(myEmail).update({
        'profileImage': image,
      });
    } catch (e) {
      emit(const SettingsFailure(failureMessage: 'Failed to upload the Image'));
    }

    getSettingData();
  }


}
