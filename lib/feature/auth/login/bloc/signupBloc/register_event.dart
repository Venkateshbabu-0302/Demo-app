part of 'register_bloc.dart';


abstract class RegisterEvent extends Equatable {
}

class SignUpEvent extends RegisterEvent {

  final String? email ;
  final String? password;
  SignUpEvent({this.email, this.password});


  @override
  List<Object?> get props => [email,password];
}