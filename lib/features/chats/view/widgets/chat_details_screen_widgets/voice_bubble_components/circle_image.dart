part of 'voice_bubble.dart';

class _CircleImage extends StatelessWidget {
  const _CircleImage({
    required this.isTheSender,
    required this.hisProfilePicture,
  });

  final bool isTheSender;
  final String hisProfilePicture;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isTheSender ? 13.w : 13.w,
        right: isTheSender ? 13.w : 0,
      ),
      child: SizedBox(
        height: 52.r,
        width: 52.r,
        child: CustomCircleImage(
          profileImage: isTheSender
              ? 'https://th.bing.com/th/id/OIP.LEdWiNYXu4hW21hWPIaXwwHaEo?rs=1&pid=ImgDetMain'
              : hisProfilePicture,
        ),
      ),
    );
  }
}
