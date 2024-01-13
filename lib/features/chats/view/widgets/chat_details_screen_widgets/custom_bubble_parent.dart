import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/theme_color.dart';

class CustomBubbleParent extends StatelessWidget {
  const CustomBubbleParent({
    Key? key,
    required this.themeColors,
    required this.isTheSender,
    required this.isFirstMessage,
    required this.widgetBubbleBody,
  }) : super(key: key);
  final ThemeColors themeColors;
  final Widget widgetBubbleBody;
  final bool isFirstMessage;
  final bool isTheSender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isFirstMessage
          ? EdgeInsets.only(top: 5.h)
          : const EdgeInsets.symmetric(vertical: 0),
      child: Align(
        alignment: isTheSender ? Alignment.centerRight : Alignment.centerLeft,
        child: isFirstMessage
            ? Padding(
                padding: isTheSender
                    ? EdgeInsets.only(left: 38.w, top: 1.2.h, bottom: 1.2.h)
                    : EdgeInsets.only(right: 38.w, top: 1.2.h, bottom: 1.2.h),
                child: ClipPath(
                  clipper: UpperNipMessageClipperTwo(
                    isTheSender ? MessageType.send : MessageType.receive,
                  ),
                  child: widgetBubbleBody,
                ),
              )
            : Padding(
                padding: isTheSender
                    ? EdgeInsets.only(
                        left: 38.w, right: 15.w, top: 1.2.h, bottom: 1.2.h)
                    : EdgeInsets.only(
                        right: 38.w, left: 15.w, top: 1.2.h, bottom: 1.2.h),
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9.r),
                    ),
                  ),
                  child: widgetBubbleBody,
                ),
              ),
      ),
    );
  }
}
