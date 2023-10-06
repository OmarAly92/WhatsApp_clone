import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/chats/view/widgets/custom_bubble_parent.dart';
import 'package:whats_app_clone/features/chats/view/widgets/image_bubble_body.dart';

class ImageBubble extends StatelessWidget {
  const ImageBubble({
    super.key,
    required this.image,
    required this.isTheSender,
    required this.themeColors,
    required this.time,
    required this.isFirstMessage,
  });

  final String image;
  final String time;
  final bool isTheSender;
  final bool isFirstMessage;
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return CustomBubbleParent(
      isFirstMessage: isFirstMessage,
      themeColors: themeColors,
      isTheSender: isTheSender,
      widgetBubbleBody: ImageBubbleBody(
        isTheSender: isTheSender,
        themeColors: themeColors,
        image: image,
        time: time,
      ),
    );
  }
}
