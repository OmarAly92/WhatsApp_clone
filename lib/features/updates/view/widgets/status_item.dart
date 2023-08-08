import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/theme_color.dart';
import 'status_item_body.dart';
import 'status_item_image.dart';

class StatusItem extends StatelessWidget {
  const StatusItem({
    super.key,
    required this.themeColors,
    required this.textTitle,
    required this.textSubTitle,
    required this.isMyStatus,
  });

  final ThemeColors themeColors;
  final String textTitle;
  final String textSubTitle;
  final bool isMyStatus;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatusItemImage(isMyStatus: isMyStatus, themeColors: themeColors),
        SizedBox(
          width: 4.w,
        ),
        StatusItemBody(
          textTitle: textTitle,
          textSubTitle: textSubTitle,
          themeColors: themeColors,
        ),
      ],
    );
  }
}

