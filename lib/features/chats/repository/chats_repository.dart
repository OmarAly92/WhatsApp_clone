import 'package:contacts_service/contacts_service.dart';


import '../../../data/data_source/chats/chats_requests.dart';
import '../../../data/model/chat_model/chat_model.dart';
import '../../../data/model/user_model/user_model.dart';

class ChatsRepository {
  final ChatsRequest chatsRequest;

  ChatsRepository(this.chatsRequest);

  Stream<List<ChatsModel>> getChats(String myPhoneNumber) {
    return chatsRequest.getChatsFromFireStore(myPhoneNumber).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ChatsModel.fromSnapshot(doc)).toList();
    });
  }

  Future<List<UserModel>> getFireBaseUserData() async {
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

  Future<List<Contact>> getLocalContact() async {
    return await chatsRequest.getLocalContact();
  }

  Future<UserModel> checkUserNameIsNotEmpty(String myPhoneNumber) async {
    var userQuerySnapshot =
        await chatsRequest.getUserCollection().where('userPhone', isEqualTo: myPhoneNumber).get();
    UserModel user = UserModel.fromQuerySnapshot(userQuerySnapshot);
    return user;
  }

  Future<void> creatingChatRoom({
    required UserModel friendContactUserModel,
    required UserModel myContactUserModel,

  }) async {
    await chatsRequest.creatingChatRoom(
      friendContactUserModel: friendContactUserModel,
      myContactUserModel: myContactUserModel,

    );
  }
}
