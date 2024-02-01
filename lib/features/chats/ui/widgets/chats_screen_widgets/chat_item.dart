import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/theme_color.dart';
import '../../../../../core/widgets/custom_circle_image.dart';
import '../../../logic/chats_cubit/chats_cubit.dart';
import 'chat_item_body.dart';

class ChatItem extends StatefulWidget {
  const ChatItem({
    super.key,
    required this.themeColors,
    required this.contactName,
    required this.profileImage,
    required this.hisPhoneNumber,
  });

  final ThemeColors themeColors;
  final String contactName;
  final String hisPhoneNumber;
  final String profileImage;

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatsCubit>(context).getLastMessage(hisNumber: widget.hisPhoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleImage(profileImage: widget.profileImage),
        SizedBox(width: 13.w),
        ChatItemBody(
          themeColors: widget.themeColors,
          contactName: widget.contactName,
          hisPhoneNumber: widget.hisPhoneNumber,
        ),
      ],
    );
  }
}
