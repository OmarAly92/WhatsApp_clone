import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/networking/global_requests/global_requests.dart';

import '../../../../core/themes/theme_color.dart';
import '../logic/chats_cubit/chats_cubit.dart';
import 'widgets/chats_screen_widgets/chats_list_view.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key, required this.themeColors});

  final ThemeColors themeColors;

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    GlobalRequests.getFirebaseMessagingToken();
    updateActiveStatus();
    super.initState();
  }

  void updateActiveStatus() {
    BlocProvider.of<ChatsCubit>(context).updateActiveStatus(isOnline: true);
    SystemChannels.lifecycle.setMessageHandler((message) {
      if (message.toString().contains('resume')) {
        BlocProvider.of<ChatsCubit>(context).updateActiveStatus(isOnline: true);
      } else if (message.toString().contains('pause')) {
        BlocProvider.of<ChatsCubit>(context).updateActiveStatus(isOnline: false);
      } else if (message.toString().contains('inactive')) {
        BlocProvider.of<ChatsCubit>(context).updateActiveStatus(isOnline: false);
      } else {
        BlocProvider.of<ChatsCubit>(context).updateActiveStatus(isOnline: false);
      }
      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 10.h),
        Expanded(
          child: BlocBuilder<ChatsCubit, ChatsState>(
            buildWhen: (previous, current) {
              if (current is ListenToLastMessage) {
                return false;
              } else {
                return true;
              }
            },
            builder: (context, state) {
              if (state is ChatsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ChatsSuccess) {
                return ChatsListView(
                  themeColors: widget.themeColors,
                  chats: state.chats,
                  // user: state.user,
                );
              } else if (state is ChatsFailure) {
                return Center(child: Text(state.failureMessage));
              } else {
                return const Center(child: Text('INTA STATe OMAR'));
              }
            },
          ),
        ),
      ],
    );
  }
}
