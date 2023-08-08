import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/updates/view/widgets/update_row_status_and_icon.dart';

import 'widgets/status_item.dart';

class UpdatesScreen extends StatelessWidget {
  const UpdatesScreen({super.key, required this.themeColors});

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UpdateRowStatusAndIcon(themeColors: themeColors),
        SizedBox(height: 8.h),
        StatusItem(
          themeColors: themeColors,
          textTitle: 'My status',
          textSubTitle: 'Tap to add status update',
          isMyStatus: true,
        ),
        SizedBox(height: 8.h),
        Text(
          'Recent updates',
          style: Styles.textStyle12.copyWith(
            color: themeColors.bodyTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.h),
        StatusItem(
          themeColors: themeColors,
          textTitle: 'Rehan',
          textSubTitle: '8:36 am',
          isMyStatus: false,
        ),
      ],
    );
  }
}
