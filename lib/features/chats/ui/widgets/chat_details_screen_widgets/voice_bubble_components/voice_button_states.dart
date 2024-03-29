part of 'voice_bubble.dart';

class _VoiceButtonStates extends StatefulWidget {
  const _VoiceButtonStates({
    required this.themeColors,
    required this.messageModel,
    required this.hisPhoneNumber,
    required this.isTheSender,
  });

  final ThemeColors themeColors;
  final MessageModel messageModel;
  final String hisPhoneNumber;
  final bool isTheSender;

  @override
  State<_VoiceButtonStates> createState() => _VoiceButtonStatesState();
}

class _VoiceButtonStatesState extends State<_VoiceButtonStates> {
  late bool isPlaying;

  @override
  void initState() {
    super.initState();
    isPlaying = false;
  }

  @override
  Widget build(BuildContext context) {
    double playPauseButtonSize = 42.r;
    double downloadButtonSize = 32.r;
    Color buttonColor = widget.isTheSender ? widget.themeColors.myMessageTime : widget.themeColors.hisMessageTime;
    EdgeInsets padding = EdgeInsets.only(left: 7.w, bottom: 7.h, top: 7.h, right: 0);
    return BlocBuilder<VoiceBubbleCubit, VoiceBubbleState>(
      builder: (context, state) {
        if (state is VoiceBubbleLoading) {
          return Padding(
            padding: EdgeInsets.all(18.r),
            child: Center(
              child: SizedBox(
                width: 22.r,
                height: 22.r,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                ),
              ),
            ),
          );
        } else if (state is VoiceBubbleInitial) {
          return Padding(
            padding: padding,
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please wait voice is loading'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                size: playPauseButtonSize,
                color: buttonColor,
              ),
            ),
          );
        } else if (state is VoiceBubbleVoiceExistence) {
          return Padding(
            padding: padding,
            child: InkWell(
              onTap: () {
                if (state.isExisted) {
                  BlocProvider.of<VoiceBubbleCubit>(context).playAndPause(
                    hisPhoneNumber: widget.hisPhoneNumber,
                    voiceUrl: widget.messageModel.message,
                    maxDurationMilliSec: widget.messageModel.maxDuration,
                  );
                } else {
                  BlocProvider.of<VoiceBubbleCubit>(context).downloadVoiceFile(
                    voiceUrl: widget.messageModel.message,
                    hisPhoneNumber: widget.hisPhoneNumber,
                  );
                }
              },
              child: Icon(
                state.isExisted
                    ? isPlaying
                        ? Icons.pause
                        : Icons.play_arrow_rounded
                    : Icons.download_for_offline_outlined,
                size: playPauseButtonSize,
                color: buttonColor,
              ),
            ),
          );
        } else if (state is VoiceBubblePlayerState) {
          return Padding(
            padding: padding,
            child: InkWell(
              onTap: () {
                BlocProvider.of<VoiceBubbleCubit>(context).playAndPause(
                  hisPhoneNumber: widget.hisPhoneNumber,
                  voiceUrl: widget.messageModel.message,
                  maxDurationMilliSec: widget.messageModel.maxDuration,
                );
              },
              child: Icon(
                state.isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                size: playPauseButtonSize,
                color: buttonColor,
              ),
            ),
          );
        } else if (state is VoiceBubbleError) {
          return Padding(
            padding: padding,
            child: InkWell(
              onTap: () {
                BlocProvider.of<VoiceBubbleCubit>(context).downloadVoiceFile(
                  voiceUrl: widget.messageModel.message,
                  hisPhoneNumber: widget.hisPhoneNumber,
                );
              },
              child: Icon(
                Icons.download_for_offline_outlined,
                color: buttonColor,
                size: downloadButtonSize,
              ),
            ),
          );
        } else {
          return Padding(
            padding: padding,
            child: InkWell(
              onTap: () {
                BlocProvider.of<VoiceBubbleCubit>(context).downloadVoiceFile(
                  voiceUrl: widget.messageModel.message,
                  hisPhoneNumber: widget.hisPhoneNumber,
                );
              },
              child: Icon(
                Icons.download_for_offline_outlined,
                color: buttonColor,
                size: downloadButtonSize,
              ),
            ),
          );
        }
      },
    );
  }

  String formattedTime() {
    DateTime dateTime = widget.messageModel.time.toDate();
    String formattedTime = DateFormat('h:mm a').format(dateTime);
    return formattedTime;
  }
}
