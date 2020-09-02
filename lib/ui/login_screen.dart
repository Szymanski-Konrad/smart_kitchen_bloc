import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/blocs/authenticate/auth.dart';
import 'package:smart_kitchen/helpers/constants.dart';
import 'package:smart_kitchen/repository/login_repository.dart';
import 'package:smart_kitchen/widgets/google_login_button.dart';
import 'package:smart_kitchen/widgets/login_button.dart';
import '../blocs/login/login.dart';

class LoginScreen extends StatelessWidget {
  final LoginRepository _loginRepository;

  LoginScreen({@required LoginRepository loginRepository})
      : assert(loginRepository != null),
        _loginRepository = loginRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(loginRepository: _loginRepository),
      child: LoginForm(_loginRepository),
    ));
  }
}

class LoginForm extends StatefulWidget {
  final LoginRepository _loginRepository;

  LoginForm(this._loginRepository);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc _loginBloc;
  // LoginRepository get _loginRepository => widget._loginRepository;
  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onLoginChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  void _onLoginChanged() => _loginBloc.add(LoginEmailChanged(email: _emailController.text));
  void _onPasswordChanged() => _loginBloc.add(LoginPasswordChanged(password: _passwordController.text));

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressed(email: _emailController.text, password: _passwordController.text));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Flushbar(
            message: state.errorMessage,
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ).show(context);
        }
        if (state.isSubmitting) {
          Flushbar(
            message: "Logging in...",
            duration: Duration(seconds: 2),
            backgroundColor: Colors.blue,
            showProgressIndicator: true,
          ).show(context);
        }
        if (state.isSuccess) {
          Flushbar(
            message: "You are logged in successfully",
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ).show(context);
          BlocProvider.of<AuthBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: ListView(
                  children: <Widget>[
                    Text(
                      "Logowanie",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32.0, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email, color: Colors.white,),
                        labelText: "Email"
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isEmailValid ? "Invalid Email" : null;
                      }
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.fingerprint, color: Colors.white),
                        labelText: "Hasło",
                      ),
                      obscureText: true,
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isPasswordValid ? "Invalid Password" : null;
                      },
                    ),
                    SizedBox(height: 20),
                    LoginButton(onPressed: isLoginEnabled(state) ? _onFormSubmitted : null,),
                    GoogleLoginButton(),
                    FlatButton(
                      child: Text("Stwórz nowe konto"),
                      onPressed: () => Navigator.pushNamed(context, registerRoute),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
