part of 'voice_bubble_cubit.dart';

abstract class VoiceBubbleState extends Equatable {
  const VoiceBubbleState();
}

class VoiceBubbleInitial extends VoiceBubbleState {
  @override
  List<Object> get props => [];
}

class VoiceBubbleIsPlaying extends VoiceBubbleState {
  @override
  List<Object> get props => [];
}

class VoiceBubbleLoading extends VoiceBubbleState {
  final double progress;

  const VoiceBubbleLoading({required this.progress});

  @override
  List<Object> get props => [progress];
}

class VoiceBubbleDownloadError extends VoiceBubbleState {
  final String errorMessage;


  const VoiceBubbleDownloadError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class VoiceBubbleIsNotPlaying extends VoiceBubbleState {
  @override
  List<Object> get props => [];
}

class VoiceBubbleVoiceExists extends VoiceBubbleState {
  final String voiceFilePath;

  const VoiceBubbleVoiceExists({required this.voiceFilePath});

  @override
  List<Object> get props => [voiceFilePath];
}

class VoiceBubbleVoiceNotExists extends VoiceBubbleState {
  @override
  List<Object> get props => [];
}

class VoiceBubblePlayerControllerInit extends VoiceBubbleState {
  @override
  List<Object> get props => [];
}
