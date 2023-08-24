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

class PhoneNumberSubmitted extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class PhoneOTPVerified extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationFailure extends AuthenticationState {
  final String failureMessage;

  const AuthenticationFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}
