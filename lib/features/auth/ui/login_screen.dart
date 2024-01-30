import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_router/app_router.dart';
import '../../../core/functions/global_functions.dart';
import '../../../core/themes/theme_color.dart';
import '../logic/authentication_cubit.dart';
import 'widgets/auth_button.dart';
import 'widgets/custom_text_form.dart';

part 'widgets/login_components/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, required this.themeColors}) : super(key: key);
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            leading: SizedBox.shrink(),
            centerTitle: true,
            title: Text('Login'),
          ),
          SliverToBoxAdapter(
            child: _LoginBody(themeColors: themeColors),
          ),
        ],
      ),
    );
  }
}
