import 'package:equatable/equatable.dart';

class UserSignUpData extends Equatable {
  final bool isOnline;
  final int lastActive;
  final String name;
  final String userImage;
  final String emailAddress;
  final String password;
  final String phoneNumber;

  const UserSignUpData({
    required this.isOnline,
    required this.lastActive,
    required this.userImage,
    required this.name,
    required this.emailAddress,
    required this.password,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [
        isOnline,
        lastActive,
        userImage,
        name,
        emailAddress,
        password,
        phoneNumber,
      ];
}
