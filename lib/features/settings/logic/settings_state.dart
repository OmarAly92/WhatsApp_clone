part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  @override
  List<Object> get props => [];
}

class SettingsSuccess extends SettingsState {
  final UserModel user;

  const SettingsSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class SettingsFailure extends SettingsState {
  final String failureMessage;

  const SettingsFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}
