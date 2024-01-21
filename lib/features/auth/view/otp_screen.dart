import 'package:flutter/material.dart';

import '../../../core/themes/theme_color.dart';
import 'widgets/otp_body.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({
    super.key,
    required this.themeColors,
    required this.phoneNumber,
  });

  final ThemeColors themeColors;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: OtpBody(
        themeColors: themeColors,
        phoneNumber: phoneNumber,
      ),
    );
  }
}
