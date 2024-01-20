part of 'chat_details_body.dart';

class _MessagesListView extends StatefulWidget {
  const _MessagesListView({
    required this.hisPhoneNumber,
    required this.hisProfilePicture,
    required this.themeColors,
    required this.state,
  });

  final String hisPhoneNumber;
  final String hisProfilePicture;
  final ThemeColors themeColors;
  final GetMessagesSuccess state;

  @override
  State<_MessagesListView> createState() => _MessagesListViewState();
}

class _MessagesListViewState extends State<_MessagesListView> {
  bool haveNip(int index, List<MessageModel> item) {
    if (index == item.length - 1) {
      return true;
    } else if (index == 0) {
      return false;
    } else if (item[(index + 1)].theSender == item[(index + 1) - 1].theSender) {
      return false;
    } else if (item[index + 1].theSender != item[(index + 1) - 1].theSender) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: ListView.builder(
              reverse: true,
              itemCount: widget.state.messages.length,
              itemBuilder: (context, index) {
                List<MessageModel> item = widget.state.messages.reversed.toList();
                bool isTheSender = item[index].theSender == widget.state.myPhoneNumber;
                DateTime dateTime = item[index].time.toDate();
                String formattedTime = DateFormat('h:mm a').format(dateTime);
                final haveNips = haveNip(index, item);
                return Padding(
                  padding: EdgeInsets.only(top: 1.5.h),
                  child: _MessageSelectionComponent(
                    messageType: item[index].type,
                    themeColors: widget.themeColors,
                    isTheSender: isTheSender,
                    message: item[index].message,
                    time: formattedTime,
                    isFirstMessage: haveNips,
                    messageModel: item[index],
                    hisPhoneNumber: widget.hisPhoneNumber,
                    hisProfilePicture: widget.hisProfilePicture,
                    itemIndex: index,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
