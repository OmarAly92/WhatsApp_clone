part of 'chat_details_body.dart';

class _MessagesListView extends StatelessWidget {
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
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                List<MessageModel> item = state.messages.reversed.toList();
                bool isTheSender = item[index].theSender == state.myPhoneNumber;
                DateTime dateTime = item[index].time.toDate();
                String formattedTime = DateFormat('h:mm a').format(dateTime);
                final haveNips = haveNip(index, item);
                return _MessageSelectionComponent(
                  messageType: item[index].type,
                  themeColors: themeColors,
                  isTheSender: isTheSender,
                  message: item[index].message,
                  time: formattedTime,
                  isFirstMessage: haveNips,
                  messageModel: item[index],
                  hisPhoneNumber: hisPhoneNumber,
                  hisProfilePicture: hisProfilePicture,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
