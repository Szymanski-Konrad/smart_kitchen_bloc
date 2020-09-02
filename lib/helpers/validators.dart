class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  /// Validate string to email
  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  /// Password validation for at least 8-digitis
  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}