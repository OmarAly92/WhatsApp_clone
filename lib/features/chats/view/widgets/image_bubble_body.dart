import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

import '../../../../core/themes/text_style/text_styles.dart';

class ImageBubbleBody extends StatelessWidget {
  const ImageBubbleBody({
    super.key,
    required this.image,
    required this.isTheSender,
    required this.themeColors,
    required this.time,
  });

  final String image;
  final String time;
  final bool isTheSender;
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: 250.h,
          ),
          decoration: BoxDecoration(
            color: isTheSender ? themeColors.myMessage : themeColors.hisMessage,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 7.h, right: 10.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                time,
                style: Styles.textStyle12.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isTheSender
                      ? themeColors.myMessageTime
                      : themeColors.hisMessageTime,
                ),
              ),
              Icon(
                Icons.done,
                size: 17,
                color: isTheSender
                    ? themeColors.myMessageTime
                    : themeColors.hisMessageTime,
              )
            ],
          ),
        ),
      ],
    );
  }
}
