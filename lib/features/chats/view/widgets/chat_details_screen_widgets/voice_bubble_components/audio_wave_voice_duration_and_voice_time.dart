part of 'voice_bubble.dart';

class _AudioWaveVoiceDurationAndVoiceTime extends StatefulWidget {
  const _AudioWaveVoiceDurationAndVoiceTime({
    required this.themeColors,
    required this.messageModel,
    required this.isTheSender,
  });

  final ThemeColors themeColors;
  final MessageModel messageModel;
  final bool isTheSender;

  @override
  State<_AudioWaveVoiceDurationAndVoiceTime> createState() => _AudioWaveVoiceDurationAndVoiceTimeState();
}

class _AudioWaveVoiceDurationAndVoiceTimeState extends State<_AudioWaveVoiceDurationAndVoiceTime> {
  late String duration;
  late List<double> waveData;

  @override
  void initState() {
    super.initState();
    duration = GlFunctions.timeFormatUsingMillisecond(widget.messageModel.maxDuration);

    waveData = widget.messageModel.waveData.cast<double>();

    for (int i = 0; i < 48; i++) {
      waveData.add(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: widget.isTheSender ? EdgeInsets.only(right: 12.w) : EdgeInsets.zero,
        child: Column(
          children: [
            SizedBox(height: 10.h),
            AudioFileWaveforms(
              clipBehavior: Clip.none,
              enableSeekGesture: false,
              size: Size(double.maxFinite, 25.w),
              playerController: BlocProvider.of<VoiceBubbleCubit>(context).audioPlayerController,
              waveformData: waveData,
              waveformType: WaveformType.fitWidth,
              playerWaveStyle: PlayerWaveStyle(
                waveCap: StrokeCap.round,
                spacing: 3.5,
                fixedWaveColor: widget.isTheSender
                    ? widget.themeColors.myMessageWaveFormFixedColor
                    : widget.themeColors.hisMessageWaveFormFixedColor,
                liveWaveColor: widget.isTheSender
                    ? widget.themeColors.myMessageWaveFormLiveColor
                    : widget.themeColors.hisMessageWaveFormLiveColor,
                waveThickness: 2.5,
                scaleFactor: 30,
                showTop: true,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatefulBuilder(
                  builder: (context, setState) => BlocListener<VoiceBubbleCubit, VoiceBubbleState>(
                    listener: (context, state) {
                      if (state is VoiceBubblePlayerState) {
                        setState(() {
                          duration = state.duration;
                        });
                      }
                    },
                    child: Text(
                      duration,
                      style: Styles.textStyle12.copyWith(
                        fontWeight: FontWeight.w500,
                        color: widget.isTheSender
                            ? widget.themeColors.myMessageTime
                            : widget.themeColors.hisMessageTime,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      GlFunctions.timeFormat(widget.messageModel.time),
                      style: Styles.textStyle12.copyWith(
                        fontWeight: FontWeight.w500,
                        color: widget.isTheSender
                            ? widget.themeColors.myMessageTime
                            : widget.themeColors.hisMessageTime,
                      ),
                    ),
                    widget.isTheSender
                        ? Icon(
                    widget.  messageModel.isSeen.isNotEmpty ? Icons.done_all_rounded : Icons.done_all_rounded,
                      size: 17,
                      color: widget.messageModel.isSeen.isNotEmpty
                          ? const Color(0xff6fadc7)
                          :widget. themeColors.myMessageTime,
                    )
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
