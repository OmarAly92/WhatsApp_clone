import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/presentation/view/home_screens/widgets/call_body_section.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({Key? key, required this.themeColors}) : super(key: key);

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CallBodySection(themeColors: themeColors),
        FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.add_call,
            color: themeColors.backgroundColor,
          ),
        ),
      ],
    );
  }
}
