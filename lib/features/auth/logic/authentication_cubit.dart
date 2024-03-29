import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/networking/model/parameters_data/user_login_data.dart';
import '../../../core/networking/model/parameters_data/user_sign_up.dart';
import '../../../core/networking/model/user_model/user_model.dart';
import '../../../core/utils/constants.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  String imagePath = kNetworkDefaultProfilePicture;

  Future<void> createAccountWithEmailAndPassword({
    required UserSignUpData userSignUpData,
  }) async {
    emit(AuthenticationLoading());
    try {
      final userDoc = await _firebaseFirestore
          .collection('users')
          .where('userPhone', isEqualTo: userSignUpData.phoneNumber)
          .get();
      final userModel = userDoc.docs.map((e) => UserModel.fromQueryDocumentSnapshot(e));
      if (userDoc.docs.isEmpty || userSignUpData.phoneNumber != userModel.single.phoneNumber) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: userSignUpData.emailAddress,
          password: userSignUpData.password,
        )
            .timeout(
          const Duration(seconds: 15),
          onTimeout: ()async {
            emit(const AuthenticationFailure(failureMessage: 'Time out please try again'));
            throw Exception('Timeout');
          },
        );
        await _createUserProfileDoc(userSignUpData: userSignUpData);
        emit(AuthenticationSuccess());
      } else {
        emit(const AuthenticationFailure(failureMessage: 'Phone number already used'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const AuthenticationFailure(failureMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(const AuthenticationFailure(failureMessage: 'The account already exists for that email.'));
      }
    } catch (e) {
      emit(AuthenticationFailure(failureMessage: 'unKnown failure: $e.'));
    }
  }

  Future<void> _createUserProfileDoc({required UserSignUpData userSignUpData}) async {
    final CollectionReference createUser = _firebaseFirestore.collection('users');

    final DocumentSnapshot documentSnapshot = await createUser.doc(userSignUpData.phoneNumber).get();

    final String defaultImage = await changeProfilePicture(
      myEmail: userSignUpData.emailAddress,
      imagePath: imagePath,
    );

    if (!documentSnapshot.exists) {
      final userId = _firebaseAuth.currentUser!.uid;
      createUser.doc(userSignUpData.phoneNumber).set({
        'isOnline': userSignUpData.isOnline,
        'lastActive': userSignUpData.lastActive,
        'userId': userId,
        'userName': userSignUpData.name,
        'userEmail': userSignUpData.emailAddress,
        'userPhone': userSignUpData.phoneNumber,
        'profileImage': defaultImage,
        'pushToken': '',
      });
    }
  }

  void loginInWithEmailAndPassword({required UserLoginData userLoginData}) async {
    emit(AuthenticationLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userLoginData.emailAddress, password: userLoginData.password)
          .timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          emit(const AuthenticationFailure(failureMessage: 'Time out please try again'));
          throw Exception('Timeout');
        },
      );
      emit(AuthenticationSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(const AuthenticationFailure(failureMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(const AuthenticationFailure(failureMessage: 'Wrong password provided for that user.'));
      }
    }
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePath = pickedFile.path;
      emit(AuthenticationProfileImageChanged(profileImage: imagePath));
    } else {
      imagePath = kNetworkDefaultProfilePicture;
    }
  }

  Future<String> changeProfilePicture({required String myEmail, required String imagePath}) async {
    if (imagePath != kNetworkDefaultProfilePicture) {
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

      return image;
    } else {
      return kNetworkDefaultProfilePicture;
    }
  }
}
