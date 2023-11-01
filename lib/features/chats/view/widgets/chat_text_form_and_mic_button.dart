import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/chats/view_model/chat_details_cubit/send_messages/send_messages_cubit.dart';

import 'chat_text_form_prefix_icon.dart';
import 'chat_text_form_suffix_icon.dart';
import 'mic_and_send_button.dart';

class ChatTextFormAndMicButton extends StatefulWidget {
  const ChatTextFormAndMicButton({
    super.key,
    required this.themeColors,
    required this.myPhoneNumber,
    required this.phoneNumber,
  });

  final ThemeColors themeColors;
  final String myPhoneNumber;
  final String phoneNumber;

  @override
  State<ChatTextFormAndMicButton> createState() => _ChatTextFormAndMicButtonState();
}

class _ChatTextFormAndMicButtonState extends State<ChatTextFormAndMicButton> {
  TextEditingController chatController = TextEditingController();
  bool isTyping = false;
  double containerSize = 48.r;
  double iconsSize = 25;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5.w),
      child: SizedBox(
        width: 500,
        child: Stack(
          alignment: Alignment.centerLeft,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 300.w,
              margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
              decoration:
                  BoxDecoration(color: widget.themeColors.hisMessage, borderRadius: BorderRadius.circular(40)),
              child: BlocBuilder<SendMessagesCubit, SendMessagesState>(
                builder: (context, state) {
                  if (state is SendMessagesInitial) {
                    return buildTextFormField(context);
                  } else if (state is SendMessagesRecordStart) {
                    return Container(
                      padding: EdgeInsets.all(11.r),
                      margin: EdgeInsets.only(left: 25.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '0:00',
                            style: Styles.textStyle18.copyWith(
                              color: widget.themeColors.bodyTextColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 16,
                                  color: widget.themeColors.bodyTextColor,
                                ),
                                Text(
                                  'Slide to cancel',
                                  style: Styles.textStyle14.copyWith(
                                    color: widget.themeColors.bodyTextColor,
                                    fontSize: 15.spMin,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is SendMessagesFailure) {
                    return Text('${state.failureMessage} Failure message');
                  } else {
                    return const Text(' else condition message');
                  }
                },
              ),
            ),
            Positioned(
              left: 288.w,
              child: Container(
                color: Colors.blue.withOpacity(.1),
                width: 100,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: containerSize,
                      width: containerSize,
                      child: isTyping
                          ? MicAndSendButton(
                              icons: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                              onTap: () {
                                DateTime now = DateTime.now();
                                Timestamp timestamp = Timestamp.fromDate(now);
                                BlocProvider.of<SendMessagesCubit>(context).sendMessage(
                                  phoneNumber: widget.phoneNumber,
                                  message: chatController.text,
                                  myPhoneNumber: widget.myPhoneNumber,
                                  time: timestamp,
                                  type: 'message',
                                );
                                chatController.clear();
                                setState(() {
                                  isTyping = false;
                                });
                              })
                          : MicAndSendButton(
                              icons: Icon(
                                Icons.mic,
                                color: Colors.white,
                                size: iconsSize,
                              ),
                              onTapDown: (details) {
                                setState(() {
                                  containerSize += 40;
                                  iconsSize +=12;
                                });
                                BlocProvider.of<SendMessagesCubit>(context).startRecording();
                                print('start OMAR');
                              },
                              onTapUp: (details) async {
                                setState(() {
                                  containerSize -= 40;
                                  iconsSize -=12;

                                });
                                var time =
                                    Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
                                await BlocProvider.of<SendMessagesCubit>(context)
                                    .stopRecording(time, widget.phoneNumber);
                                print('end OMAR');
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: ChatTextFormPrefixIcon(themeColors: widget.themeColors),
        suffixIcon: ChatTextFormSuffixIcon(
          themeColors: widget.themeColors,
          phoneNumber: widget.phoneNumber,
          myPhoneNumber: widget.myPhoneNumber,
        ),
        hintText: 'Message',
        hintStyle: Styles.textStyle18.copyWith(
          color: widget.themeColors.bodyTextColor,
        ),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      controller: chatController,
      onChanged: onChanged,
    );
  }

  void onChanged(value) {
    //todo there is setState here remove it in the future
    if (value.isNotEmpty) {
      setState(() {
        isTyping = true;
      });
    } else {
      setState(() {
        isTyping = false;
      });
    }
  }
}
