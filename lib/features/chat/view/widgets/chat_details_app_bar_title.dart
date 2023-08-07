import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

class ChatDetailsAppBarTitle extends StatelessWidget {
  const ChatDetailsAppBarTitle({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: InkWell(
        onTap: () {},
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              'Mohamed Badr',
              style: Styles.textStyle18.copyWith(
                color: themeColors.privateChatAppBarColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
