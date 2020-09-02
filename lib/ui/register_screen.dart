import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/blocs/authenticate/auth.dart';
import 'package:smart_kitchen/blocs/register/register.dart';
import 'package:smart_kitchen/blocs/register/register_bloc.dart';
import 'package:smart_kitchen/repository/login_repository.dart';

class RegisterScreen extends StatelessWidget {
  final LoginRepository _loginRepository;

  RegisterScreen({@required LoginRepository loginRepository})
      : assert(loginRepository != null),
        _loginRepository = loginRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(loginRepository: _loginRepository),
        child: RegisterForm(_loginRepository),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  final LoginRepository _loginRepository;

  RegisterForm(this._loginRepository);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterForm> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _userNameController.text.isNotEmpty && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _userNameController.addListener(_onUserNameChanged);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Flushbar(
            message: "Register in progress...",
            backgroundColor: Colors.blue,
            showProgressIndicator: true,
            duration: Duration(seconds: 2)
          ).show(context);
        }
        if (state.isSuccess) {
          Flushbar(
            message: "Register successfully",
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ).show(context);
          BlocProvider.of<AuthBloc>(context).add(LoggedIn());
          Navigator.pop(context);
        }
        if (state.isFailure) {
          Flushbar(
            message: state.errorMessage,
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ).show(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: ListView(
                  children: <Widget>[
                    Text(
                      "Rejestracja",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32.0, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.supervised_user_circle,
                            color: Colors.white,
                          ),
                          labelText: "User name"),
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isUserNameValid ? "Invalid UserName" : null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email, color: Colors.white),
                        labelText: "Email",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isEmailValid ? "Invalid Email" : null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.fingerprint,
                          color: Colors.white,
                        ),
                        labelText: "Hasło",
                      ),
                      obscureText: true,
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isPasswordValid ? "Invalid Password" : null;
                      },
                    ),
                    SizedBox(height: 30),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: isRegisterEnabled(state) ? _onFormSubmitted : null,
                      child: Text('Rejestracja'),
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _registerBloc.dispose();
    super.dispose();
  }

  void _onUserNameChanged() {
    _registerBloc.add(RegisterUserNameChanged(userName: _userNameController.text));
  }

  void _onEmailChanged() {
    _registerBloc.add(
      RegisterEmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      RegisterPasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      RegisterSubmitted(
        userName: _userNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
