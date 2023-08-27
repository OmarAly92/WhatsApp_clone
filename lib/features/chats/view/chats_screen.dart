import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/themes/theme_color.dart';
import '../../../core/app_router/app_router.dart';
import '../view_model/chats_cubit/chats_cubit.dart';
import 'widgets/chat_item.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key, required this.themeColors});

  final ThemeColors themeColors;

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    super.initState();
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
            builder: (context, state) {
              if (state is ChatsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ChatsSuccess) {
                return ListView.builder(
                  itemCount: state.chats.length,
                  itemBuilder: (context, index) {
                    var item = state.chats[index];
                    if (item.messages.isNotEmpty) {
                      return InkWell(
                        onTap: () {
                          GoRouter.of(context)
                              .push(AppRouter.chatDetailScreen, extra: index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ChatItem(
                            themeColors: widget.themeColors,
                            contactName: item.users.last.userName,
                            // Access the last user's name
                            time: item.messages.last.time.length >= 11
                                ? item.messages.last.time
                                    .replaceRange(0, 11, '')
                                : item.messages.last.time,

                            lastMessage: item.messages.last.message,
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox
                          .shrink(); // Return an empty widget if users or messages are empty
                    }
                  },
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
