import 'package:equatable/equatable.dart';

class UserLoginData extends Equatable {
  final String emailAddress;
  final String password;

  const UserLoginData({required this.emailAddress, required this.password});

  @override
  List<Object> get props => [emailAddress, password];
}
