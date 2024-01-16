part of 'voice_bubble_cubit.dart';

abstract class VoiceBubbleState extends Equatable {
  const VoiceBubbleState();
}

class VoiceBubbleInitial extends VoiceBubbleState {
  @override
  List<Object> get props => [];
}

class VoiceBubbleVoiceExistence extends VoiceBubbleState {
  final String voiceFilePath;
  final bool isExisted;

  const VoiceBubbleVoiceExistence({
    required this.voiceFilePath,
    required this.isExisted,
  });

  @override
  List<Object> get props => [voiceFilePath, isExisted];
}

class VoiceBubbleLoading extends VoiceBubbleState {
  final double progress;

  const VoiceBubbleLoading({required this.progress});

  @override
  List<Object> get props => [progress];
}

class VoiceBubblePlayerState extends VoiceBubbleState {
  final bool isPlaying;
  final String duration;

  const VoiceBubblePlayerState({
    required this.isPlaying,
    required this.duration,
  });

  @override
  List<Object> get props => [isPlaying, duration];
}

class VoiceBubbleError extends VoiceBubbleState {
  final String errorMessage;

  const VoiceBubbleError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
