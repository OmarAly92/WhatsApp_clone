import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_detail_state.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  ChatDetailCubit() : super(ChatDetailInitial());
}
