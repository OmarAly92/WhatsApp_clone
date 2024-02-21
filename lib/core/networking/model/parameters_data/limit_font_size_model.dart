import 'package:equatable/equatable.dart';

class LimitFontSizeModel extends Equatable {
  final double upperLimit;

  final double lowerLimit;

  const LimitFontSizeModel({required this.upperLimit, required this.lowerLimit});

  @override
  List<Object> get props => [upperLimit, lowerLimit];
}
