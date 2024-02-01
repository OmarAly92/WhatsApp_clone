part of 'authentication_old_cubit.dart';

abstract class AuthenticationOldState extends Equatable {
  const AuthenticationOldState();
}

class AuthenticationInitialOld extends AuthenticationOldState {
  @override
  List<Object> get props => [];
}

class AuthenticationLoadingOld extends AuthenticationOldState {
  @override
  List<Object> get props => [];
}

class PhoneNumberSubmitted extends AuthenticationOldState {
  @override
  List<Object> get props => [];
}

class PhoneOTPVerified extends AuthenticationOldState {
  @override
  List<Object> get props => [];
}

class AuthenticationFailureOld extends AuthenticationOldState {
  final String failureMessage;

  const AuthenticationFailureOld({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}
