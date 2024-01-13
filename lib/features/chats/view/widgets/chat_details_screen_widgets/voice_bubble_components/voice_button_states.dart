part of 'voice_bubble.dart';

class _VoiceButtonStates extends StatefulWidget {
  const _VoiceButtonStates({
    required this.themeColors,
    required this.messageModel,
    required this.hisPhoneNumber,
  });

  final ThemeColors themeColors;
  final MessageModel messageModel;
  final String hisPhoneNumber;

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
    return BlocBuilder<VoiceBubbleCubit, VoiceBubbleState>(
      builder: (context, state) {
        if (state is VoiceBubbleVoiceExists) {
          return IconButton(
            onPressed: () {
              BlocProvider.of<VoiceBubbleCubit>(context).playAndPause();
            },
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow_rounded,
              size: 44.r,
              color: widget.themeColors.bodyTextColor,
            ),
          );
        } else if (state is VoiceBubbleIsPlaying) {
          return IconButton(
            onPressed: () {
              BlocProvider.of<VoiceBubbleCubit>(context).playAndPause();
            },
            icon: Icon(
              Icons.pause,
              size: 44.r,
              color: widget.themeColors.bodyTextColor,
            ),
          );
        } else if (state is VoiceBubbleIsNotPlaying) {
          return IconButton(
            onPressed: () {
              BlocProvider.of<VoiceBubbleCubit>(context).playAndPause();
            },
            icon: Icon(
              Icons.play_arrow_rounded,
              size: 44.r,
              color: widget.themeColors.bodyTextColor,
            ),
          );
        } else if (state is VoiceBubbleLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is VoiceBubbleVoiceNotExists) {
          return IconButton(
            onPressed: () {
              BlocProvider.of<VoiceBubbleCubit>(context).downloadVoiceFile(
                voiceUrl: widget.messageModel.message,
                hisPhoneNumber: widget.hisPhoneNumber,
              );
            },
            icon: Icon(
              Icons.download_for_offline_outlined,
              color: widget.themeColors.bodyTextColor,
              size: 32.r,
            ),
          );
        } else if (state is VoiceBubbleDownloadError) {
          return IconButton(
            onPressed: () {
              BlocProvider.of<VoiceBubbleCubit>(context).downloadVoiceFile(
                voiceUrl: widget.messageModel.message,
                hisPhoneNumber: widget.hisPhoneNumber,
              );
            },
            icon: Icon(
              Icons.download_for_offline_outlined,
              color: widget.themeColors.bodyTextColor,
              size: 32.r,
            ),
          );
        } else {
          return IconButton(
            onPressed: () {
              BlocProvider.of<VoiceBubbleCubit>(context).downloadVoiceFile(
                voiceUrl: widget.messageModel.message,
                hisPhoneNumber: widget.hisPhoneNumber,
              );
            },
            icon: Icon(
              Icons.download_for_offline_outlined,
              color: widget.themeColors.bodyTextColor,
              size: 32.r,
            ),
          );
        }
      },
    );
  }
}
