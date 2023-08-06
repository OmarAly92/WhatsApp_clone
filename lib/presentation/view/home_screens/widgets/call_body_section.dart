import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/presentation/view/home_screens/widgets/create_call_link_widget.dart';

import 'call_item.dart';

class CallBodySection extends StatelessWidget {
  const CallBodySection({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CreateCallLinkWidget(themeColors: themeColors),
        SizedBox(height: 17.h),
        Text(
          'Recent',
          style: Styles.textStyle16.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 17.h),
        CallItem(themeColors: themeColors),
      ],
    );
  }
}
