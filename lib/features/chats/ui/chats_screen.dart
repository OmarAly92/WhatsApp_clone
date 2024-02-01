import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/theme_color.dart';
import '../../../data/model/user_model/user_model.dart';
import '../logic/chats_cubit/chats_cubit.dart';
import 'widgets/chats_screen_widgets/chat_screen_user_name_alert_dialog.dart';
import 'widgets/chats_screen_widgets/chats_list_view.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key, required this.themeColors});

  final ThemeColors themeColors;

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  void checkUserNameIsNotEmpty({
    required UserModel userModel,
    required ThemeColors themeColors,
  }) async {
    if (userModel.userName.isEmpty) {
      await showDialog(
        context: context,
        builder: (context) {
          return UserNameAlertDialogWidget(
            themeColors: themeColors,
            userModel: userModel,
          );
        },
      );
    }
  }

  Future<void> getUserModel() async {
    UserModel userModel = await BlocProvider.of<ChatsCubit>(context).checkUserNameIsNotEmpty();
    checkUserNameIsNotEmpty(
      userModel: userModel,
      themeColors: widget.themeColors,
    );
  }

  @override
  void initState() {
    getUserModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 10.h),
        Expanded(
          child: BlocBuilder<ChatsCubit, ChatsState>(
            buildWhen: (previous, current) {
              if (current is ListenToLastMessage) {
                return false;
              } else {
                return true;
              }
            },
            builder: (context, state) {
              if (state is ChatsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ChatsSuccess) {
                return ChatsListView(
                  themeColors: widget.themeColors,
                  chats: state.chats,
                  // user: state.user,
                );
              } else if (state is ChatsFailure) {
                return Center(child: Text(state.failureMessage));
              } else {
                return const Center(child: Text('INTA STATe OMAR'));
              }
            },
          ),
        ),
      ],
    );
  }
}
