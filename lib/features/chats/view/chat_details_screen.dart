import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

import '../view_model/chat_details_cubit/get_messages/get_messages_cubit.dart';
import 'widgets/chat_details_app_bar_leading.dart';
import 'widgets/chat_details_app_bar_title.dart';
import 'widgets/chat_details_body.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({
    Key? key,
    required this.themeColors,
    required this.hisPhoneNumber,
    required this.hisName,
    required this.hisPicture,
  }) : super(key: key);

  final ThemeColors themeColors;
  final String hisPhoneNumber;
  final String hisName;
  final String hisPicture;

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetMessagesCubit>(context).getMessages(hisNumber: widget.hisPhoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChatDetailsAppBar(),
      body: ChatDetailsBody(
        themeColors: widget.themeColors,
        hisPhoneNumber: widget.hisPhoneNumber,
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
      leading: ChatDetailsAppBarLeading(
        themeColors: widget.themeColors,
        hisPicture: widget.hisPicture,
      ),
      leadingWidth: 65.w,
      titleSpacing: 1.w,
      title: ChatDetailsAppBarTitle(
        themeColors: widget.themeColors,
        name: widget.hisName,
      ),
      actions: actions,
    );
  }
}