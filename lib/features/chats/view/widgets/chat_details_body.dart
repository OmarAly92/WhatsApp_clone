import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/chats/view/widgets/chat_text_form_and_mic_button.dart';

import '../../view_model/chats_cubit/chats_cubit.dart';
import 'message_bubble.dart';

class ChatDetailsBody extends StatelessWidget {
  const ChatDetailsBody({
    Key? key,
    required this.themeColors,
    required this.hisPhoneNumber,
  }) : super(key: key);
  final ThemeColors themeColors;
  final String hisPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (context, state) {
        if (state is ListenToMessage) {
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
                        // dragStartBehavior: DragStartBehavior.down,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          bool isTheSender = state.messages[index].theSender ==
                              state.myPhoneNumber;
                          DateTime dateTime =
                              state.messages[index].time.toDate();
                          String formattedTime =
                              DateFormat('h:mm a').format(dateTime);
                          return MessageBubble(
                            themeColors: themeColors,
                            isTheSender: isTheSender,
                            message: state.messages[index].message,
                            time: formattedTime,
                          );
                        }),
                  ),
                ),
                ChatTextFormAndMicButton(
                  themeColors: themeColors,
                  myPhoneNumber: state.myPhoneNumber,
                  phoneNumber: hisPhoneNumber,
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
