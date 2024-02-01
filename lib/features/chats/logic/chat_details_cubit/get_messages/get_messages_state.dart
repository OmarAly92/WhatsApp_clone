
part of 'get_messages_cubit.dart';

abstract class GetMessagesState extends Equatable {
  const GetMessagesState();
}

class GetMessagesInitial extends GetMessagesState {
  @override
  List<Object> get props => [];
}


class GetMessagesLoading extends GetMessagesState {

  const GetMessagesLoading();

  @override
  List<Object> get props => [];
}
class GetMessagesSuccess extends GetMessagesState {
  final List<MessageModel> messages;
  final String myPhoneNumber;

  const GetMessagesSuccess({required this.messages, required this.myPhoneNumber});

  @override
  List<Object> get props => [messages, myPhoneNumber];
}

class GetMessagesFailure extends GetMessagesState {
  final String failureMessage;

  const GetMessagesFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}
