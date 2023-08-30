import 'package:flutter/material.dart';

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
  final List<ChatModel> chats;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatsLength,
      itemBuilder: (context, index) {
        var item = chats[index];

        if (item.messages.isNotEmpty) {
          return InkWell(
            onTap: () {
              // GoRouter.of(context)
              //     .push(AppRouter.chatDetailScreen, extra: index);
              Navigator.pushNamed(
                context,
                AppRouter.chatDetailScreen,
                arguments: index,

              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChatItem(
                themeColors: themeColors,
                contactName: '${item.users.last.userName}   $index',
                time: item.messages.last.time.length >= 11
                    ? item.messages.last.time.replaceRange(0, 11, '')
                    : item.messages.last.time,
                lastMessage: item.messages.last.message,
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
