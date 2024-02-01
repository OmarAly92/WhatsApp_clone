import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/global_functions.dart';
import '../../../../core/networking/model/user_model/user_model.dart';
import '../../data/repository/chats_repository.dart';

part 'select_contact_state.dart';

class SelectContactCubit extends Cubit<SelectContactState> {
  SelectContactCubit(this.chatsRepository) : super(SelectContactInitial());

  final ChatsRepository chatsRepository;
  final _firestoreFireStoreInit = FirebaseFirestore.instance;

  void sortingContactData() async {
    emit(SelectContactLoading());
    try {
      final localContacts = await chatsRepository.getLocalContact();

      final fireBaseUserData = await chatsRepository.getFireBaseUserData();
      final List<String?> localContactPhoneNumbers =
          localContacts.map((e) => (e.phones!.first.value).toString().replaceAll(' ', '')).toList();

      final List<UserModel> result =
          fireBaseUserData.where((element) => localContactPhoneNumbers.contains(element.userPhone)).toList();

      emit(SelectContactSuccess(userModel: result));
    } catch (e) {
      emit(SelectContactFailure(
          failureMessage: 'catch failure -----------${e.toString()}----------- catch failure'));
    }
  }

  void createChatRoom({required UserModel friendContactUserModel}) async {
    final String myEmail = await GlFunctions.getMyEmail();
    final userData = await _firestoreFireStoreInit.collection('users').doc(myEmail).get();
    final UserModel myContactUserModel = UserModel.fromQueryDocumentSnapshot(userData);

    chatsRepository.creatingChatRoom(
      friendContactUserModel: friendContactUserModel,
      myContactUserModel: myContactUserModel,
    );
  }
}
