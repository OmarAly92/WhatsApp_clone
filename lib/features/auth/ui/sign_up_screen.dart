import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../core/utils/app_router.dart';
import '../../../core/networking/model/parameters_data/user_sign_up.dart';
import '../../../core/themes/theme_color.dart';
import '../../../core/utils/global_functions.dart';
import '../../../core/utils/assets_data.dart';
import '../logic/authentication_cubit.dart';
import 'widgets/auth_button.dart';
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
