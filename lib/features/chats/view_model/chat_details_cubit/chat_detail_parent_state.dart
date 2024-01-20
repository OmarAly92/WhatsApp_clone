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

  const ChatDetailParentLongPressedAppbar({required this.selectedItemCount});

  @override
  List<Object> get props => [selectedItemCount];
}
