import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

class PlusIcon extends StatelessWidget {
  const PlusIcon({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 25.h,
      left: 30.w,
      child: Container(
        height: 20.r,
        width: 20.r,
        decoration: BoxDecoration(
          color: const Color(0xff3db298),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: themeColors.backgroundColor, width: 1.5),
        ),
        child: Center(
          child: Icon(
            CupertinoIcons.plus,
            color: const Color(0xffffffff),
            size: 16.r,
          ),
        ),
      ),
    );
  }
}
