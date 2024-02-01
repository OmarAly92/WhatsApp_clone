part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationFailure extends AuthenticationState {
  final String failureMessage;

  const AuthenticationFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}

class AuthenticationProfileImageChanged extends AuthenticationState {
  final String profileImage;

  const AuthenticationProfileImageChanged({required this.profileImage});

  @override
  List<Object> get props => [profileImage];
}
