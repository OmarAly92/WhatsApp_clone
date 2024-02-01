part of 'image_bubble.dart';

class _ErrorImageHandling extends StatelessWidget {
  const _ErrorImageHandling({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImageBubbleCubit, ImageBubbleState>(
      listener: (context, state) {
        if (state is ImageBubbleError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Download error: ${state.errorMessage}'),
              duration: const Duration(seconds: 1),
            ),
          );
        } else if (state is ImageBubbleInitial) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Download error: Initial'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      child: child,
    );
  }
}
