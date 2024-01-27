import 'package:flutter/material.dart';

import '../../../../../../core/themes/theme_color.dart';
import '../../../../../core/app_router/app_router.dart';
import '../../../../../data/model/chat_model/chat_model.dart';
import 'chat_item.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({
    super.key,
    required this.themeColors,
    required this.chats,
  });

  final ThemeColors themeColors;
  final List<ChatsModel> chats;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        var itemUserChat = chats[index].usersData;
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRouter.chatDetailScreen,
              arguments: {
                'hisPicture': itemUserChat.values.first.profilePicture,
                'hisPhoneNumber': itemUserChat.values.first.userPhone,
                'hisName': itemUserChat.values.first.userName,
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChatItem(
              themeColors: themeColors,
              contactName: itemUserChat.values.first.userName,
              profileImage: itemUserChat.values.first.profilePicture,
              hisPhoneNumber: itemUserChat.values.first.userPhone,
            ),
          ),
        );
      },
    );
  }
}
