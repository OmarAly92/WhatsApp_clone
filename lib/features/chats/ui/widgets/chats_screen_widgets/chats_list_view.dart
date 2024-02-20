import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/core/networking/model/user_model/user_model.dart';

import '../../../../../../core/themes/theme_color.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/dependency_injection.dart';
import '../../../../../core/networking/model/chat_model/chat_model.dart';
import '../../../logic/chats_cubit/chats_cubit.dart';
import 'chat_item.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({
    super.key,
    required this.themeColors,
    required this.chats, required this.users,
  });

  final ThemeColors themeColors;
  final List<ChatsModel> chats;
  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRouter.chatDetailScreen,
              arguments: {
                'userModel': users[index],
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocProvider(
              create: (context) => ChatsCubit(sl()),
              child: ChatItem(
                themeColors: themeColors,
                contactName:users[index].name,
                profileImage: users[index].profilePicture,
                hisPhoneNumber: users[index].phoneNumber,
              ),
            ),
          ),
        );
      },
    );
  }
}
