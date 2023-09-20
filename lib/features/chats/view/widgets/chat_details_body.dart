import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whats_app_clone/data/model/chat_model/message_model.dart';
import 'package:whats_app_clone/features/chats/view_model/chat_details_cubit/chat_details_cubit.dart';

import '../../../../core/themes/theme_color.dart';
import 'chat_text_form_and_mic_button.dart';
import 'image_bubble.dart';
import 'message_bubble.dart';

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
    if (index == 0) {
      return false;
    } else if (index == item.length - 1) {
      return true;
    } else if (item[index].theSender == item[index - 1].theSender) {
      return false;
    } else {
      return true;
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
      return const Text('voice');
    } else {
      return ImageBubble(
        image: message,
        isTheSender: isTheSender,
        themeColors: themeColors,
        time: time,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          height: double.maxFinite,
          width: double.maxFinite,
          image: AssetImage(widget.themeColors.chatBackGroundImage),
          fit: BoxFit.cover,
        ),
        BlocBuilder<ChatDetailsCubit, ChatDetailsState>(
          builder: (context, state) {
            if (state is ChatDetailsSuccess) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        reverse: true,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          List<MessageModel> item = state.messages.reversed.toList();
                          bool isTheSender =
                              item[index].theSender == state.myPhoneNumber;
                          DateTime dateTime = item[index].time.toDate();
                          String formattedTime =
                              DateFormat('h:mm a').format(dateTime);

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
                  ChatTextFormAndMicButton(
                    themeColors: widget.themeColors,
                    myPhoneNumber: state.myPhoneNumber,
                    phoneNumber: widget.hisPhoneNumber,
                  ),
                ],
              );
            } else {
              return const Center(child: Text('initial state'));
            }
          },
        ),
      ],
    );
  }
}
