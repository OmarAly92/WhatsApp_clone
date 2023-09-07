import 'package:flutter/material.dart';

import '../../../core/themes/theme_color.dart';
import 'widgets/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, required this.themeColors}) : super(key: key);
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ProfileBody(themeColors: themeColors),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_outlined,
          color: Color(0xffeef9fc),
        ),
      ),
      title: const Text(
        'Profile',
        style: TextStyle(
          color: Color(0xffeef9fc),
        ),
      ),
    );
  }
}
