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
  late final Color appbarLongPressedColor;
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
  late final Color clipButtonPopUp;

  late final Color updatesEditFloatingActionButtonColor;

  late final Color updatesEditIconColor;

  late final Color contactScreenContainerColor;
  late final Color contactScreenIconColor;

  late final Color myMessageWaveFormFixedColor;
  late final Color hisMessageWaveFormFixedColor;

  late final Color myMessageWaveFormLiveColor;
  late final Color hisMessageWaveFormLiveColor;

  late final Color onLongPressedMessageColor;

  late final String chatBackGroundImage;
  final String kDarkChatBackGround1 = kDarkChatBackGround;
  final String kLightChatBackGround1 = kLightChatBackGround;

  static final ThemeColors _singletonDark = ThemeColors._internal(true);
  static final ThemeColors _singletonLight = ThemeColors._internal(false);

  factory ThemeColors({required bool isDarkMode}) {
    return isDarkMode ? _singletonDark : _singletonLight;
  }

  ThemeColors._internal(this.isDarkMode) {
    backgroundColor = isDarkMode ? const Color(0xff121b22) : const Color(0xffffffff);

    appbarColor = isDarkMode ? const Color(0xff1f2c34) : const Color(0xff008069);
    appbarLongPressedColor = isDarkMode ? const Color(0xff182329) : const Color(0xff125C4D);

    appbarTextColor = isDarkMode ? const Color(0xff8b9a9f) : const Color(0xfface1d9);
    bodyTextColor = isDarkMode ? const Color(0xff8596A0) : const Color(0xff85969e);
    bodyIconColor = isDarkMode ? const Color(0xff889093) : const Color(0xff84979e);
    dividerColor = isDarkMode ? const Color(0xff607d8b) : const Color(0xff9e9e9e);
    greenColor = isDarkMode ? const Color(0xff00a884) : const Color(0xff008069);
    myMessage = isDarkMode ? const Color(0xff005C4B) : const Color(0xffe7ffdb);
    myMessageTime = isDarkMode ? const Color(0xff7aa0a3) : const Color(0xff7a8f7e);
    hisMessageTime = isDarkMode ? const Color(0xff89969e) : const Color(0xff7a8f7e);
    hisMessage = isDarkMode ? const Color(0xff1f2c34) : const Color(0xffffffff);
    privateChatAppBarColor = isDarkMode ? const Color(0xfff0f6f5) : const Color(0xfff0f6f5);

    updatesEditFloatingActionButtonColor = isDarkMode ? const Color(0xff3C4A55) : const Color(0xffE0FEF2);
    updatesEditIconColor = isDarkMode ? const Color(0xffD2D6DA) : const Color(0xff017F68);
    theAuthorTextColor = isDarkMode ? const Color(0xffBEBFC0) : const Color(0xff000000);
    greenButton = isDarkMode ? const Color(0xff00A884) : const Color(0xff02b086);
    secondaryButton = isDarkMode ? const Color(0xff182329) : const Color(0xfff7f8fa);
    regularTextColor = isDarkMode ? const Color(0xffffffff) : const Color(0xff000000);
    clipButtonPopUp = isDarkMode ? const Color(0xff1f2c34) : const Color(0xffffffff);

    contactScreenContainerColor = isDarkMode ? const Color(0xff1f2c33) : const Color(0xffe9eef3);
    contactScreenIconColor = isDarkMode ? const Color(0xff86939c) : const Color(0xff84969e);

    myMessageWaveFormFixedColor = isDarkMode ? const Color(0xff317D6D) : const Color(0xffBBD0B4);
    hisMessageWaveFormFixedColor = isDarkMode ? const Color(0xff4D565D) : const Color(0xffCFD0D1);

    myMessageWaveFormLiveColor = isDarkMode ? const Color(0xffA9CCC5) : const Color(0xff627266);
    hisMessageWaveFormLiveColor = isDarkMode ? const Color(0xffB6BBBD) : const Color(0xff6C7274);

    onLongPressedMessageColor = isDarkMode ? const Color(0xff005d4b) : const Color(0xFF2196F3);

    chatBackGroundImage = isDarkMode ? kDarkChatBackGround1 : kLightChatBackGround1;
  }
}
