import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/chats/view_model/chats_cubit/chats_cubit.dart';

import '../../../data/model/chat_model/chat_model.dart';
import 'widgets/chat_details_app_bar_leading.dart';
import 'widgets/chat_details_app_bar_title.dart';
import 'widgets/chat_details_body.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({
    Key? key,
    required this.themeColors,
    required this.chatIndex,
  }) : super(key: key);

  final ThemeColors themeColors;
  final int chatIndex;

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  late List<ChatModel> chats;

  @override
  void initState() {
    super.initState();
    chats = BlocProvider.of<ChatsCubit>(context).chats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChatDetailsAppBar(),
      body: ChatDetailsBody(
        themeColors: widget.themeColors,
        chatIndex: widget.chatIndex ,
      ),
    );
  }

  AppBar buildChatDetailsAppBar() {
    List<Widget> actions = [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.videocam_rounded,
          color: widget.themeColors.privateChatAppBarColor,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.call_rounded,
          color: widget.themeColors.privateChatAppBarColor,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.more_vert,
          color: widget.themeColors.privateChatAppBarColor,
        ),
      ),
    ];
    return AppBar(
      toolbarHeight: 50.h,
      leading: ChatDetailsAppBarLeading(themeColors: widget.themeColors),
      leadingWidth: 65.w,
      titleSpacing: 1.w,
      title: ChatDetailsAppBarTitle(
        themeColors: widget.themeColors,
        name: chats[widget.chatIndex].users.last.userName,
      ),
      actions: actions,
    );
  }
}