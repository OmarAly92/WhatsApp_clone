part of 'chat_detail_parent_cubit.dart';

abstract class ChatDetailParentState extends Equatable {
  const ChatDetailParentState();
}

class ChatDetailParentInitial extends ChatDetailParentState {
  final int isSelected;

  final int isSelectedLongPress;

  const ChatDetailParentInitial({this.isSelected = -1, this.isSelectedLongPress = -1});

  @override
  List<Object> get props => [isSelected, isSelectedLongPress];
}

class ChatDetailParentLongPressedAppbar extends ChatDetailParentState {
  final int selectedItemCount;

  const ChatDetailParentLongPressedAppbar({
    required this.selectedItemCount,
  });

  @override
  List<Object> get props => [selectedItemCount];
}

class ChatDetailParentFailure extends ChatDetailParentState {
  final String failureMessage;

  const ChatDetailParentFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

class ChatDetailParentReplying extends ChatDetailParentState {
  final MessageModel originalMessage;
  final String hisName;
  final Color replyColor;

  const ChatDetailParentReplying( {
    required this.originalMessage,
    required this.hisName,
    required this.replyColor,
  });

  @override
  List<Object> get props => [originalMessage, hisName, replyColor];
}

class ChatDetailParentNotReplying extends ChatDetailParentState {
  const ChatDetailParentNotReplying();

  @override
  List<Object> get props => [];
}
