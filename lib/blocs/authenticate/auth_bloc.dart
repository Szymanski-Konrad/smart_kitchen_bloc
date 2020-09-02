import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'auth.dart';
import 'package:bloc/bloc.dart';
import '../../repository/login_repository.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginRepository _loginRepository;

  AuthBloc({@required loginRepository}) : _loginRepository = loginRepository, super();

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is SplashEnded) {
      yield* _mapSplashEndedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _loginRepository.isSignedIn();
      if (isSignedIn) {
        final name = await _loginRepository.getUser();
        yield Authenticated(name);
      } else {
        yield Splash();
      }
    } catch (_) {
      yield Splash();
    }
  }

  Stream<AuthState> _mapSplashEndedToState() async* {
    yield (Unauthenticated());
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    yield Authenticated(await _loginRepository.getUser());
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _loginRepository.signOut();
  }

  
}