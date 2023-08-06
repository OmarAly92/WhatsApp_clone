import 'package:flutter/material.dart';

// class ThemeColors {
//   final bool isDarkMode;
//
//   late final Color backgroundColor;
//   late final Color appbarColor;
//   late final Color appbarTextColor;
//   late final Color bodyTextColor;
//   late final Color bodyIconColor;
//   late final Color dividerColor;
//   late final Color greenColor;
//   late final Color myMessage;
//   late final Color hisMessage;
//   late final Color privateChatAppBarColor;
//
//   ThemeColors({required this.isDarkMode}) {
//     backgroundColor = isDarkMode ? const Color(0xff121b22) : const Color(0xffffffff);
//     appbarColor = isDarkMode ? const Color(0xff1f2c34) : const Color(0xff008069);
//     appbarTextColor = isDarkMode ? const Color(0xff8b9a9f) : const Color(0xfface1d9);
//     bodyTextColor = isDarkMode ? const Color(0xff8b9a9f) : const Color(0xff85969e);
//     bodyIconColor = isDarkMode ? const Color(0xff889093) : const Color(0xff84979e);
//     dividerColor = isDarkMode ? const Color(0xff1c252c) : const Color(0xfff7f8fa);
//     greenColor = isDarkMode ? const Color(0xff00a884) : const Color(0xff008069);
//     myMessage = isDarkMode ? const Color(0xff005e4a) : const Color(0xffe7ffdb);
//     hisMessage = isDarkMode ? const Color(0xff1f2c34) : const Color(0xffffffff);
//     privateChatAppBarColor = isDarkMode ? const Color(0xffffffff) : const Color(0xffffffff);
//   }
// }


class ThemeColors {
  final bool isDarkMode;




  late final Color backgroundColor;
  late final Color appbarColor;
  late final Color appbarTextColor;
  late final Color bodyTextColor;
  late final Color bodyIconColor;
  late final Color dividerColor;
  late final Color greenColor;
  late final Color myMessage;
  late final Color hisMessage;
  late final Color privateChatAppBarColor;


  // Private static instance of the ThemeColors class
  static final ThemeColors _singletonDark = ThemeColors._internal(true);
  static final ThemeColors _singletonLight = ThemeColors._internal(false);

  // Factory constructor to return the appropriate instance based on isDarkMode
  factory ThemeColors({required bool isDarkMode}) {
    return isDarkMode ? _singletonDark : _singletonLight;
  }




  // Private constructor for the singleton instances
  ThemeColors._internal(this.isDarkMode) {
    backgroundColor = isDarkMode ? const Color(0xff121b22) : const Color(0xffffffff);
    appbarColor = isDarkMode ? const Color(0xff1f2c34) : const Color(0xff008069);
    appbarTextColor = isDarkMode ? const Color(0xff8b9a9f) : const Color(0xfface1d9);
    bodyTextColor = isDarkMode ? const Color(0xff8b9a9f) : const Color(0xff85969e);
    bodyIconColor = isDarkMode ? const Color(0xff889093) : const Color(0xff84979e);
    dividerColor = isDarkMode ? const Color(0xff1c252c) : const Color(0xfff7f8fa);
    greenColor = isDarkMode ? const Color(0xff00a884) : const Color(0xff008069);
    myMessage = isDarkMode ? const Color(0xff005e4a) : const Color(0xffe7ffdb);
    hisMessage = isDarkMode ? const Color(0xff1f2c34) : const Color(0xffffffff);
    privateChatAppBarColor = isDarkMode ? const Color(0xfff0f6f5) : const Color(0xfff0f6f5);
  }
}


