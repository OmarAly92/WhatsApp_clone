import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

import '../view_model/chat_details_cubit/get_messages/get_messages_cubit.dart';
import 'widgets/chat_details_screen_widgets/chat_details_components/app_bar.dart';
import 'widgets/chat_details_screen_widgets/chat_details_components/chat_details_body.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({
    Key? key,
    required this.themeColors,
    required this.hisPhoneNumber,
    required this.hisName,
    required this.hisProfilePicture,
  }) : super(key: key);

  final ThemeColors themeColors;
  final String hisPhoneNumber;
  final String hisName;
  final String hisProfilePicture;

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  GetMessagesCubit getMessagesCubit() {
    GetMessagesCubit bloc = BlocProvider.of<GetMessagesCubit>(context);
    return bloc;
  }

  @override
  void dispose() {
    getMessagesCubit().messagesSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    getMessagesCubit().getMessages(hisPhoneNumber: widget.hisPhoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(context, (route) => route.isFirst);
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            ChatDetailsAppBar(
              themeColors: widget.themeColors,
              hisName: widget.hisName,
              hisProfilePicture: widget.hisProfilePicture,
              hisPhoneNumber: widget.hisPhoneNumber,
            ),
            SliverFillRemaining(
              child: Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.themeColors.chatBackGroundImage),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: ChatDetailsBody(
                  themeColors: widget.themeColors,
                  hisPhoneNumber: widget.hisPhoneNumber,
                  hisProfilePicture: widget.hisProfilePicture,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
