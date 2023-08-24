import 'package:flutter/material.dart';

import '../utils/assets_data.dart';

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
  late final Color regularTextColor;
  late final Color bodyIconColor;
  late final Color dividerColor;
  late final Color greenColor;
  late final Color myMessage;
  late final Color myMessageTime;
  late final Color hisMessageTime;
  late final Color hisMessage;
  late final Color privateChatAppBarColor;
  late final Color theAuthorTextColor;
  late final Color greenButton;
  late final Color secondaryButton;


  late final Color updatesEditFloatingActionButtonColor;


  late final Color updatesEditIconColor;


  late final String chatBackGroundImage;
  final String kDarkChatBackGround1 = kDarkChatBackGround;
  final String kLightChatBackGround1 = kLightChatBackGround;

  // Private static instance of the ThemeColors class
  static final ThemeColors _singletonDark = ThemeColors._internal(true);
  static final ThemeColors _singletonLight = ThemeColors._internal(false);

  // Factory constructor to return the appropriate instance based on isDarkMode
  factory ThemeColors({required bool isDarkMode}) {
    return isDarkMode ? _singletonDark : _singletonLight;
  }

  // Private constructor for the singleton instances
  ThemeColors._internal(this.isDarkMode) {
    backgroundColor =
        isDarkMode ? const Color(0xff121b22) : const Color(0xffffffff);
    appbarColor =
        isDarkMode ? const Color(0xff1f2c34) : const Color(0xff008069);
    appbarTextColor =
        isDarkMode ? const Color(0xff8b9a9f) : const Color(0xfface1d9);
    bodyTextColor =
        isDarkMode ? const Color(0xff8596A0) : const Color(0xff85969e);
    bodyIconColor =
        isDarkMode ? const Color(0xff889093) : const Color(0xff84979e);
    dividerColor =
        isDarkMode ? const Color(0xff607d8b) : const Color(0xff9e9e9e);
    greenColor = isDarkMode ? const Color(0xff00a884) : const Color(0xff008069);
    myMessage = isDarkMode ? const Color(0xff005C4B) : const Color(0xffe7ffdb);
    myMessageTime = isDarkMode ? const  Color(0xff91cac1) : const Color(0xff7a8f7e);
    hisMessageTime = isDarkMode ? const   Color(0xff89969e) : const Color(0xff7a8f7e);
    hisMessage = isDarkMode ? const Color(0xff1f2c34) : const Color(0xffffffff);
    privateChatAppBarColor = isDarkMode ? const Color(0xfff0f6f5) : const Color(0xfff0f6f5);

    updatesEditFloatingActionButtonColor = isDarkMode ? const Color(0xff3C4A55) : const Color(0xffE0FEF2);
    updatesEditIconColor = isDarkMode ? const Color(0xffD2D6DA) : const Color(0xff017F68);
    theAuthorTextColor = isDarkMode ? const Color(0xffBEBFC0) : const Color(0xff000000);
    greenButton = isDarkMode ? const Color(0xff00A884) : const Color(0xff0f9c7c);
    secondaryButton = isDarkMode ? const Color(0xff182329) : const Color(0xfff7f8fa);
    regularTextColor = isDarkMode ? const Color(0xffffffff) : const Color(0xff000000);


    chatBackGroundImage = isDarkMode ? kDarkChatBackGround1 : kLightChatBackGround1;
  }
}
