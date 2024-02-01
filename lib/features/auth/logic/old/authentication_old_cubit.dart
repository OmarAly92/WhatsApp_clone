import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_old_state.dart';

class AuthenticationOldCubit extends Cubit<AuthenticationOldState> {
  AuthenticationOldCubit() : super(AuthenticationInitialOld());

  final _auth = FirebaseAuth.instance;
  late String _verificationId;
  late String phoneNumber;

  void submitPhoneNumber({required String phoneNumber}) async {
    emit(AuthenticationLoadingOld());
    this.phoneNumber = phoneNumber;
    await _auth.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 60),
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _codeSent,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
    );
  }

  void _verificationCompleted(PhoneAuthCredential credential) async {
    print('verificationCompleted: $credential');
    await _signIn(credential);
  }

  void _verificationFailed(FirebaseAuthException failureMessage) {
    if (failureMessage.code == 'invalid-phone-number') {
      print(failureMessage.toString());

      emit(const AuthenticationFailureOld(failureMessage: 'The provided phone number is not valid.'));
    }
    print(failureMessage.toString());
    emit(AuthenticationFailureOld(failureMessage: failureMessage.message!));
  }

  void _codeSent(String verificationId, int? resendToken) async {
    print('codeSent: $verificationId');

    _verificationId = verificationId;

    emit(PhoneNumberSubmitted());
  }

  void _codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout: $verificationId');
  }

  Future<void> submitOtp(String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );

    await _signIn(credential);
  }

  Future<void> _signIn(PhoneAuthCredential credential) async {
    try {
      const String defaultImage =
          'https://firebasestorage.googleapis.com/v0/b/whats-app-clone-4fe8a.appspot.com/o/default%2Fdefault_profile_picture.jpg?alt=media&token=facbc559-4b44-4f58-b21d-2e101dfa2da7';
      await _auth.signInWithCredential(credential);

      CollectionReference createUser = FirebaseFirestore.instance.collection('users');

      DocumentSnapshot documentSnapshot = await createUser.doc(phoneNumber).get();
      if (documentSnapshot.exists) {
        print('documentSnapshot exists signIn');
      } else {
        var userId = _auth.currentUser!.uid;
        createUser.doc(phoneNumber).set({
          'isOnline': true,
          'userId': userId,
          'userName': '',
          'userPhone': phoneNumber,
          'profileImage': defaultImage,
        });
      }

      emit(PhoneOTPVerified());
    } catch (failureMessage) {
      emit(AuthenticationFailureOld(failureMessage: failureMessage.toString()));
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }

  User getLoggedInUser() {
    User firebaseUser = _auth.currentUser!;
    return firebaseUser;
  }
}
