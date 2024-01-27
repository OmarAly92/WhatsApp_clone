import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

abstract class GlFunctions {
  static String sortPhoneNumbers(String firstNumber, secondNumber) {
    List<String> result = [firstNumber, secondNumber]..sort();

    return result.join('-');
  }


  static  String dateFormat(Timestamp dateTime) {
    DateTime lastDateTime = dateTime.toDate();
    String formattedLastDateTime = DateFormat('h:mm a').format(lastDateTime);

    return formattedLastDateTime;
  }
}
