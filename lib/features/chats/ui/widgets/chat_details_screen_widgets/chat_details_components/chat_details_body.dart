import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:swipe_plus/swipe_plus.dart';
import 'package:whats_app_clone/core/networking/model/user_model/user_model.dart';

import '../../../../../../core/networking/model/chat_model/message_model.dart';
import '../../../../../../core/themes/theme_color.dart';
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

part 'message_selection.dart';

part 'messages_list_view.dart';

class ChatDetailsBody extends StatefulWidget {
  const ChatDetailsBody({
    Key? key,
    required this.themeColors,
    required this.hisUserModel,
  }) : super(key: key);
  final ThemeColors themeColors;
  final UserModel hisUserModel;

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
        buildWhen: (previous, current) {
          if (current is GetUserInfo) {
            return false;
          } else {
            return true;
          }
        },
        builder: (context, state) {
          if (state is GetMessagesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetMessagesSuccess) {
            return Column(
              children: [
                _MessagesListView(
                  hisUserModel: widget.hisUserModel,
                  themeColors: widget.themeColors,
                  state: state,
                ),
                WhatsAppTextFormAndMicButton(
                  themeColors: widget.themeColors,
                  hisUserModel: widget.hisUserModel,
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
