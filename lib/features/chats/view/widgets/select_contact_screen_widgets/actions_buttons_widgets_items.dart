import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/text_style/text_styles.dart';

class ActionsButtonsWidgetsItems extends StatelessWidget {
  const ActionsButtonsWidgetsItems({
    super.key,
    required this.iconsSize,
    required this.title,
    required this.leftIcon,
    required this.containerColor,
    required this.iconColor,
    required this.customPadding,
    required this.onTap,
  });

  final String title;
  final IconData leftIcon;
  final Color containerColor;
  final Color iconColor;
  final double iconsSize;
  final EdgeInsetsGeometry customPadding;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customPadding,
      child: ListTile(
        title: Text(
          title,
          style: Styles.textStyle18.copyWith(
            fontSize: 17.spMin,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Container(
          height: 53,
          width: 53,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(
            leftIcon,
            color: iconColor,
            size: iconsSize,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
