import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/theme_color.dart';


class UpdatesFloatingActionButton extends StatelessWidget {
  const UpdatesFloatingActionButton({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 40.r,
          width: 40.r,
          child: FloatingActionButton(
            backgroundColor:
                themeColors.updatesEditFloatingActionButtonColor,
            onPressed: () {},
            child: Icon(
              Icons.edit,
              color: themeColors.updatesEditIconColor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.camera_alt_rounded,
            color: themeColors.backgroundColor,
          ),
        ),
      ],
    );
  }
}
