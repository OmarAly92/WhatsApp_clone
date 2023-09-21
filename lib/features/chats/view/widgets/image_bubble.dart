import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/chats/view/widgets/image_bubble_body.dart';

class ImageBubble extends StatelessWidget {
  const ImageBubble({
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Align(
        alignment: isTheSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: isTheSender
              ? const EdgeInsets.only(left: 40)
              : const EdgeInsets.only(right: 40),
          child: ImageBubbleBody(
            image: image,
            isTheSender: isTheSender,
            themeColors: themeColors,
            time: time,
          ),
        ),
      ),
    );
  }
}
