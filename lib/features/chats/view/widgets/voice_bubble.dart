import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/core/widgets/custom_circle_image.dart';

class VoiceBubble extends StatelessWidget {
  const VoiceBubble(
      {Key? key, required this.themeColors, required this.isTheSender})
      : super(key: key);
  final ThemeColors themeColors;
  final bool isTheSender;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isTheSender ? themeColors.myMessage : themeColors.hisMessage,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          const CustomCircleImage(profileImage: 'profileImage'),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
