part of 'chat_details_body.dart';

class _MessageSelection extends StatefulWidget {
  const _MessageSelection({
    required this.themeColors,
    required this.isTheSender,
    required this.message,
    required this.time,
    required this.hisUserModel,
    required this.isFirstMessage,
    required this.messageModel,
    required this.itemIndex,
  });

  final int itemIndex;
  final ThemeColors themeColors;
  final bool isTheSender;
  final String message;
  final String time;
  final UserModel hisUserModel;
  final bool isFirstMessage;
  final MessageModel messageModel;

  @override
  State<_MessageSelection> createState() => _MessageSelectionState();
}

class _MessageSelectionState extends State<_MessageSelection> {
  int isSelected = -1;
  int isSelectedLongPress = -1;
  late UserModel myUserData;

  void triggerReadStatusMethod() {
    if (widget.messageModel.isSeen.isEmpty) {
      if (widget.isTheSender == false) {
        BlocProvider.of<SendMessagesCubit>(context).updateMessageReadStatus(
          messageId: widget.messageModel.messageId,
          hisPhoneNumber: widget.hisUserModel.phoneNumber,
        );
      }
    }
  }
@override
  void initState() {
    super.initState();
    myUserData = BlocProvider.of<ChatDetailParentCubit>(context).myUserData;
}


  Widget messageSelection() {
    triggerReadStatusMethod();

    var backgroundBlendMode = isSelected == widget.itemIndex ? BlendMode.clear : BlendMode.src;

    if (widget.messageModel.type == 'message') {
      return MessageBubble(
        themeColors: widget.themeColors,
        isTheSender: widget.isTheSender,
        isFirstMessage: widget.isFirstMessage,
        backgroundBlendMode: backgroundBlendMode,
        messageModel: widget.messageModel,
      );
    } else if (widget.messageModel.type == 'voice') {
      return BlocProvider(
        create: (context) => VoiceBubbleCubit(),
        child: VoiceBubble(
          themeColors: widget.themeColors,
          isTheSender: widget.isTheSender,
          hisUserModel: widget.hisUserModel,
          isFirstMessage: widget.isFirstMessage,
          messageModel: widget.messageModel,
          backgroundBlendMode: backgroundBlendMode,
          myUserData: myUserData,
        ),
      );
    } else if (widget.messageModel.type == 'image') {
      return BlocProvider(
        create: (context) => ImageBubbleCubit(),
        child: ImageBubble(
          messageModel: widget.messageModel,
          isTheSender: widget.isTheSender,
          themeColors: widget.themeColors,
          isFirstMessage: widget.isFirstMessage,
          backgroundBlendMode: backgroundBlendMode,
          hisPhoneNumber: widget.hisUserModel.phoneNumber,
        ),
      );
    } else if (widget.messageModel.type == 'reply') {
      return ReplyBubble(
        themeColors: widget.themeColors,
        isTheSender: widget.isTheSender,
        isFirstMessage: widget.isFirstMessage,
        backgroundBlendMode: backgroundBlendMode,
        messageModel: widget.messageModel,
        time: widget.time,
      );
    } else {
      return DeletedMessageBubble(
        message: widget.message,
        time: widget.time,
        isTheSender: widget.isTheSender,
        isFirstMessage: widget.isFirstMessage,
        themeColors: widget.themeColors,
        backgroundBlendMode: backgroundBlendMode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color replyColor = widget.isTheSender ? const Color(0xff068D72) : const Color(0xff8d7ed8);
    final String hisName = widget.isTheSender ? 'You' : widget.hisUserModel.name;
    return SwipePlus(
      onDragComplete: () {
        if (widget.messageModel.type != 'deleted') {
          BlocProvider.of<ChatDetailParentCubit>(context).replyMessageTrigger(
            replyMessage: widget.messageModel,
            hisName: hisName,
            replyColor: replyColor,
          );
        }
      },
      minThreshold: 0.25,
      child: StatefulBuilder(builder: (context, setStates) {
        return BlocListener<ChatDetailParentCubit, ChatDetailParentState>(
          listener: (context, state) {
            if (state is ChatDetailParentInitial) {
              setStates(() {
                isSelected = state.isSelected;
                isSelectedLongPress = state.isSelectedLongPress;
              });
            }
          },
          child: InkWell(
            onLongPress: () {
              longPressSelectMessage(context);
            },
            onTap: () {
              onTapMultiSelect(context);
            },
            onHighlightChanged: (value) {
              onHighlightChanged(value, setStates);
            },
            child: Container(
              color: isSelectedLongPress == widget.itemIndex
                  ? widget.themeColors.onLongPressedMessageColor.withOpacity(.28)
                  : Colors.transparent,
              child: messageSelection(),
            ),
          ),
        );
      }),
    );
  }

  void longPressSelectMessage(BuildContext context) {
    if (BlocProvider.of<ChatDetailParentCubit>(context).selectedItemCount < 1) {
      if (isSelectedLongPress == widget.itemIndex) {
      } else {
        isSelectedLongPress = widget.itemIndex;
        BlocProvider.of<ChatDetailParentCubit>(context).selectedItemCount++;
        BlocProvider.of<ChatDetailParentCubit>(context).messagesId.add(widget.messageModel.messageId);
        BlocProvider.of<ChatDetailParentCubit>(context).fileUrl.add(widget.messageModel.message);

        BlocProvider.of<ChatDetailParentCubit>(context).isTheSender.add(widget.isTheSender);
        BlocProvider.of<ChatDetailParentCubit>(context).replyOriginalMessage.add(widget.messageModel);
        BlocProvider.of<ChatDetailParentCubit>(context).messageType.add(widget.messageModel.type);
      }
    }
    BlocProvider.of<ChatDetailParentCubit>(context).checkLongPressedState(isSelectedLongPress);
  }

  void onTapMultiSelect(BuildContext context) {
    if (isSelectedLongPress == widget.itemIndex) {
      isSelectedLongPress = -1;
      BlocProvider.of<ChatDetailParentCubit>(context).selectedItemCount--;
      BlocProvider.of<ChatDetailParentCubit>(context).messagesId.remove(widget.messageModel.messageId);
      BlocProvider.of<ChatDetailParentCubit>(context).fileUrl.remove(widget.messageModel.message);

      BlocProvider.of<ChatDetailParentCubit>(context).isTheSender.remove(widget.isTheSender);
      BlocProvider.of<ChatDetailParentCubit>(context).replyOriginalMessage.remove(widget.messageModel);
      BlocProvider.of<ChatDetailParentCubit>(context).messageType.remove(widget.messageModel.type);
    } else if (BlocProvider.of<ChatDetailParentCubit>(context).selectedItemCount >= 1) {
      isSelectedLongPress = widget.itemIndex;
      BlocProvider.of<ChatDetailParentCubit>(context).selectedItemCount++;
      BlocProvider.of<ChatDetailParentCubit>(context).messagesId.add(widget.messageModel.messageId);
      BlocProvider.of<ChatDetailParentCubit>(context).fileUrl.add(widget.messageModel.message);

      BlocProvider.of<ChatDetailParentCubit>(context).isTheSender.add(widget.isTheSender);
      BlocProvider.of<ChatDetailParentCubit>(context).replyOriginalMessage.add(widget.messageModel);
      BlocProvider.of<ChatDetailParentCubit>(context).messageType.add(widget.messageModel.type);

      ///you can make method in cubit and use it here
      ///and listener to the state in bloc listener
      /// it will fix the delete on long press appbar issue
    }
    BlocProvider.of<ChatDetailParentCubit>(context).checkLongPressedState(isSelectedLongPress);
  }

  void onHighlightChanged(bool value, StateSetter setStates) {
    if (value) {
      setStates(() {
        isSelected = widget.itemIndex;
      });
    } else {
      setStates(() {
        isSelected = -1;
      });
    }
  }
}
