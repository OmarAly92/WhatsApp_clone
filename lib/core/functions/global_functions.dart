import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  static String getMyPhoneNumber() {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final String myPhoneNumber = firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
    return myPhoneNumber;
  }
}
