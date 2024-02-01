import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/theme_color.dart';
import '../../logic/settings_cubit.dart';
import 'settings_profile_loading.dart';
import 'settings_profile_success.dart';

class SettingsProfileWidgets extends StatelessWidget {
  const SettingsProfileWidgets({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state is SettingsSuccess) {
          return SettingsProfileSuccess(
            themeColors: themeColors,
            state: state,
          );
        } else if (state is SettingsFailure) {
          return SizedBox(
            height: 60.r,
            width: 60.r,
            child: Center(
              child: Text(state.failureMessage),
            ),
          );
        } else {
          return SettingsProfileLoading(themeColors: themeColors);
        }
      },
    );
  }
}
