import 'package:equatable/equatable.dart';

class UserSignUpData extends Equatable {
  const UserSignUpData({
    required this.userImage,
    required this.name,
    required this.emailAddress,
    required this.password,
    required this.phoneNumber,
  });

  final String userImage;
  final String name;
  final String emailAddress;
  final String password;
  final String phoneNumber;

  @override
  List<Object> get props => [
    userImage,
    name,
    emailAddress,
    password,
    phoneNumber,
  ];
}