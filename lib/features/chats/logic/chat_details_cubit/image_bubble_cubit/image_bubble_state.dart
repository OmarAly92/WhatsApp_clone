part of 'image_bubble_cubit.dart';

abstract class ImageBubbleState extends Equatable {
  const ImageBubbleState();
}

class ImageBubbleInitial extends ImageBubbleState {
  @override
  List<Object> get props => [];
}

class ImageBubbleImageExistence extends ImageBubbleState {
  final String imageFilePath;
  final bool isExisted;

  const ImageBubbleImageExistence({
    required this.imageFilePath,
    required this.isExisted,
  });

  @override
  List<Object> get props => [imageFilePath, isExisted];
}

class ImageBubbleLoading extends ImageBubbleState {
  final double progress;

  const ImageBubbleLoading({required this.progress});

  @override
  List<Object> get props => [progress];
}

class ImageBubbleError extends ImageBubbleState {
  final String errorMessage;

  const ImageBubbleError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
