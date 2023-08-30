import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

// import 'package:intl/intl.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/chats/view_model/chats_cubit/chats_cubit.dart';

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
  State<ChatTextFormAndMicButton> createState() =>
      _ChatTextFormAndMicButtonState();
}

class _ChatTextFormAndMicButtonState extends State<ChatTextFormAndMicButton> {
  TextEditingController chatController = TextEditingController();
  bool isTyping = false;
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String formattedDateTime = DateFormat('yyyy-MM-dd hh:mm a').format(now);
    return Padding(
      padding: EdgeInsets.only(right: 5.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
              decoration: BoxDecoration(
                  color: widget.themeColors.hisMessage,
                  borderRadius: BorderRadius.circular(40)),
              child: buildTextFormField(),
            ),
          ),
          SizedBox(
              height: 48.r,
              width: 48.r,
              child: isTyping
                  ? MicAndSendButton(
                      icons: Icons.send,
                      onPressed: () {
                        BlocProvider.of<ChatsCubit>(context).sendMessage(
                          phoneNumber: widget.phoneNumber,
                          message: chatController.text,
                          myPhoneNumber: widget.myPhoneNumber,
                          time: formattedDateTime,
                        );
                        chatController.clear();
                      })
                  : MicAndSendButton(icons: Icons.mic, onPressed: () {})),
        ],
      ),
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: ChatTextFormPrefixIcon(themeColors: widget.themeColors),
        suffixIcon: ChatTextFormSuffixIcon(themeColors: widget.themeColors),
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