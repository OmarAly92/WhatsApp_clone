part of 'voice_bubble.dart';

class _AudioWaveVoiceDurationAndVoiceTime extends StatefulWidget {
  const _AudioWaveVoiceDurationAndVoiceTime({
    required this.themeColors,
    required this.messageModel,
  });

  final ThemeColors themeColors;
  final MessageModel messageModel;

  @override
  State<_AudioWaveVoiceDurationAndVoiceTime> createState() => _AudioWaveVoiceDurationAndVoiceTimeState();
}

class _AudioWaveVoiceDurationAndVoiceTimeState extends State<_AudioWaveVoiceDurationAndVoiceTime> {
  late List<double> waveData;
  @override
  void initState() {
    super.initState();

    waveData = widget.messageModel.waveData.cast<double>();
    for (int i = 0; i < 18; i++) {
      waveData.add(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: 16.h),
          AudioFileWaveforms(
            enableSeekGesture: true,
            size: const Size(double.maxFinite, 25),
            playerController: BlocProvider.of<VoiceBubbleCubit>(context).playerController,
            waveformData: waveData,
            waveformType: WaveformType.fitWidth,
            continuousWaveform: true,
            playerWaveStyle: const PlayerWaveStyle(
              waveCap: StrokeCap.round,
              spacing: 5.1,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '00:60',
                style: Styles.textStyle14.copyWith(color: widget.themeColors.theAuthorTextColor),
              ),
              Text(
                formattedTime(),
                style: Styles.textStyle14.copyWith(color: widget.themeColors.theAuthorTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String formattedTime() {
    DateTime dateTime = widget.messageModel.time.toDate();
    String formattedTime = DateFormat('h:mm a').format(dateTime);
    return formattedTime;
  }
}
