import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/themes/text_style/text_styles.dart';
import '../../../../../../core/themes/theme_color.dart';
import '../../../../view_model/chat_details_cubit/chat_detail_parent_cubit.dart';

class ChatDetailsAppBar extends StatelessWidget {
  const ChatDetailsAppBar({
    super.key,
    required this.themeColors,
    required this.hisName,
    required this.hisProfilePicture,
    required this.hisPhoneNumber,
  });

  final String hisName;
  final ThemeColors themeColors;
  final String hisProfilePicture;
  final String hisPhoneNumber;

  @override
  Widget build(BuildContext context) {
    double iconSize = 25.r;

    return BlocBuilder<ChatDetailParentCubit, ChatDetailParentState>(
      buildWhen: (previous, current) {
        if (current is ChatDetailParentReplying) {
          return false;
        } else if (current is ChatDetailParentNotReplying) {
          return false;
        } else {
          return true;
        }
      },
      builder: (context, state) {
        bool longPressedAppbarState = (state is ChatDetailParentLongPressedAppbar);
        return SliverAppBar(
          toolbarHeight: 50.h,
          leadingWidth: 65.w,
          titleSpacing: 1.w,
          backgroundColor: longPressedAppbarState ? themeColors.appbarLongPressedColor : themeColors.appbarColor,
          leading: buildLeadingOnState(state, context),
          title: buildTitleOnState(state),
          actions: buildActionOnState(context, state, iconSize),
        );
      },
    );
  }

  List<Widget> buildActionOnState(
    BuildContext context,
    ChatDetailParentState state,
    double iconSize,
  ) {
    int selectedItemCount = BlocProvider.of<ChatDetailParentCubit>(context).selectedItemCount;
    List<String>? globalMessageType;

    List<Widget> actions = [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.videocam_rounded,
          color: themeColors.privateChatAppBarColor,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.call_rounded,
          color: themeColors.privateChatAppBarColor,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.more_vert,
          color: themeColors.privateChatAppBarColor,
        ),
      ),
    ];
    List<Widget> actionsLongPress = [
      IconButton(
        onPressed: () {
          List<bool> isTheSender = BlocProvider.of<ChatDetailParentCubit>(context).isTheSender;
          List<String> messageType = BlocProvider.of<ChatDetailParentCubit>(context).messageType;
          globalMessageType = messageType;
          List<String> message = BlocProvider.of<ChatDetailParentCubit>(context).replyOriginalMessage;
          final Color replyColor = isTheSender.first ? const Color(0xff068D72) : const Color(0xff8d7ed8);
          final String hisNames = isTheSender.first ? 'You' : hisName;

          if (messageType.first != 'deleted') {
            BlocProvider.of<ChatDetailParentCubit>(context).replyMessageTrigger(
              replyMessage: message.first,
              hisName: hisNames,
              replyColor: replyColor,
            );
          }
          BlocProvider.of<ChatDetailParentCubit>(context).closeLongPressedAppbar();
        },
        icon: Icon(
          Icons.reply,
          color: themeColors.privateChatAppBarColor,
          size: iconSize,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.star_rounded,
          color: themeColors.privateChatAppBarColor,
          size: iconSize,
        ),
      ),
      IconButton(
        onPressed: () async {
          await BlocProvider.of<ChatDetailParentCubit>(context)
              .deleteSelectedMessages(hisPhoneNumber: hisPhoneNumber);
        },
        icon: Icon(
          Icons.delete,
          color: themeColors.privateChatAppBarColor,
          size: iconSize,
        ),
      ),
      Transform(
        transform: Matrix4.rotationY(3.141),
        alignment: Alignment.center,
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.reply,
            color: themeColors.privateChatAppBarColor,
            size: iconSize,
          ),
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.more_vert,
          color: themeColors.privateChatAppBarColor,
          size: iconSize,
        ),
      ),
    ];
    List<Widget> actionsLongPressMultiReply = [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.star_rounded,
          color: themeColors.privateChatAppBarColor,
          size: iconSize,
        ),
      ),
      IconButton(
        onPressed: () async {
          await BlocProvider.of<ChatDetailParentCubit>(context)
              .deleteSelectedMessages(hisPhoneNumber: hisPhoneNumber);
        },
        icon: Icon(
          Icons.delete,
          color: themeColors.privateChatAppBarColor,
          size: iconSize,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.copy,
          color: themeColors.privateChatAppBarColor,
          size: iconSize,
        ),
      ),
      Transform(
        transform: Matrix4.rotationY(3.141),
        alignment: Alignment.center,
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.reply,
            color: themeColors.privateChatAppBarColor,
            size: iconSize,
          ),
        ),
      ),
    ];
    if ( globalMessageType?.single == 'deleted') {
      return [
        IconButton(
          onPressed: () async {
            await BlocProvider.of<ChatDetailParentCubit>(context)
                .deleteSelectedMessages(hisPhoneNumber: hisPhoneNumber);
          },
          icon: Icon(
            Icons.delete,
            color: themeColors.privateChatAppBarColor,
            size: iconSize,
          ),
        ),
      ];
    } else if (selectedItemCount > 1) {
      return actionsLongPressMultiReply;
    } else {
      return (state is ChatDetailParentInitial) ? actions : actionsLongPress;
    }
  }

  AnimatedSwitcher buildTitleOnState(ChatDetailParentState state) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      child: (state is ChatDetailParentLongPressedAppbar)
          ? SizedBox(
              key: const Key('ChatDetailParentLongPressedAppbar'),
              height: 50.h,
              width: double.infinity,
              child: InkWell(
                onTap: () {},
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      '${state.selectedItemCount}',
                      style: Styles.textStyle24.copyWith(
                        color: themeColors.privateChatAppBarColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : SizedBox(
              key: const Key('else'),
              height: 50.h,
              width: double.infinity,
              child: InkWell(
                onTap: () {},
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      hisName,
                      style: Styles.textStyle18.copyWith(
                        color: themeColors.privateChatAppBarColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  AnimatedSwitcher buildLeadingOnState(ChatDetailParentState state, BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      child: (state is ChatDetailParentInitial)
          ? Row(
              key: const Key('ChatDetailParentInitial'),
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20.r),
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_rounded,
                        size: 25.r,
                        color: themeColors.privateChatAppBarColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 2,
                          top: 2,
                          bottom: 2,
                          left: 0,
                        ),
                        child: Container(
                          height: 35.r,
                          width: 35.r,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.r),
                            child: Image.network(hisProfilePicture, fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Row(
              key: const Key('else'),
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.r),
                    onTap: () {
                      BlocProvider.of<ChatDetailParentCubit>(context).closeLongPressedAppbar();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_rounded,
                          size: 25.r,
                          color: themeColors.privateChatAppBarColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
