part of 'chats_cubit.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();
}

class ChatsInitial extends ChatsState {
  @override
  List<Object> get props => [];
}


class ChatsLoading extends ChatsState {
  @override
  List<Object> get props => [];
}

class ChatsGettingUserReady extends ChatsState {
  @override
  List<Object> get props => [];
}

class ChatsSuccess extends ChatsState {
  final List<ChatModel> chats;
  final String myPhoneNumber;

  const ChatsSuccess({required this.chats, required this.myPhoneNumber});

  @override
  List<Object> get props => [chats, myPhoneNumber];
}


class ChatsFailure extends ChatsState {
  final String failureMessage;

  const ChatsFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}