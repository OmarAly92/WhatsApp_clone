import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whats_app_clone/core/networking/model/user_model/user_model.dart';
import 'package:whats_app_clone/features/chats/data/data_source/chats/chats_requests.dart';

import '../dependency_injection/get_it.dart';

abstract class GlFunctions {
  ChatsRequest chatsRequest = sl();

  static String sortPhoneNumbers(String firstNumber, secondNumber) {
    List<String> result = [firstNumber, secondNumber]..sort();

    return result.join('-');
  }

  static String timeFormat(Timestamp time) {
    DateTime lastDateTime = time.toDate();
    String formattedLastDateTime = DateFormat('h:mm a').format(lastDateTime);

    return formattedLastDateTime;
  }

  static String timeFormatUsingMillisecondVoiceOnly(int durationInMilliSec) {
    var seconds = (durationInMilliSec / 1000).round();
    Duration duration = Duration(seconds: seconds);
    String formattedTime = DateFormat('m:ss').format(DateTime.utc(0, 1, 1, 0, 0, 0).add(duration));

    return formattedTime;
  }

  static String timeFormatUsingMillisecondHM(int durationInMilliSec) {
    String formattedTime = DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(durationInMilliSec));
    return formattedTime;
  }

  static Future<String> getMyPhoneNumber() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final String myEmail = firebaseAuth.currentUser!.email!;
    final userDoc = await firebaseFirestore.collection('users').where('userEmail', isEqualTo: myEmail).get();
    final userModel = UserModel.fromQueryDocumentSnapshot(userDoc.docs.first);
    final String myPhoneNumber = userModel.phoneNumber;
    return myPhoneNumber;
  }
  static Future<UserModel> getMyUserData() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final String myEmail = firebaseAuth.currentUser!.email!;
    final userDoc = await firebaseFirestore.collection('users').where('userEmail', isEqualTo: myEmail).get();
    final userModel = UserModel.fromQueryDocumentSnapshot(userDoc.docs.first);
    return userModel;
  }

  static Future<String> getMyEmail() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final String myEmail = firebaseAuth.currentUser!.email!;
    return myEmail;
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static Future<void> updateActiveStatus({
    required bool isOnline,
  }) async {
    final firebaseFirestore = FirebaseFirestore.instance;
    final String email = await GlFunctions.getMyEmail();
    final userQuerySnapshot = firebaseFirestore.collection('users').doc(email);
    await userQuerySnapshot.update({
      'isOnline': isOnline,
      'lastActive': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
