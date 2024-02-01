part of 'send_messages_cubit.dart';

abstract class SendMessagesState extends Equatable {
  const SendMessagesState();
}

class SendMessagesInitial extends SendMessagesState {
  @override
  List<Object> get props => [];
}

class SendMessagesRecordStart extends SendMessagesState {
  @override
  List<Object> get props => [];
}

// class SendMessagesRecordStop extends SendMessagesState {
//   @override
//   List<Object> get props => [];
// }

class SendMessagesFailure extends SendMessagesState {
  final String failureMessage;

  const SendMessagesFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}
