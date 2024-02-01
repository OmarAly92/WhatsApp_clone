part of 'select_contact_cubit.dart';

abstract class SelectContactState extends Equatable {
  const SelectContactState();
}

class SelectContactInitial extends SelectContactState {
  @override
  List<Object> get props => [];
}

class SelectContactLoading extends SelectContactState {
  @override
  List<Object> get props => [];
}

class SelectContactSuccess extends SelectContactState {
  final List<UserModel> userModel;

  const SelectContactSuccess({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

class SelectContactFailure extends SelectContactState {
  final String failureMessage;

  const SelectContactFailure({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}
