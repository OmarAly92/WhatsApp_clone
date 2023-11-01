import 'package:flutter/material.dart';

class MicAndSendButton extends StatelessWidget {
  const MicAndSendButton({
    super.key,
    required this.icons,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
  });

  final Icon icons;
  final GestureTapUpCallback? onTapUp;
  final GestureTapDownCallback? onTapDown;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onTapUp: onTapUp,
      onTapDown: onTapDown,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: const Color(0xff00A884),
          borderRadius: BorderRadius.circular(50),
        ),
        duration:  const Duration(milliseconds: 200),
        child: icons
      ),
    );
  }
}
