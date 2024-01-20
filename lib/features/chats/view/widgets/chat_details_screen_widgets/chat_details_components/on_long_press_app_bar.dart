import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/features/chats/view_model/chat_details_cubit/chat_detail_parent_cubit.dart';

import '../../../../../../core/themes/text_style/text_styles.dart';
import '../../../../../../core/themes/theme_color.dart';

class ChatDetailsOnLongPressAppBar extends StatelessWidget {
  const ChatDetailsOnLongPressAppBar({
    super.key,
    required this.themeColors,
    required this.hisName,
    required this.hisProfilePicture,
    required this.selectedItemCount,
  });

  final int selectedItemCount;
  final String hisName;
  final String hisProfilePicture;
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    double iconSize = 25.r;

    List<Widget> actions = [
      IconButton(
        onPressed: () {},
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
        onPressed: () {},
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

    return SliverAppBar(
      toolbarHeight: 50.h,
      leading: Row(
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
                    size: iconSize,
                    color: themeColors.privateChatAppBarColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      leadingWidth: 65.w,
      titleSpacing: 1.w,
      title: SizedBox(
        height: 50.h,
        width: double.infinity,
        child: InkWell(
          onTap: () {},
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                '$selectedItemCount',
                style: Styles.textStyle24.copyWith(
                  color: themeColors.privateChatAppBarColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
      actions: actions,
    );
  }
}
