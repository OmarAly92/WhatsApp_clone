part of 'chat_details_cubit.dart';

abstract class ChatDetailsState extends Equatable {
  const ChatDetailsState();
}

class ChatDetailsInitial extends ChatDetailsState {
  @override
  List<Object> get props => [];
}

class ChatDetailsSuccess extends ChatDetailsState {
  final List<MessageModel> messages;
  final String myPhoneNumber;

  const ChatDetailsSuccess(
      {required this.messages, required this.myPhoneNumber});

  @override
  List<Object> get props => [messages, myPhoneNumber];
}

class ChatDetailsFailure extends ChatDetailsState {
  final String failureMessage;

  const ChatDetailsFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}
