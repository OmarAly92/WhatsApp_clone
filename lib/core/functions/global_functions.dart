import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class GlFunctions {
  static String sortPhoneNumbers(String firstNumber, secondNumber) {
    List<String> result = [firstNumber, secondNumber]..sort();

    return result.join('-');
  }

  static String timeFormat(Timestamp time) {
    DateTime lastDateTime = time.toDate();
    String formattedLastDateTime = DateFormat('h:mm a').format(lastDateTime);

    return formattedLastDateTime;
  }

  static String timeFormatUsingMillisecond(int durationInMilliSec) {
    var seconds = (durationInMilliSec / 1000).round();
    Duration duration = Duration(seconds: seconds);
    String formattedTime = DateFormat('m:ss').format(DateTime.utc(0, 1, 1, 0, 0, 0).add(duration));

    return formattedTime;
  }

  static Future<String> getMyPhoneNumber() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final String myEmail = firebaseAuth.currentUser!.email!;
    final userDoc = await firebaseFirestore.collection('users').doc(myEmail).get();
    final String myPhoneNumber = userDoc.get('userPhone');
    print('$myPhoneNumber OMAR CHEFIKdnvklosdnv');
    return myPhoneNumber;
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
