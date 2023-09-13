import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/themes/theme_color.dart';
import '../../../../core/app_router/app_router.dart';
import '../../../../data/model/chat_model/chat_model.dart';
import 'chat_item.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({
    super.key,
    required this.themeColors,
    required this.chats,
    // required this.user,
  });

  final ThemeColors themeColors;
  final List<ChatsModel> chats;

  // final List<UserModel> user;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        ChatsModel itemChat = chats[index];
        // UserModel itemUser = user[3];
        DateTime dateTime = itemChat.lastMessageTime.toDate();
        String formattedTime = DateFormat('h:mm a').format(dateTime);
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRouter.chatDetailScreen,
              arguments: {
                'hisPicture': itemChat.users!.profilePicture,
                'hisPhoneNumber': itemChat.users!.userPhone,
                'hisName': itemChat.users!.userName,
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChatItem(
              themeColors: themeColors,
              contactName: itemChat.users!.userName,
              time: formattedTime,
              lastMessage: itemChat.lastMessage,
              profileImage: itemChat.users!.profilePicture,
            ),
          ),
        );
      },
    );
  }
}
