
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../utils/global_functions.dart';



class GlobalRequests {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> getUserCollection() {
    return _firebaseFirestore.collection('users');
  }

  static CollectionReference<Map<String, dynamic>> getChatsCollection() {
    return _firebaseFirestore.collection('chats');
  }

  static Future<void> getFirebaseMessagingToken() async {
    await FirebaseMessaging.instance.requestPermission();
    final String? pushToken = await messaging.getToken();
    if (pushToken != null) {
      final String myPhoneNumber = await GlFunctions.getMyPhoneNumber();
      final userQuerySnapshot = getUserCollection().doc(myPhoneNumber);
      await userQuerySnapshot.update({
        'pushToken': pushToken,
      });
    }


  }
}
