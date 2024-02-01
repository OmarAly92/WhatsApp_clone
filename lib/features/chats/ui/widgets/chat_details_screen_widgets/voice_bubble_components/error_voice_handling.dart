part of 'voice_bubble.dart';

class _ErrorVoiceHandling extends StatelessWidget {
  const _ErrorVoiceHandling({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VoiceBubbleCubit, VoiceBubbleState>(
      listener: (context, state) {
        if (state is VoiceBubbleError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Download error: ${state.errorMessage}'),
              duration: const Duration(seconds: 1),
            ),
          );
        } else if (state is VoiceBubbleInitial) {
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
