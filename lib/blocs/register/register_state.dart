import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isUserNameValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  bool get isFormValid => isUserNameValid && isEmailValid && isPasswordValid;

  RegisterState({
    @required this.isUserNameValid,
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.errorMessage,
  });

  factory RegisterState.initial() {
    return RegisterState(
      isUserNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      errorMessage: null,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isUserNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      errorMessage: null,
    );
  }

  factory RegisterState.failure(String error) {
    return RegisterState(
      isUserNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      errorMessage: error,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isUserNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      errorMessage: null,
    );
  }

  RegisterState update({
    bool isUserNameValid,
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isUserNameValid: isUserNameValid,
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isUserNameValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    String error,
  }) {
    return RegisterState(
      isUserNameValid: isUserNameValid ?? this.isUserNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: error,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isUserNameValid: $isUserNameValid,
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,      
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      error: $errorMessage,
    }''';
  }
}
