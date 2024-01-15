part of 'voice_bubble.dart';

class _AudioWaveVoiceDurationAndVoiceTime extends StatelessWidget {
  const _AudioWaveVoiceDurationAndVoiceTime({
    required this.themeColors,
    required this.messageModel,
    required this.isTheSender,
  });

  final ThemeColors themeColors;
  final MessageModel messageModel;
  final bool isTheSender;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: isTheSender ? EdgeInsets.only(right: 12.w) : EdgeInsets.zero,
        child: Column(
          children: [
            SizedBox(height: 10.h),
            AudioFileWaveforms(
              enableSeekGesture: true,
              size: Size(double.maxFinite, 25.w),
              playerController: BlocProvider.of<VoiceBubbleCubit>(context).audioPlayerController,
              waveformData: messageModel.waveData.cast<double>(),
              waveformType: WaveformType.fitWidth,
              continuousWaveform: true,
              playerWaveStyle: PlayerWaveStyle(
                waveCap: StrokeCap.round,
                spacing: 3.5,
                fixedWaveColor: isTheSender
                    ? themeColors.myMessageWaveFormFixedColor
                    : themeColors.hisMessageWaveFormFixedColor,
                liveWaveColor:
                    isTheSender ? themeColors.myMessageWaveFormLiveColor : themeColors.hisMessageWaveFormLiveColor,
                waveThickness: 2.5,
                scaleFactor: 30,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '0:60',
                  style: Styles.textStyle12.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isTheSender ? themeColors.myMessageTime : themeColors.hisMessageTime,
                  ),
                ),
                Text(
                  formattedTime(),
                  style: Styles.textStyle12.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isTheSender ? themeColors.myMessageTime : themeColors.hisMessageTime,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formattedTime() {
    DateTime dateTime = messageModel.time.toDate();
    String formattedTime = DateFormat('h:mm a').format(dateTime);
    return formattedTime;
  }
}
