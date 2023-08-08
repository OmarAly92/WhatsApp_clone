import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

class UpdateRowStatusAndIcon extends StatelessWidget {
  const UpdateRowStatusAndIcon({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Status', style: Styles.textStyle20),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert, color: themeColors.bodyTextColor),
        ),
      ],
    );
  }
}
