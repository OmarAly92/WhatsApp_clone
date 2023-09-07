import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

import 'widgets/welcome_body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.themeColors});

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeBody(themeColors: themeColors),
    );
  }
}
