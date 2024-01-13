part of 'chat_details_body.dart';

class _MessageSelectionComponent extends StatelessWidget {
  const _MessageSelectionComponent({
    required this.messageType,
    required this.themeColors,
    required this.isTheSender,
    required this.message,
    required this.time,
    required this.hisPhoneNumber,
    required this.hisProfilePicture,
    required this.isFirstMessage,
    required this.messageModel,
  });

  final String messageType;
  final ThemeColors themeColors;
  final bool isTheSender;
  final String message;
  final String time;
  final String hisPhoneNumber;
  final String hisProfilePicture;
  final bool isFirstMessage;
  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    if (messageType == 'message') {
      return MessageBubble(
        themeColors: themeColors,
        isTheSender: isTheSender,
        message: message,
        time: time,
        isFirstMessage: isFirstMessage,
      );
    } else if (messageType == 'voice') {
      return BlocProvider(
        create: (context) => VoiceBubbleCubit()
          ..checkIfFileExistsAndPlayOrDownload(
            voiceUrl: messageModel.message,
            hisPhoneNumber: hisPhoneNumber,
          ),
        child: VoiceBubble(
          themeColors: themeColors,
          isTheSender: isTheSender,
          hisProfilePicture: hisProfilePicture,
          isFirstMessage: isFirstMessage,
          messageModel: messageModel,
          hisPhoneNumber: hisPhoneNumber,
        ),
      );
    } else {
      return ImageBubble(
        image: message,
        time: time,
        isTheSender: isTheSender,
        themeColors: themeColors,
        isFirstMessage: isFirstMessage,
      );
    }
  }
}
