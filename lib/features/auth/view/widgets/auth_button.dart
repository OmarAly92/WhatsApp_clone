import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/text_style/text_styles.dart';
import '../../../../core/themes/theme_color.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.context,
    required this.themeColors,
    required this.buttonName,
    required this.onPressed,
  });

  final BuildContext context;
  final ThemeColors themeColors;
  final String buttonName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(90.w, 40.h),
          backgroundColor: themeColors.greenButton,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        child: Text(
          buttonName,
          style: Styles.textStyle14.copyWith(
            color: themeColors.backgroundColor,
          ),
        ),
      ),
    );
  }
}
