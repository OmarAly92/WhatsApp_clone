import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:whats_app_clone/data/model/chat_model/message_model.dart';
import 'package:whats_app_clone/features/chats/view_model/chat_details_cubit/send_messages/send_messages_cubit.dart';

import '../../../../core/themes/theme_color.dart';
import '../../view_model/chat_details_cubit/get_messages/get_messages_cubit.dart';
import 'chat_text_form_and_mic_button.dart';
import 'image_bubble.dart';
import 'message_bubble.dart';
import 'voice_bubble.dart';

class ChatDetailsBody extends StatefulWidget {
  const ChatDetailsBody({
    Key? key,
    required this.themeColors,
    required this.hisPhoneNumber,
  }) : super(key: key);
  final ThemeColors themeColors;
  final String hisPhoneNumber;

  @override
  State<ChatDetailsBody> createState() => _ChatDetailsBodyState();
}

class _ChatDetailsBodyState extends State<ChatDetailsBody> {
  bool haveNip(int index, List<MessageModel> item) {
    if (index == item.length - 1) {
      return true;
    } else if (index == 0) {
      return false;
    } else if (item[(index + 1)].theSender == item[(index + 1) - 1].theSender) {
      return false;
    } else if (item[index + 1].theSender != item[(index + 1) - 1].theSender) {
      return true;
    } else {
      return false;
    }
  }

  Widget messageSelection({
    required String messageType,
    required ThemeColors themeColors,
    required bool isTheSender,
    required String message,
    required String time,
    required bool isFirstMessage,
  }) {
    if (messageType == 'message') {
      return MessageBubble(
        themeColors: themeColors,
        isTheSender: isTheSender,
        message: message,
        time: time,
        isFirstMessage: isFirstMessage,
      );
    } else if (messageType == 'voice') {
      return VoiceBubble(
        themeColors: themeColors,
        isTheSender: isTheSender,
        voice: message,
        // time: time,
        isFirstMessage: isFirstMessage,
      );
    } else {
      return ImageBubble(
        image: message,
        isTheSender: isTheSender,
        themeColors: themeColors,
        time: time,
        isFirstMessage: isFirstMessage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String myPhoneNumber = BlocProvider.of<SendMessagesCubit>(context).getMyPhoneNumber();

    return Stack(
      children: [
        Image(
          height: double.maxFinite,
          width: double.maxFinite,
          image: AssetImage(widget.themeColors.chatBackGroundImage),
          fit: BoxFit.cover,
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            BlocBuilder<GetMessagesCubit, GetMessagesState>(
              builder: (context, state) {
                if (state is GetMessagesSuccess) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          height: 540.h,
                          child: ListView.builder(
                            reverse: true,
                            itemCount: state.messages.length,
                            itemBuilder: (context, index) {
                              List<MessageModel> item = state.messages.reversed.toList();
                              bool isTheSender = item[index].theSender == state.myPhoneNumber;
                              DateTime dateTime = item[index].time.toDate();
                              String formattedTime = DateFormat('h:mm a').format(dateTime);
                              final haveNips = haveNip(index, item);
                              return messageSelection(
                                messageType: item[index].type,
                                themeColors: widget.themeColors,
                                isTheSender: isTheSender,
                                message: item[index].message,
                                time: formattedTime,
                                isFirstMessage: haveNips,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            ChatTextFormAndMicButton(
              themeColors: widget.themeColors,
              myPhoneNumber: myPhoneNumber,
              phoneNumber: widget.hisPhoneNumber,
            ),
          ],
        ),
      ],
    );
  }
}
