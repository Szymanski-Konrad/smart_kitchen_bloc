import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'login.dart';
import '../../helpers/validators.dart';
import '../../repository/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository _loginRepository;
  StreamSubscription<ConnectivityResult> subscribtion;
  bool connectionExists;

  LoginBloc({
    @required LoginRepository loginRepository,
  })  : assert(loginRepository != null),
        _loginRepository = loginRepository {
    subscribtion = Connectivity().onConnectivityChanged.listen(_printed);
  }

  _printed(ConnectivityResult event) => connectionExists = event == ConnectivityResult.none ? false : true;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
    Stream<LoginEvent> events,
    TransitionFunction<LoginEvent, LoginState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! LoginEmailChanged && event is! LoginPasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is LoginEmailChanged || event is LoginPasswordChanged);
    }).debounceTime(Duration(milliseconds: 200));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEmailChanged) {
      yield* _mapLoginEmailChangedToState(event.email);
    } else if (event is LoginPasswordChanged) {
      yield* _mapLoginPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapLoginEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapLoginPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    if (!connectionExists) {
      yield LoginState.failure("Brak połączenia z internetem!");
    } else {
      try {
        await _loginRepository.signInWithGoogle();
        yield LoginState.success();
      } catch (e) {
        yield LoginState.failure(e.message);
      }
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    if (!connectionExists)
      yield LoginState.failure("Brak połączenia z internetem");
    else {
      try {
        await _loginRepository.signInWithCredentials(email, password);
        yield LoginState.success();
      } catch (e) {
        yield LoginState.failure(e.message);
      }
    }
  }

  dispose() {
    subscribtion.cancel();
  }
}
