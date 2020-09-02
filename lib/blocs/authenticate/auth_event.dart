import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {
  @override
  String toString() => "AppStarted";
}

class SplashEnded extends AuthEvent {
  @override
  String toString() => "SplashEnded";
}

class LoggedIn extends AuthEvent {
  @override
  String toString() => "LoggedIn";
}

class LoggedOut extends AuthEvent {
  @override
  String toString() => "LoggedOut";
}