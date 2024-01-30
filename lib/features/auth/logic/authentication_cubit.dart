import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/data/model/user_model/user_model.dart';

import '../../../core/parameters_data/user_login_data.dart';
import '../../../core/parameters_data/user_sign_up.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> createAccountWithEmailAndPassword({required UserSignUpData userSignUpData}) async {
    emit(AuthenticationLoading());
    try {
      final userDoc = await _firebaseFirestore
          .collection('users')
          .where('userPhone', isEqualTo: userSignUpData.phoneNumber)
          .get();
      final userModel = userDoc.docs.map((e) => UserModel.fromQueryDocumentSnapshot(e));
      if (userDoc.docs.isEmpty || userSignUpData.phoneNumber != userModel.single.userPhone) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: userSignUpData.emailAddress, password: userSignUpData.password)
            .timeout(
          const Duration(seconds: 15),
          onTimeout: () {
            throw Exception('Timeout');
          },
        );
        await _createUserProfileDoc(userSignUpData: userSignUpData);
        emit(AuthenticationSuccess());
      } else {
        print('Phone number already used OMAR');
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
    const String defaultImage =
        'https://firebasestorage.googleapis.com/v0/b/whats-app-clone-4fe8a.appspot.com/o/default%2Fdefault_profile_picture.jpg?alt=media&token=facbc559-4b44-4f58-b21d-2e101dfa2da7';

    final CollectionReference createUser = _firebaseFirestore.collection('users');

    final DocumentSnapshot documentSnapshot = await createUser.doc(userSignUpData.emailAddress).get();
    if (!documentSnapshot.exists) {
      var userId = _firebaseAuth.currentUser!.uid;
      createUser.doc(userSignUpData.emailAddress).set({
        'isOnline': true,
        'userId': userId,
        'userName': userSignUpData.name,
        'userEmail': userSignUpData.emailAddress,
        'userPhone': userSignUpData.phoneNumber,
        'profileImage': defaultImage,
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
}
