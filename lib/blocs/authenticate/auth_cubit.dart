import 'package:bloc/bloc.dart';
import 'package:smart_kitchen/blocs/authenticate/auth_state.dart';
import 'package:smart_kitchen/repository/login_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._loginRepository) : assert(_loginRepository != null), super(const AuthState.unknown());

  final LoginRepository _loginRepository;

  Future<void> endSplash() {
    emit(const AuthState.unauthenticated());
  }

  Future<void> authenticate() {
    emit(AuthState.authenticated(_loginRepository.getUserName()));
  }

  Future<void> logout() {
    _loginRepository.signOut();
    emit(const AuthState.unauthenticated());
  }

  Future<void> tryAuthenticate() async {
    try {
      if (_loginRepository.isSignedIn()) {
        emit(AuthState.authenticated(_loginRepository.getUserName()));
      }      
      else {
        emit(const AuthState.unknown());
      }
    } on Exception {
      emit(const AuthState.unknown());
    }
  }
}