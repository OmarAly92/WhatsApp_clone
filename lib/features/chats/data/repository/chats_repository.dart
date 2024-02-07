import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_contacts/fast_contacts.dart';

import '../../../../core/networking/model/chat_model/chat_model.dart';
import '../../../../core/networking/model/chat_model/message_model.dart';
import '../../../../core/networking/model/user_model/user_model.dart';
import '../data_source/chats/chats_requests.dart';

class ChatsRepository {
  final ChatsRequest chatsRequest;

  ChatsRepository(this.chatsRequest);

  Future<Stream<List<ChatsModel>>> getChats(String myPhoneNumber) async {
    final snapshot = chatsRequest.getChatsFromFireStore(myPhoneNumber).snapshots();
    return snapshot.map((event) {
      final result = event.docs.map((doc) => ChatsModel.fromSnapshot(doc)).toList();
      return result;
    });
  }

  Future<List<UserModel>> getFireBaseUserData() async {
    final userSnapshot = await chatsRequest.getUserCollection().get();
    final fireBaseUsers = userSnapshot.docs.map((e) => UserModel.fromQueryDocumentSnapshot((e))).toList();
    return fireBaseUsers;
  }

  DocumentReference<Map<String, dynamic>> getSingleUserDoc({required String phoneNumber}) {
    final userSnapshot = chatsRequest.getUserCollection().doc(phoneNumber);
    return userSnapshot;
  }

  Future<List<Contact>> getLocalContact() async {
    return await chatsRequest.getLocalContact();
  }

  Future<void> creatingChatRoom({
    required DocumentReference<Map<String, dynamic>> myDoc,
    required DocumentReference<Map<String, dynamic>> hisDoc,
    required String myPhoneNumber,
    required String hisPhoneNumber,
  }) async {
    await chatsRequest.creatingChatRoom(
      hisDoc: hisDoc,
      myDoc: myDoc,
      myPhoneNumber: myPhoneNumber,
      hisPhoneNumber: hisPhoneNumber,
    );
  }

  Stream<List<MessageModel>> getLastMessage({
    required String hisNumber,
    required String myPhoneNumber,
  }) {
    var lastMessage = chatsRequest.getLastMessage(hisNumber: hisNumber, myPhoneNumber: myPhoneNumber);
    return lastMessage.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => MessageModel.fromSnapshot(doc)).toList();
    });
  }

  void sendUserName(String userName) {
    chatsRequest.sendUserName;
  }

  Future<void> updateActiveStatus({
    required bool isOnline,
  }) async {
    await chatsRequest.updateActiveStatus(isOnline: isOnline);
  }
}
