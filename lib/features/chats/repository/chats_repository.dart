import 'package:contacts_service/contacts_service.dart';
import 'package:whats_app_clone/data/model/chat_model/chat_model.dart';

import '../../../data/data_source/chats/chats_requests.dart';
import '../../../data/model/user_model/user_model.dart';

abstract class BassChatsRepository {
  Stream<List<ChatsModel>> getChats(String myPhoneNumber);

  Future<List<UserModel>> getUserData();

  Future<List<Contact>> getLocalContact();

  Future<UserModel> checkUserNameIsNotEmpty(String myPhoneNumber);

  Future<void> creatingChatRoom({required List<UserModel> contactsList, required String myPhoneNumber});
}

class ChatsRepository extends BassChatsRepository {
  final ChatsRequest chatsRequest;

  ChatsRepository(this.chatsRequest);

  @override
  Stream<List<ChatsModel>> getChats(String myPhoneNumber) {
    return chatsRequest.getChatsFromFireStore(myPhoneNumber).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ChatsModel.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<List<UserModel>> getUserData() async {
    List<UserModel> fireBaseUsers = [];
    final userSnapshot = await chatsRequest.getUserCollection().get();

    if (userSnapshot.docs.isNotEmpty) {
      for (var userDoc in userSnapshot.docs) {
        UserModel userModel = UserModel.fromSnapshot(userDoc);
        fireBaseUsers.add(userModel);
      }
    }
    return fireBaseUsers;
  }

  @override
  Future<List<Contact>> getLocalContact() async {
    return await chatsRequest.getLocalContact();
  }

  @override
  Future<UserModel> checkUserNameIsNotEmpty(String myPhoneNumber) async {
    var userQuerySnapshot =
        await chatsRequest.getUserCollection().where('userPhone', isEqualTo: myPhoneNumber).get();
    UserModel user = UserModel.fromQuerySnapshot(userQuerySnapshot);
    return user;
  }

  @override
  Future<void> creatingChatRoom({required List<UserModel> contactsList, required String myPhoneNumber}) async {
    await chatsRequest.creatingChatRoom(contactsList: contactsList, myPhoneNumber: myPhoneNumber);
  }
}
