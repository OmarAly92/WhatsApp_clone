import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/app_router/app_router.dart';
import 'package:whats_app_clone/core/functions/global_functions.dart';
import 'package:whats_app_clone/core/parameters_data/user_sign_up.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/auth/ui/widgets/auth_button.dart';

import '../../../core/utils/assets_data.dart';
import '../logic/authentication_cubit.dart';
import 'widgets/custom_text_form.dart';

part 'widgets/sign_up_components/bloc_listener.dart';

part 'widgets/sign_up_components/buttons.dart';

part 'widgets/sign_up_components/profile_image.dart';

part 'widgets/sign_up_components/sign_up_body.dart';

part 'widgets/sign_up_components/sign_up_text_forms.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key, required this.themeColors}) : super(key: key);
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Center(child: _SignUpBody(themeColors: themeColors)),
          ),
        ],
      ),
    );
  }
}
