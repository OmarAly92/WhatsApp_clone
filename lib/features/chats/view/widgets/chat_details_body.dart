import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/chats/view/widgets/chat_text_form_and_mic_button.dart';

import '../../view_model/chats_cubit/chats_cubit.dart';
import 'message_bubble.dart';

class ChatDetailsBody extends StatelessWidget {
  const ChatDetailsBody(
      {Key? key, required this.themeColors, required this.chatIndex})
      : super(key: key);
  final ThemeColors themeColors;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (context, state) {
        if (state is ChatsSuccess) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(themeColors.chatBackGroundImage),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.builder(
                        itemCount: state.chats[chatIndex].messages.length,
                        itemBuilder: (context, index) {
                          bool isTheSender = state
                                  .chats[chatIndex].messages[index].theSender ==
                              state.myPhoneNumber;
                          return MessageBubble(
                              themeColors: themeColors,
                              isTheSender: isTheSender,
                              message: state
                                  .chats[chatIndex].messages[index].message,
                              time: state.chats[chatIndex].messages[index].time
                                          .length >=
                                      11
                                  ? state.chats[chatIndex].messages[index].time
                                      .replaceRange(0, 11, '')
                                  : state
                                      .chats[chatIndex].messages[index].time);
                        }),
                  ),
                ),
                ChatTextFormAndMicButton(
                  themeColors: themeColors,
                  myPhoneNumber: state.myPhoneNumber,
                  phoneNumber: state.chats[chatIndex].users.last.userPhone,
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
