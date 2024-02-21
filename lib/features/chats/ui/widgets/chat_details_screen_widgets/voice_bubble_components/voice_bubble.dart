import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/networking/model/chat_model/message_model.dart';
import '../../../../../../core/networking/model/user_model/user_model.dart';
import '../../../../../../core/themes/text_style/text_styles.dart';
import '../../../../../../core/themes/theme_color.dart';
import '../../../../../../core/utils/global_functions.dart';
import '../../../../../../core/widgets/custom_circle_image.dart';
import '../../../../logic/chat_details_cubit/chat_detail_parent_cubit.dart';
import '../../../../logic/chat_details_cubit/voice_bubble_cubit/voice_bubble_cubit.dart';
import '../custom_bubble_parent.dart';

part 'audio_wave_voice_duration_and_voice_time.dart';

part 'circle_image.dart';

part 'error_voice_handling.dart';

part 'voice_button_states.dart';

class VoiceBubble extends StatefulWidget {
  const VoiceBubble({
    Key? key,
    required this.themeColors,
    required this.isTheSender,
    required this.isFirstMessage,
    required this.hisUserModel,
    required this.messageModel,
    required this.backgroundBlendMode, required this.myUserData,
  }) : super(key: key);
  final ThemeColors themeColors;
  final bool isTheSender;
  final bool isFirstMessage;
  final UserModel hisUserModel;
  final MessageModel messageModel;
  final BlendMode backgroundBlendMode;
  final UserModel myUserData;
  @override
  State<VoiceBubble> createState() => _VoiceBubbleState();
}

class _VoiceBubbleState extends State<VoiceBubble> {


///todo fixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


  @override
  void initState() {
    super.initState();

    BlocProvider.of<VoiceBubbleCubit>(context).checkIfFileExistsAndPlayOrDownload(
      voiceUrl: widget.messageModel.message,
      hisPhoneNumber: widget.hisUserModel.phoneNumber,
    );

  }

  @override
  Widget build(BuildContext context) {
    return _ErrorVoiceHandling(
      child: CustomBubbleParent(
        themeColors: widget.themeColors,
        isTheSender: widget.isTheSender,
        isFirstMessage: widget.isFirstMessage,
        widgetBubbleBody: Container(
          decoration: BoxDecoration(
            color: widget.isTheSender ? widget.themeColors.myMessage : widget.themeColors.hisMessage,
            backgroundBlendMode: widget.backgroundBlendMode,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              right: 9.w,
              left: widget.isTheSender ? 0 : 9.w,
              bottom: 3.h,
            ),
            child: Row(
              children: [
                widget.isTheSender
                    ? _CircleImage(
                        hisProfilePicture: widget.hisUserModel.profilePicture,
                        isTheSender: widget.isTheSender, myProfilePicture:widget.myUserData.profilePicture,
                      )
                    : const SizedBox.shrink(),
                _VoiceButtonStates(
                  themeColors: widget.themeColors,
                  messageModel: widget.messageModel,
                  hisPhoneNumber: widget.hisUserModel.phoneNumber,
                  isTheSender: widget.isTheSender,
                ),
                _AudioWaveVoiceDurationAndVoiceTime(
                  themeColors: widget.themeColors,
                  messageModel: widget.messageModel,
                  isTheSender: widget.isTheSender,
                ),
                widget.isTheSender
                    ? const SizedBox.shrink()
                    : _CircleImage(
                        hisProfilePicture: widget.hisUserModel.profilePicture,
                        isTheSender: widget.isTheSender, myProfilePicture: widget.myUserData.profilePicture,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
