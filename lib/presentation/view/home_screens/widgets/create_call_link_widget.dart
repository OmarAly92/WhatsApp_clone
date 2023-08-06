import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

class CreateCallLinkWidget extends StatelessWidget {
  const CreateCallLinkWidget({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 49.r,
          width: 49.r,
          decoration: BoxDecoration(
            color: const Color(0xff01a984),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: const Center(
            child: Icon(
              CupertinoIcons.link,
              color: Color(0xffFFFFFF),
            ),
          ),
        ),
        SizedBox(width: 12.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create call link',
              style: Styles.textStyle16.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Share a link for your WhatsApp call',
              style: Styles.textStyle14.copyWith(
                color: themeColors.bodyTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
