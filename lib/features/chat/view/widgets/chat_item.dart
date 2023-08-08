import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/theme_color.dart';
import 'chat_item_body.dart';
import '../../../../core/widgets/custom_circle_image.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomCircleImage(),
        SizedBox(width: 13.w),
        ChatItemBody(themeColors: themeColors),
      ],
    );
  }
}
