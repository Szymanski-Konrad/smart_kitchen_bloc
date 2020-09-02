import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserNameChanged extends RegisterEvent {
  final String userName;

  const RegisterUserNameChanged({@required this.userName});

  @override
  List<Object> get props => [userName];

  @override
  String toString() => 'UserNameChanged { userName: $userName }';
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  const RegisterEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  const RegisterPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class RegisterSubmitted extends RegisterEvent {
  final String userName;
  final String email;
  final String password;

  const RegisterSubmitted({
    @required this.userName,
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [userName, email, password];

  @override
  String toString() {
    return 'Submitted { userName: $userName, email: $email, password: $password }';
  }
}
