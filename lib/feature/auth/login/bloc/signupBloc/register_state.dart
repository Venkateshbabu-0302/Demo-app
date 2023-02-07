part of 'register_bloc.dart';


abstract class RegisterState extends Equatable {}

class RegisterInitial extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterSuccessful extends RegisterState {
  @override

  List<Object?> get props => [];
}

class RegisterLoading extends RegisterState {
  @override
  List<Object?> get props => [];
}

@immutable
class RegisterError extends RegisterState {

  String? msgError;
  RegisterError(this.msgError);
  @override
  List<Object?> get props => [msgError];
}
