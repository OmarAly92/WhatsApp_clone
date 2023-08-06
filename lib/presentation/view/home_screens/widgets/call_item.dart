import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/theme_color.dart';
import 'call_item_body.dart';
import 'chat_item_image.dart';

class CallItem extends StatelessWidget {
  const CallItem({super.key, required this.themeColors});

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const ChatItemImage(),
            SizedBox(width: 17.w),
            CallItemBody(themeColors: themeColors),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.call,
            color: themeColors.greenColor,
          ),
        ),
      ],
    );
  }
}
