import 'package:flutter/material.dart';

class MicAndSendButton extends StatelessWidget {
  const MicAndSendButton({
    super.key,
    required this.icons,
    this.onTap, this.onTapUp, this.onTapDown,
  });

  final IconData icons;
  final GestureTapUpCallback? onTapUp;
  final GestureTapDownCallback? onTapDown;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onTapUp: onTapUp,
      onTapDown: onTapDown,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff00A884),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          icons,
          color: Colors.white,
        ),
      ),
    );
  }
}
