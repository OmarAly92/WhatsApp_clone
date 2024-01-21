import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/model/user_model/user_model.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  var firestoreInit = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> getSettingData() async {
    try {
      var myPhoneNumber =
          firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');

      var userData =
          await firestoreInit.collection('users').doc(myPhoneNumber).get();

      final UserModel user = UserModel.fromSnapshot(userData);

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
      var myPhoneNumber =
          firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('users')
          .child(myPhoneNumber)
          .child('profile_picture')
          .child('user_profile_picture.jpg');

      final File imageFile = File(imagePath);
      final UploadTask uploadTask = storageReference.putFile(imageFile);

      await uploadTask.whenComplete(() => print('Image uploaded'));

      final image = await storageReference.getDownloadURL();

      firestoreInit.collection('users').doc(myPhoneNumber).update({
        'profileImage': image,
      });
    } catch (e) {
      emit(const SettingsFailure(failureMessage: 'Failed to upload the Image'));
    }

    getSettingData();
  }
}
