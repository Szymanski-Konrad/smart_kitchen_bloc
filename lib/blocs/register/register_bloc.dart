import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_kitchen/repository/login_repository.dart';
import 'package:smart_kitchen/helpers/validators.dart';
import 'register.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final LoginRepository _loginRepository;

  RegisterBloc({@required LoginRepository loginRepository})
      : assert(loginRepository != null),
        _loginRepository = loginRepository;

  @override
  RegisterState get initialState => RegisterState.initial();

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(Stream<RegisterEvent> events, TransitionFunction<RegisterEvent, RegisterState> transitionFn) {
    final nonDebounceStream = events.where((event) {
      return (event is! RegisterEmailChanged &&
          event is! RegisterPasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is RegisterEmailChanged ||
          event is RegisterPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterUserNameChanged) {
      yield* _mapRegisterUserNameChangedToState(event.userName);
    } else if (event is RegisterEmailChanged) {
      yield* _mapRegisterEmailChangedToState(event.email);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapRegisterPasswordChangedToState(event.password);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(event.userName, event.email, event.password);
    }
  }

  Stream<RegisterState> _mapRegisterUserNameChangedToState(String userName) async* {
    yield state.update(isUserNameValid: userName.isNotEmpty);
  }

  Stream<RegisterState> _mapRegisterEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapRegisterPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(String userName, String email, String password) async* {
    yield RegisterState.loading();
    try {
      await _loginRepository.signUp(email: email, password: password, userName: userName);
      yield RegisterState.success();
    } catch (e) {
      print(e.message);
      yield RegisterState.failure(e.message);
    }
  }

  dispose() {
    
  }
}
