import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/features/chats/view/widgets/clip_button_pop_up.dart';

import '../../../../core/themes/theme_color.dart';

class ChatTextFormSuffixIcon extends StatelessWidget {
  const ChatTextFormSuffixIcon({
    super.key,
    required this.themeColors,
    required this.phoneNumber,
    required this.myPhoneNumber,
  });

  final ThemeColors themeColors;
  final String phoneNumber;
  final String myPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              showCupertinoModalPopup(
                barrierColor: Colors.transparent,
                context: context,
                builder: (context) => ClipButtonPopUp(
                  themeColors: themeColors,
                  phoneNumber: phoneNumber,
                  myPhoneNumber: myPhoneNumber,
                ),
              );
            },
            icon: Icon(
              CupertinoIcons.paperclip,
              color: themeColors.bodyTextColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.camera_alt_rounded,
              color: themeColors.bodyTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
