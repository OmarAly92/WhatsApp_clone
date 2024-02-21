part of 'voice_bubble.dart';

class _CircleImage extends StatelessWidget {
  const _CircleImage({
    required this.isTheSender,
    required this.hisProfilePicture, required this.myProfilePicture,
  });

  final bool isTheSender;
  final String hisProfilePicture;
  final String myProfilePicture;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isTheSender ? 13.w : 13.w,
        right: isTheSender ? 0.w : 0,
      ),
      child: SizedBox(
        height: 44.5.r,
        width: 44.5.r,
        child: CustomCircleImage(
          profileImage: isTheSender
              ? myProfilePicture
              : hisProfilePicture,
        ),
      ),
    );
  }
}
