import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:swipe_plus/swipe_plus.dart';

import '../../../../../../core/themes/theme_color.dart';
import '../../../../../../data/model/chat_model/message_model.dart';
import '../../../../logic/chat_details_cubit/chat_detail_parent_cubit.dart';
import '../../../../logic/chat_details_cubit/get_messages/get_messages_cubit.dart';
import '../../../../logic/chat_details_cubit/image_bubble_cubit/image_bubble_cubit.dart';
import '../../../../logic/chat_details_cubit/send_messages/send_messages_cubit.dart';
import '../../../../logic/chat_details_cubit/voice_bubble_cubit/voice_bubble_cubit.dart';
import '../deleted_message_bubble/deleted_message_bubble.dart';
import '../image_bubble_components/image_bubble.dart';
import '../message_bubble_components/message_bubble.dart';
import '../reply_bubble_components/reply_bubble.dart';
import '../voice_bubble_components/voice_bubble.dart';
import '../whats_app_text_form_components/whats_app_ text_form_and_mic_button.dart';

part 'message_selection_component.dart';

part 'messages_list_view_component.dart';

class ChatDetailsBody extends StatefulWidget {
  const ChatDetailsBody({
    Key? key,
    required this.themeColors,
    required this.hisPhoneNumber,
    required this.hisProfilePicture,
    required this.hisName,
  }) : super(key: key);
  final ThemeColors themeColors;
  final String hisPhoneNumber;
  final String hisProfilePicture;
  final String hisName;

  @override
  State<ChatDetailsBody> createState() => _ChatDetailsBodyState();
}

class _ChatDetailsBodyState extends State<ChatDetailsBody> {
  bool closeEmoji = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.themeColors.chatBackGroundImage),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: BlocBuilder<GetMessagesCubit, GetMessagesState>(
        builder: (context, state) {
          if (state is GetMessagesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetMessagesSuccess) {
            return Column(
              children: [
                _MessagesListView(
                  hisPhoneNumber: widget.hisPhoneNumber,
                  hisProfilePicture: widget.hisProfilePicture,
                  themeColors: widget.themeColors,
                  state: state,
                  hisName: widget.hisName,
                ),
                WhatsAppTextFormAndMicButton(
                  themeColors: widget.themeColors,
                  hisPhoneNumber: widget.hisPhoneNumber,
                ),
              ],
            );
          } else if (state is GetMessagesInitial) {
            return const Center(child: Text('data GetMessagesInitial'));
          } else if (state is GetMessagesFailure) {
            return Center(child: Text('data GetMessagesFailure ${state.failureMessage}'));
          } else {
            return const Center(child: Text('data ERROR'));
          }
        },
      ),
    );
  }
}
