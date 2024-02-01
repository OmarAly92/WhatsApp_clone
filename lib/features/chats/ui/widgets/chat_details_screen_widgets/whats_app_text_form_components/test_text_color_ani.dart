import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ColorizeAnimatedTextCustom extends AnimatedText {
  final Duration speed;

  final List<Color> colors;
  final TextDirection textDirection;

  ColorizeAnimatedTextCustom(
    String text, {
    TextAlign textAlign = TextAlign.start,
    required TextStyle textStyle,
    this.speed = const Duration(milliseconds: 200),
    required this.colors,
    this.textDirection = TextDirection.ltr,
  })  : assert(null != textStyle.fontSize),
        assert(colors.length > 1),
        super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: speed * text.characters.length,
        );

  late Animation<double> _colorShifter;

  late List<Color> _colors;

  @override
  void initAnimation(AnimationController controller) {
    final tuning = (300.0 * colors.length) * (textStyle!.fontSize! / 24.0) * 0.75 * (textCharacters.length / 15.0);

    final colorShift = colors.length * tuning;
    final colorTween = textDirection == TextDirection.rtl
        ? Tween<double>(
            begin: 0.0,
            end: colorShift,
          )
        : Tween<double>(
            begin: colorShift,
            end: 0.0,
          );
    _colorShifter = colorTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );

    _colors = textDirection == TextDirection.rtl ? colors : colors.reversed.toList(growable: false);
  }

  @override
  Widget completeText(BuildContext context) {
    final linearGradient = LinearGradient(colors: _colors).createShader(
      Rect.fromLTWH(0.0, 0.0, _colorShifter.value, 0.0),
    );

    return DefaultTextStyle.merge(
      style: textStyle,
      child: Text(
        text,
        style: TextStyle(foreground: Paint()..shader = linearGradient),
        textAlign: textAlign,
      ),
    );
  }

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    return completeText(context);
  }
}
