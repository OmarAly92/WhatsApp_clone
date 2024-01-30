import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  void createAccountWithEmailAndPassword({
    required String userImage,
    required String name,
    required String emailAddress,
    required String password,
    required String phoneNumber,
  }) async {
    emit(AuthenticationLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );


      emit(AuthenticationSuccess());
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

  void loginInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    emit(AuthenticationLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
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
