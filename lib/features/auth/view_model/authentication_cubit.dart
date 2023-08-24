import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  late final String _verificationId;
  final _auth = FirebaseAuth.instance;
  late final String phoneNumber;

  // CollectionReference x =  FirebaseFirestore.instance.collection('').doc().collection('collectionPath');

  void submitPhoneNumber({required String phoneNumber}) async {
    emit(AuthenticationLoading());
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

      emit(const AuthenticationFailure(
          failureMessage: 'The provided phone number is not valid.'));
    }
    print(failureMessage.toString());
    emit(AuthenticationFailure(failureMessage: failureMessage.message!));
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
      await _auth.signInWithCredential(credential);

      CollectionReference createUser =
          FirebaseFirestore.instance.collection('users');
      var userId = _auth.currentUser!.uid;
      createUser.doc(phoneNumber).set({
        'isOnline': true,
        'userId': userId,
        'userName': '',
        'userPhone': phoneNumber,
      });

      emit(PhoneOTPVerified());
    } catch (failureMessage) {
      emit(AuthenticationFailure(failureMessage: failureMessage.toString()));
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
