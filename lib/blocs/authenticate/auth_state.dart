import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthState extends Equatable {
  const AuthState._({
    this.displayName = '',
    this.status = AuthStatus.unknown,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated(String displayName) 
    : this._(status: AuthStatus.authenticated, displayName: displayName);

  const AuthState.unauthenticated()
    : this._(status: AuthStatus.unauthenticated);

  final AuthStatus status;
  final String displayName;

  @override
  List<Object> get props => [status, displayName];
}