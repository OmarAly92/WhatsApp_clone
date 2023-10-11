import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/core/widgets/custom_circle_image.dart';
import 'package:whats_app_clone/features/chats/view/widgets/custom_bubble_parent.dart';

class VoiceBubble extends StatefulWidget {
  const VoiceBubble({
    Key? key,
    required this.themeColors,
    required this.isTheSender,
    required this.voice,
    required this.isFirstMessage,
  }) : super(key: key);
  final ThemeColors themeColors;
  final bool isTheSender;
  final bool isFirstMessage;
  final String voice;

  @override
  State<VoiceBubble> createState() => _VoiceBubbleState();
}

class _VoiceBubbleState extends State<VoiceBubble> {
  final player = AudioPlayer();

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBubbleParent(
      themeColors: widget.themeColors,
      isTheSender: widget.isTheSender,
      isFirstMessage: widget.isFirstMessage,
      widgetBubbleBody: Container(
        decoration: BoxDecoration(
          color: widget.isTheSender ? widget.themeColors.myMessage : widget.themeColors.hisMessage,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            right: 9.w,
            left: widget.isTheSender ? 0 : 9.w,
            bottom: 3.h,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () async {
                  await player.play(UrlSource(widget.voice));
                },
                icon: Icon(
                  Icons.play_arrow_rounded,
                  size: 44.r,
                  color: widget.themeColors.bodyTextColor,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      '----------------------------------------------',
                      style: TextStyle(color: widget.themeColors.bodyTextColor),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '0:30',
                          style: Styles.textStyle14.copyWith(color: widget.themeColors.theAuthorTextColor),
                        ),
                        const Spacer(),
                        Text(
                          '4:49 AM',
                          style: Styles.textStyle14.copyWith(color: widget.themeColors.theAuthorTextColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: widget.isTheSender ? 13.w : 13.w,
                  right: widget.isTheSender ? 13.w : 0,
                ),
                child: SizedBox(
                  height: 52.r,
                  width: 52.r,
                  child: const CustomCircleImage(
                    profileImage: 'assets/images/default_profile_picture.jpg',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
