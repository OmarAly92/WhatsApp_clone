part of 'chat_details_body.dart';

class _MessageSelectionComponent extends StatefulWidget {
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
    required this.itemIndex,
  });

  final int itemIndex;
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
  State<_MessageSelectionComponent> createState() => _MessageSelectionComponentState();
}

class _MessageSelectionComponentState extends State<_MessageSelectionComponent> {
  int isSelected = -1;
  int isSelectedLongPress = -1;

  Widget messageSelection() {
    var backgroundBlendMode = isSelected == widget.itemIndex ? BlendMode.clear : BlendMode.src;

    if (widget.messageType == 'message') {
      return MessageBubble(
        themeColors: widget.themeColors,
        isTheSender: widget.isTheSender,
        message: widget.message,
        time: widget.time,
        isFirstMessage: widget.isFirstMessage,
        backgroundBlendMode: backgroundBlendMode,
      );
    } else if (widget.messageType == 'voice') {
      return BlocProvider(
        create: (context) => VoiceBubbleCubit(),
        child: VoiceBubble(
          themeColors: widget.themeColors,
          isTheSender: widget.isTheSender,
          hisProfilePicture: widget.hisProfilePicture,
          isFirstMessage: widget.isFirstMessage,
          messageModel: widget.messageModel,
          hisPhoneNumber: widget.hisPhoneNumber,
          backgroundBlendMode: backgroundBlendMode,
        ),
      );
    } else {
      return ImageBubble(
        image: widget.message,
        time: widget.time,
        isTheSender: widget.isTheSender,
        themeColors: widget.themeColors,
        isFirstMessage: widget.isFirstMessage,
        backgroundBlendMode: backgroundBlendMode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return BlocListener<ChatDetailParentCubit, ChatDetailParentState>(
        listener: (context, state) {
          if (state is ChatDetailParentInitial) {
            setState(() {
              isSelected = state.isSelected;
              isSelectedLongPress = state.isSelectedLongPress;
            });
          }
        },
        child: InkWell(
          onLongPress: () {
            if (BlocProvider.of<ChatDetailParentCubit>(context).selectedItemCount < 1) {
              if (isSelectedLongPress == widget.itemIndex) {
              } else {
                isSelectedLongPress = widget.itemIndex;
                BlocProvider.of<ChatDetailParentCubit>(context).selectedItemCount++;
                BlocProvider.of<ChatDetailParentCubit>(context).messagesId.add(widget.messageModel.messageId);
                BlocProvider.of<ChatDetailParentCubit>(context).fileUrl.add(widget.messageModel.message);
              }
            }
            BlocProvider.of<ChatDetailParentCubit>(context).checkLongPressedState(isSelectedLongPress);
          },
          onTap: () {
            if (isSelectedLongPress == widget.itemIndex) {
              isSelectedLongPress = -1;
              BlocProvider.of<ChatDetailParentCubit>(context).selectedItemCount--;
              BlocProvider.of<ChatDetailParentCubit>(context).messagesId.remove(widget.messageModel.messageId);
              BlocProvider.of<ChatDetailParentCubit>(context).fileUrl.remove(widget.messageModel.message);

            } else if (BlocProvider.of<ChatDetailParentCubit>(context).selectedItemCount >= 1) {
              isSelectedLongPress = widget.itemIndex;
              BlocProvider.of<ChatDetailParentCubit>(context).selectedItemCount++;
              BlocProvider.of<ChatDetailParentCubit>(context).messagesId.add(widget.messageModel.messageId);
              BlocProvider.of<ChatDetailParentCubit>(context).fileUrl.add(widget.messageModel.message);

            }
            BlocProvider.of<ChatDetailParentCubit>(context).checkLongPressedState(isSelectedLongPress);
          },
          onHighlightChanged: (value) {
            if (value) {
              setState(() {
                isSelected = widget.itemIndex;
              });
            } else {
              setState(() {
                isSelected = -1;
              });
            }
          },
          child: Container(
            color: isSelectedLongPress == widget.itemIndex
                ? widget.themeColors.onLongPressedMessageColor.withOpacity(.28)
                : Colors.transparent,
            child: messageSelection(),
          ),
        ),
      );
    });
  }

  void onHighlightChanged(bool value, int index) {
    if (value) {
      setState(() {
        isSelected = index;
      });
    } else {
      setState(() {
        isSelected = -1;
      });
    }
  }
}
