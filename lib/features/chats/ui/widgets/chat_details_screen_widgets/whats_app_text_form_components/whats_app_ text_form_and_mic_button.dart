import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:intl/intl.dart';
import 'package:whats_app_clone/core/networking/model/user_model/user_model.dart';

import '../../../../../../core/utils/dependency_injection.dart';
import '../../../../../../core/themes/text_style/text_styles.dart';
import '../../../../../../core/themes/theme_color.dart';
import '../../../../logic/chat_details_cubit/chat_detail_parent_cubit.dart';
import '../../../../logic/chat_details_cubit/send_messages/send_messages_cubit.dart';
import '../clip_button_pop_up_components/clip_button_pop_up.dart';
import 'reply_on_chat_text_form.dart';
import 'test_text_color_ani.dart';

part 'chat_text_form_suffix_icon.dart';

part 'mic_animation.dart';

part 'recording_container.dart';

part 'text_form_container.dart';

class WhatsAppTextFormAndMicButton extends StatefulWidget {
  const WhatsAppTextFormAndMicButton({
    super.key,
    required this.themeColors,
    required this.hisUserModel,
  });

  final ThemeColors themeColors;
  final UserModel hisUserModel;

  @override
  State<WhatsAppTextFormAndMicButton> createState() => _WhatsAppTextFormAndMicButtonState();
}

class _WhatsAppTextFormAndMicButtonState extends State<WhatsAppTextFormAndMicButton>
    with SingleTickerProviderStateMixin {
  final TextEditingController chatTextFormController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  double containerSize = 48.r;
  double iconsSize = 25;

  bool isTyping = false;
  bool isRecording = false;
  bool isEndRecording = false;
  bool emojiShowing = false;

  double animatedVoiceButtonSize = 50.r;
  double animatedLeft = 275.w;
  Color redMicIcon = const Color(0xFFef5552);

  late Timer timerPeriodic;
  late Timer timerPeriodicChangeColor;

  String recordTimeText = '0:00';
  int maxDuration = 0;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
        setState(() {
          isEndRecording = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    chatTextFormController.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 5.w),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: BlocBuilder<ChatDetailParentCubit, ChatDetailParentState>(
              buildWhen: (previous, current) {
                if (current is ChatDetailParentFailure) {
                  return false;
                } else if (current is ChatDetailParentLongPressedAppbar) {
                  return false;
                } else if (current is ChatDetailParentInitial) {
                  return false;
                } else {
                  return true;
                }
              },
              builder: (context, state) {
                final bool replyingState = (state is ChatDetailParentReplying);
                return Stack(
                  alignment: Alignment.centerLeft,
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedSize(
                      alignment: AlignmentDirectional.bottomStart,
                      duration: const Duration(milliseconds: 150),
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 5.h,
                          bottom: 5.h,
                          right: 56.w,
                        ),
                        decoration: BoxDecoration(
                            color: widget.themeColors.hisMessage,
                            borderRadius: replyingState
                                ? BorderRadius.only(
                                    bottomRight: Radius.circular(30.r),
                                    bottomLeft: Radius.circular(30.r),
                                    topRight: Radius.circular(15.r),
                                    topLeft: Radius.circular(15.r),
                                  )
                                : BorderRadius.circular(30.r)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            replyingState
                                ? ReplyOnChatTextForm(
                                    themeColors: widget.themeColors,
                                    replyOriginalMessage: state.originalMessage,
                                    replyName: state.hisName,
                                    replyColor: state.replyColor,
                                  )
                                : const SizedBox.shrink(),
                            isRecording
                                ? _RecordingContainer(
                                    redMicIcon: redMicIcon,
                                    recordTimeText: recordTimeText,
                                    themeColors: widget.themeColors,
                                  )
                                : _TextFormContainer(
                                    themeColors: widget.themeColors,
                                    child: buildTextFormField(
                                      context,
                                      animationController: _animationController,
                                      isEndRecording: isEndRecording,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 120),
                      left: animatedLeft,
                      child: SizedBox(
                        width: 120.r,
                        height: 120.r,
                        child: Column(
                          mainAxisAlignment: replyingState ? MainAxisAlignment.end : MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => onTap(state),
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
                                    ? const Icon(Icons.send, color: Colors.white)
                                    : const Icon(Icons.mic, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        emojiShowing
            ? SizedBox(
                height: 250.h,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    setState(() {
                      isTyping = true;
                    });
                  },
                  onBackspacePressed: () {
                    if (chatTextFormController.text.isEmpty) {
                      setState(() {
                        isTyping = false;
                      });
                    }
                  },
                  textEditingController: chatTextFormController,
                  config: Config(
                    columns: 7,
                    emojiSizeMax: 32 * (foundation.defaultTargetPlatform == TargetPlatform.android ? 1.0 : 1.0),
                    bgColor: widget.themeColors.emojiBackgroundColor,
                    iconColor: widget.themeColors.emojiIconNotActiveColor.withOpacity(.6),
                    indicatorColor: widget.themeColors.greenButton,
                    iconColorSelected: widget.themeColors.emojiIconActiveColor,
                    backspaceColor: widget.themeColors.emojiIconNotActiveColor,
                    recentTabBehavior: RecentTabBehavior.POPULAR,
                    buttonMode: ButtonMode.MATERIAL,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget buildTextFormField(
    BuildContext context, {
    required AnimationController animationController,
    required bool isEndRecording,
  }) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          isEndRecording
              ? Positioned(
                  top: 4,
                  right: 265.w,
                  child: _MicAnimation(
                    animationController: animationController,
                    iconColor: Colors.red,
                  ),
                )
              : const SizedBox.shrink(),
          TextFormField(
            focusNode: _focusNode,
            onTap: () {
              if (emojiShowing == true) {
                setState(() {
                  emojiShowing = !emojiShowing;
                });
              }
            },
            decoration: InputDecoration(
              prefixIcon: isEndRecording
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          emojiShowing = !emojiShowing;
                        });
                        if (emojiShowing == true) {
                          FocusScope.of(context).unfocus();
                        }
                        if (emojiShowing == false) {
                          _focusNode.requestFocus();
                        }
                      },
                      icon: Icon(
                        emojiShowing ? Icons.keyboard_rounded : CupertinoIcons.smiley_fill,
                        color: widget.themeColors.bodyTextColor,
                      ),
                    ),
              suffixIcon: _ChatTextFormSuffixIcon(
                themeColors: widget.themeColors,
                hisUserModel: widget.hisUserModel,
              ),
              hintText: 'Message',
              hintStyle: Styles.textStyle18.copyWith(
                color: widget.themeColors.bodyTextColor,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            controller: chatTextFormController,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  void onChanged(value) {
    if (chatTextFormController.text.isNotEmpty) {
      setState(() {
        isTyping = true;
      });
    } else {
      setState(() {
        isTyping = false;
      });
    }
  }

  // void textFormFieldOnChange(value) {
  //   if (value.isNotEmpty) {
  //     isTyping = true;
  //   } else {
  //     isTyping = false;
  //   }
  // }

  void onHorizontalDragUpdate(details) {
    if (animatedVoiceButtonSize >= 130) {
      startRecording(animatedVoiceButtonSizeInc: 0);
      if (animatedLeft <= 105) {
        isEndRecording = true;
        endRecording();
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
    hapticFeedBackHeavy();
    isEndRecording = true;
    endRecording();
  }

  void onTap(ChatDetailParentState state) {
    if (isTyping || chatTextFormController.text.isNotEmpty) {
      DateTime now = DateTime.now();
      Timestamp timestamp = Timestamp.fromDate(now);

      if (state is ChatDetailParentReplying) {
        BlocProvider.of<SendMessagesCubit>(context).sendReplyMessage(
          hisUserModel: widget.hisUserModel,
          originalMessage: state.originalMessage.message,
          message: chatTextFormController.text,
          replyOriginalName: state.hisName,
          time: timestamp,
          type: 'reply',
        );
        BlocProvider.of<ChatDetailParentCubit>(context).closeReplyMessage();
      } else {
        BlocProvider.of<SendMessagesCubit>(context).sendMessage(
          hisUserModel: widget.hisUserModel,
          message: chatTextFormController.text,
          time: timestamp,
          type: 'message',
        );
      }

      chatTextFormController.clear();
      isTyping = false;
    }
  }

  void hapticFeedBackHeavy() async {
    await Haptics.vibrate(HapticsType.medium);
  }

  void hapticFeedBackMedium() async {
    await Haptics.vibrate(HapticsType.heavy);
  }

  void onTapDown(details) {
    if (isTyping == false) {
      timerPeriodicForIconAndTimeText();
      setState(() {
        startRecording(animatedVoiceButtonSizeInc: 80);
      });
      BlocProvider.of<SendMessagesCubit>(context).startRecording();
    }
  }

  void onTapUp(details) async {
    if (isTyping == false) {
      endRecording();
      var time = Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);

      await BlocProvider.of<SendMessagesCubit>(context).stopRecording(
        hisUserModel: widget.hisUserModel,
        maxDuration: maxDuration,
        time: time,
      );
    }
  }

  void timerPeriodicForIconAndTimeText() {
    timerPeriodicMethod();

    timerPeriodicChangeColorMethod();
  }

  void timerPeriodicMethod() {
    timerPeriodic = Timer.periodic(const Duration(milliseconds: 1002), (timer) {
      final formattedTime = DateFormat('m:ss');
      var recordTime = formattedTime.format(DateTime.fromMillisecondsSinceEpoch(timer.tick * 1000));
      recordTimeText = recordTime;
      maxDuration = timer.tick * 1000;
    });
  }

  void timerPeriodicChangeColorMethod() {
    timerPeriodicChangeColor = Timer.periodic(const Duration(milliseconds: 334), (timer) {
      setState(() {
        redMicIcon =
            redMicIcon == widget.themeColors.clipButtonPopUp ? Colors.red : widget.themeColors.clipButtonPopUp;
      });
    });
  }

  void cancelPeriodicTime() {
    timerPeriodic.cancel();
    timerPeriodicChangeColor.cancel();
    recordTimeText = '0:00';
  }

  void startRecording({required double animatedVoiceButtonSizeInc}) {
    hapticFeedBackMedium();
    isRecording = true;
    animatedVoiceButtonSize += animatedVoiceButtonSizeInc;
  }

  void endRecording() {
    hapticFeedBackHeavy();
    setState(() {
      _animationController.forward();
      isRecording = false;
      animatedLeft = 274.w;
      animatedVoiceButtonSize = 50.r;
      cancelPeriodicTime();
    });
  }
}
