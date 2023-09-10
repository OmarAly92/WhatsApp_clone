import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/theme_color.dart';
import '../../../../core/widgets/the_author.dart';
import 'settings_item.dart';
import 'settings_profile_widget.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key, required this.themeColors});

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SettingsProfileWidgets(themeColors: themeColors),
              Divider(
                color: themeColors.dividerColor,
                thickness: .08,
                height: 0,
              ),
              SizedBox(height: 7.h),
              SettingsItem(themeColors: themeColors),
              TheAuthor(themeColors: themeColors)
            ],
          ),
        ),
      ],
    );
  }
}

