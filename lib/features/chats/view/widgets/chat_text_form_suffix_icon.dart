import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';

import '../../../../core/themes/theme_color.dart';

class ChatTextFormSuffixIcon extends StatelessWidget {
  const ChatTextFormSuffixIcon({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

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
                builder: (context) => bottomSheet(),
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

  Widget bottomSheet() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 310.h,
        width: double.maxFinite,
        color: Colors.transparent,
        padding: EdgeInsets.only(bottom: 28.h),
        child: Card(
          color: themeColors.appbarColor,
          margin: EdgeInsets.all(16.r),
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    iconCreation(
                      icons: Icons.insert_drive_file,
                      title: 'Document',
                      gradient: [
                        const Color(0xff7866F0),
                        const Color(0xff644EE1),
                      ],
                    ),
                    iconCreation(
                      icons: Icons.camera_alt_rounded,
                      title: 'Camera',
                      gradient: [
                        const Color(0xffFF2F70),
                        const Color(0xffE00B60),
                      ],
                    ),
                    iconCreation(
                      icons: Icons.image,
                      title: 'Gallery',
                      gradient: [
                        const Color(0xffC560F7),
                        const Color(0xffA453D0),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    iconCreation(
                      icons: Icons.headphones,
                      title: 'Audio',
                      gradient: [
                        const Color(0xffF96633),
                        const Color(0xffE35D30),
                      ],
                    ),
                    iconCreation(
                      icons: Icons.location_on_sharp,
                      title: 'Location',
                      gradient: [
                        const Color(0xff1EA856),
                        const Color(0xff1D9950),
                      ],
                    ),
                    iconCreation(
                      icons: Icons.person,
                      title: 'Contact',
                      gradient: [
                        const Color(0xff009CE0),
                        const Color(0xff078AC3),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      iconCreation(
                        icons: Icons.poll_outlined,
                        title: 'Poll',
                        gradient: [
                          const Color(0xff01A698),
                          const Color(0xff05978C),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget iconCreation({
    required IconData icons,
    required List<Color> gradient,
    required String title,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25.5.r,
          child: Container(
            height: 51.r,
            width: 51.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.5.r),
              gradient: SweepGradient(
                colors: gradient,
              ),
            ),
            child: Icon(
              icons,
              size: 22.r,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          title,
          style: Styles.textStyle14.copyWith(
            color: themeColors.bodyTextColor,
            fontWeight: FontWeight.w500,
            fontSize: 13.spMin,
          ),
        ),
      ],
    );
  }
}
