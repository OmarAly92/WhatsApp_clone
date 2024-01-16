import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/features/chats/repository/chats_repository.dart';

import '../../../../data/model/user_model/user_model.dart';

part 'select_contact_state.dart';

class SelectContactCubit extends Cubit<SelectContactState> {
  SelectContactCubit(this.chatsRepository) : super(SelectContactInitial());

  final ChatsRepository chatsRepository;
  final _firestoreFireStoreInit = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sortingContactData() async {
    emit(SelectContactLoading());
    try {
      var localContacts = await chatsRepository.getLocalContact();

      var fireBaseUserData = await chatsRepository.getFireBaseUserData();
      List<String?> localContactPhoneNumbers =
          localContacts.map((e) => (e.phones!.first.value).toString().replaceAll(' ', '')).toList();

      List<UserModel> result =
          fireBaseUserData.where((element) => localContactPhoneNumbers.contains(element.userPhone)).toList();


      emit(SelectContactSuccess(userModel: result));
    } catch (e) {
      emit(SelectContactFailure(
          failureMessage: 'catch failure -----------${e.toString()}----------- catch failure'));
    }
  }

  void createChatRoom({required UserModel friendContactUserModel}) async {
    final String myPhoneNumber = _getMyPhoneNumber();
    var userData = await _firestoreFireStoreInit.collection('users').doc(myPhoneNumber).get();

    final UserModel myContactUserModel = UserModel.fromSnapshot(userData);

    chatsRepository.creatingChatRoom(
      friendContactUserModel: friendContactUserModel,
      myContactUserModel: myContactUserModel,
    );
  }

  String _getMyPhoneNumber() {
    final String myPhoneNumber = _firebaseAuth.currentUser!.phoneNumber!.replaceAll('+2', '');
    return myPhoneNumber;
  }
}