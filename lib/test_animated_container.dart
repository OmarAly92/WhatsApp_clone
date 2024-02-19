import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

import 'core/dependency_injection/get_it.dart';
import 'features/chats/logic/chat_details_cubit/get_messages/get_messages_cubit.dart';
import 'features/chats/ui/chat_details_screen.dart';

class MyTest extends StatefulWidget {
  const MyTest({super.key, required this.themeColors});

  final ThemeColors themeColors;

  @override
  State<MyTest> createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  bool isTyping = false;
  bool isRecording = false;
  double animatedVoiceButtonSize = 50.r;
  double animatedLeft = 275.w;
  static const Color grey = Color(0xFF8c959b);
  String recordTimeText = 'After Some time 00:00';

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final formattedTime = DateFormat('mm:ss');
      var recordTime = formattedTime.format(DateTime.fromMillisecondsSinceEpoch(timer.tick * 1000));
      setState(() {
        recordTimeText = 'After Some time $recordTime';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8c959b),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                speed: const Duration(milliseconds: 40),
                '< Slide to cancel',
                textStyle: const TextStyle(
                  fontSize: 50.0,
                  fontFamily: 'Horizon',
                ),
                colors: [
                  const Color(0xff1c2b35),
                  Colors.grey,
                ],
              ),
            ],
            isRepeatingAnimation: true,
            repeatForever: true,
          ),
          Text(recordTimeText),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {

              },
              child: const Text('Check Here to see what will happen 01142036880')),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {

              },
              child: const Text('Check Here to see what will happen 01014531739')),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerLeft,
              children: [
                isRecording
                    ? Container(
                        width: 300.w,
                        height: 43.h,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.mic,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '0:00',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '< Slide to cancel',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        width: 300.w,
                        height: 43.h,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          onChanged: textFormFieldOnChange,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            prefixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.smiley,
                                color: grey,
                                size: 30,
                              ),
                            ),
                            suffixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    CupertinoIcons.paperclip,
                                    color: grey,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt_rounded,
                                    color: grey,
                                  ),
                                ),
                              ],
                            ),
                            hintText: 'Message',
                            hintStyle: TextStyle(color: grey, fontSize: 18.spMin),
                          ),
                          textAlignVertical: TextAlignVertical.bottom,
                        ),
                      ),
                SizedBox(width: 5.w),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 120),
                  left: animatedLeft,
                  child: SizedBox(
                    width: 110.r,
                    height: 110.r,
                    // color: Colors.blue.withOpacity(.2),
                    child: Center(
                      child: GestureDetector(
                        onTap: onTap,
                        onTapDown: onTapDown,
                        onTapUp: onTapUp,
                        onHorizontalDragUpdate: onHorizontalDragUpdate,
                        onHorizontalDragEnd: onHorizontalDragEnd,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          height: animatedVoiceButtonSize,
                          width: animatedVoiceButtonSize,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00a884),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: isTyping
                              ? const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.mic,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void textFormFieldOnChange(value) {
    if (value.isNotEmpty) {
      setState(() {
        isTyping = true;
      });
    } else {
      setState(() {
        isTyping = false;
      });
    }
  }

  void onHorizontalDragUpdate(details) {
    if (animatedVoiceButtonSize >= 150) {
      isRecording = true;
      if (animatedLeft <= 105) {
        setState(() {
          ///todo make voice cancel here
          isRecording = false;
          animatedLeft = 274.w;
          animatedVoiceButtonSize = 50.r;
        });
      }
      if (isTyping == false) {
        if (animatedLeft <= 275.w) {
          setState(() {
            animatedLeft += details.primaryDelta!;
          });
        } else if (animatedLeft >= 275.w) {
          animatedLeft = 274.w;
        }
      }
    }
  }

  void onHorizontalDragEnd(details) {
    setState(() {
      isRecording = false;
      animatedLeft = 274.w;
      animatedVoiceButtonSize = 50.r;
    });
  }

  void onTap() {
    if (isTyping) {
      print('send message omar');
    }
  }

  void onTapDown(details) {
    if (isTyping == false) {
      setState(() {
        isRecording = true;
        animatedVoiceButtonSize += 100;
      });
    }
  }

  void onTapUp(details) {
    if (isTyping == false) {
      setState(() {
        isRecording = false;
        animatedVoiceButtonSize = 50.r;
      });
    }
  }
}
