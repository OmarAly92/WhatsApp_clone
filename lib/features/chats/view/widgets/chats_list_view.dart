import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whats_app_clone/data/model/user_model/user_model.dart';

import '../../../../../core/themes/theme_color.dart';
import '../../../../core/app_router/app_router.dart';
import '../../../../data/model/chat_model/chat_model.dart';
import 'chat_item.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({
    super.key,
    required this.themeColors,
    required this.chatsLength,
    required this.chats,
    required this.user,
  });

  final ThemeColors themeColors;
  final int chatsLength;
  final List<ChatsModel> chats;
  final List<UserModel> user;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatsLength,
      itemBuilder: (context, index) {
        var itemChat = chats[index];
        var itemUser = user[index];
        print('${itemChat.users} OMAR EXTRA INFO');
        DateTime dateTime = itemChat.lastMessageTime.toDate();
        String formattedTime = DateFormat('h:mm a').format(dateTime);
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRouter.chatDetailScreen,
              arguments: {
                'hisPhoneNumber': itemUser.userPhone,
                'hisName': itemUser.userName,
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChatItem(
              themeColors: themeColors,
              contactName: itemUser.userName,
              time: formattedTime,
              lastMessage: itemChat.lastMessage,
              profileImage: itemUser.profileImage,
            ),
          ),
        );
      },
    );
  }
}
