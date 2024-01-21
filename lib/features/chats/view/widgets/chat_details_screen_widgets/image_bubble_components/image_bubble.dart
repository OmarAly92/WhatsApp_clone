import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/themes/text_style/text_styles.dart';
import '../../../../../../core/themes/theme_color.dart';
import '../custom_bubble_parent.dart';

part 'image_bubble_body.dart';

class ImageBubble extends StatelessWidget {
  const ImageBubble({
    super.key,
    required this.image,
    required this.isTheSender,
    required this.themeColors,
    required this.time,
    required this.isFirstMessage,
    required this.backgroundBlendMode,
  });

  final String image;
  final String time;
  final bool isTheSender;
  final bool isFirstMessage;
  final ThemeColors themeColors;
  final BlendMode backgroundBlendMode;

  @override
  Widget build(BuildContext context) {
    return CustomBubbleParent(
      isFirstMessage: isFirstMessage,
      themeColors: themeColors,
      isTheSender: isTheSender,
      widgetBubbleBody: _ImageBubbleBodyComponent(
        isTheSender: isTheSender,
        themeColors: themeColors,
        image: image,
        time: time,
        backgroundBlendMode: backgroundBlendMode,
      ),
    );
  }
}
