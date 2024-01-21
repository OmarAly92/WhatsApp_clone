import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/themes/theme_color.dart';
import 'widgets/settings_body.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key, required this.themeColors}) : super(key: key);
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SettingsBody(themeColors: themeColors),
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
        'Settings',
        style: TextStyle(
          color: Color(0xffeef9fc),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.search,
            color: Color(0xffeef9fc),
          ),
        ),
      ],
    );
  }
}
