import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/theme_color.dart';
import 'call_item_body.dart';
import '../../../../core/widgets/custom_circle_image.dart';

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
            const CustomCircleImage(),
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
