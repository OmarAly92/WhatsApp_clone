import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/theme_color.dart';
import '../../../../core/widgets/custom_circle_image.dart';
import 'chat_item_body.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.themeColors,
    required this.contactName,
    required this.time,
    required this.lastMessage,
  });

  final ThemeColors themeColors;
  final String contactName;
  final String time;
  final String lastMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomCircleImage(),
        SizedBox(width: 13.w),
        ChatItemBody(
          themeColors: themeColors,
          contactName: contactName,
          lastMessage: lastMessage,
          time: time,
        ),
      ],
    );
  }
}
