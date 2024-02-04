import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/global_functions.dart';
import '../../../../core/networking/model/user_model/user_model.dart';
import '../../data/repository/chats_repository.dart';

part 'select_contact_state.dart';

class SelectContactCubit extends Cubit<SelectContactState> {
  SelectContactCubit(this._chatsRepository) : super(SelectContactInitial());

  final ChatsRepository _chatsRepository;

  void sortingContactData() async {
    emit(SelectContactLoading());
    try {
      final localContacts = await _chatsRepository.getLocalContact();

      final fireBaseUserData = await _chatsRepository.getFireBaseUserData();

      final List<String?> localContactPhoneNumbers =
          localContacts.map((e) => (e.phones!.first.value).toString().replaceAll(' ', '')).toList();

      final List<UserModel> result =
          fireBaseUserData.where((element) => localContactPhoneNumbers.contains(element.phoneNumber)).toList();

      emit(SelectContactSuccess(userModel: result));
    } catch (e) {
      emit(SelectContactFailure(
          failureMessage: 'catch failure -----------${e.toString()}----------- catch failure'));
    }
  }

  void createChatRoom({required UserModel friendContactUserModel}) async {
    final String myPhoneNumber = await GlFunctions.getMyPhoneNumber();
    final hisDoc = _chatsRepository.getSingleUserDoc(phoneNumber: friendContactUserModel.phoneNumber);
    final myDoc = _chatsRepository.getSingleUserDoc(phoneNumber: myPhoneNumber);

    _chatsRepository.creatingChatRoom(
      hisDoc: hisDoc,
      myDoc: myDoc,
      myPhoneNumber: myPhoneNumber,
      hisPhoneNumber: friendContactUserModel.phoneNumber,
    );
  }
}
