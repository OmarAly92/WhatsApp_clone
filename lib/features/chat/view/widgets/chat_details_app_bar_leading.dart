import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/theme_color.dart';
import '../../../../core/utils/assets_data.dart';

class ChatDetailsAppBarLeading extends StatelessWidget {
  const ChatDetailsAppBarLeading({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_rounded,
                size: 25.r,
                color: themeColors.privateChatAppBarColor,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 2,
                  top: 2,
                  bottom: 2,
                  left: 0,
                ),
                child: Container(
                  height: 35.r,
                  width: 35.r,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: Image.asset(kTestOmar),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
