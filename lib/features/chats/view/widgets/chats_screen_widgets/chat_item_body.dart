import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/features/chats/view_model/chats_cubit/chats_cubit.dart';

import '../../../../../core/functions/global_functions.dart';
import '../../../../../core/themes/text_style/text_styles.dart';
import '../../../../../core/themes/theme_color.dart';
import 'last_message_text.dart';

class ChatItemBody extends StatelessWidget {
  const ChatItemBody({
    super.key,
    required this.themeColors,
    required this.contactName,
    required this.hisPhoneNumber,
  });

  final ThemeColors themeColors;
  final String contactName;
  final String hisPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
      buildWhen: (previous, current) {
        if (current is ListenToLastMessage) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(contactName, style: Styles.textStyle16),
                  Text(
                    (state is ListenToLastMessage) ? GlFunctions.timeFormat(state.lastMessage.time) : '',
                    style: Styles.textStyle12.copyWith(
                      color: themeColors.bodyTextColor,
                    ),
                  ),
                ],
              ),
              (state is ListenToLastMessage)
                  ? LastMessageText(
                      state: state,
                      themeColors: themeColors,
                    )
                  : const Text(''),
            ],
          ),
        );
      },
    );
  }
}
