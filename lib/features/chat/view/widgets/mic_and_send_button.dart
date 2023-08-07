import 'package:flutter/material.dart';

class MicAndSendButton extends StatelessWidget {
  const MicAndSendButton({
    super.key,
    required this.icons,
    required this.onPressed,
  });

  final IconData icons;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xff00A884),
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(50),
      ),
      onPressed: onPressed,
      child: Icon(
        icons,
        color: Colors.white,
      ),
    );
  }
}

