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
    required this.chatsLength,
    required this.chats,
  });

  final ThemeColors themeColors;
  final int chatsLength;
  final List<ChatsModel> chats;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatsLength,
      itemBuilder: (context, index) {
        var item = chats[index];
        DateTime dateTime = item.lastMessageTime.toDate();
        String formattedTime = DateFormat('h:mm a').format(dateTime);
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRouter.chatDetailScreen,
              arguments: {
                'hisPhoneNumber': item.users.last.userPhone,
                'hisName': item.users.last.userName,
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChatItem(
              themeColors: themeColors,
              contactName: item.users.last.userName,
              time: formattedTime,
              lastMessage: item.lastMessage,
            ),
          ),
        );
      },
    );
  }
}
