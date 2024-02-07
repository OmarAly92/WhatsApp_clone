import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/core/networking/model/user_model/user_model.dart';
import 'package:whats_app_clone/features/chats/logic/chat_details_cubit/send_messages/send_messages_cubit.dart';

import '../../../../core/themes/theme_color.dart';
import '../logic/chat_details_cubit/get_messages/get_messages_cubit.dart';
import 'widgets/chat_details_screen_widgets/chat_details_components/app_bar.dart';
import 'widgets/chat_details_screen_widgets/chat_details_components/chat_details_body.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({
    Key? key,
    required this.themeColors,
    required this.hisUserModel,
  }) : super(key: key);

  final ThemeColors themeColors;
  final UserModel hisUserModel;

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
    BlocProvider.of<SendMessagesCubit>(context).getHisPushToken(hisPhoneNumber: widget.hisUserModel.phoneNumber);
    getMessagesCubit().getMessages(hisPhoneNumber: widget.hisUserModel.phoneNumber);
    getMessagesCubit().getUserInfo(phoneNumber: widget.hisUserModel.phoneNumber);
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
              hisName: widget.hisUserModel.name,
              hisProfilePicture: widget.hisUserModel.profilePicture,
              hisPhoneNumber: widget.hisUserModel.phoneNumber,
            ),
            SliverFillRemaining(
              child: ChatDetailsBody(
                themeColors: widget.themeColors,
                hisUserModel: widget.hisUserModel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
