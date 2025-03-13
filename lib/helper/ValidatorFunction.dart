String usernameValidator(String username) {
  final RegExp usernameRegExp = RegExp(r'^[a-zA-Z0-9]{4,20}$');

  if (username.length < 4 || username.length > 20) {
    return "Username should be between 4 and 20 characters";
  }
  if (!usernameRegExp.hasMatch(username)) {
    return "Username should contain only letters and numbers";
  }

  return "";
}

String passwordValidator(String password) {
  if (password.length < 8 || password.length > 20) {
    return "Password should be between 4 and 20 characters";
  }
  if (!RegExp(r'[a-zA-Z]').hasMatch(password)) {
    return "Password should contain at least one alphabet";
  }
  if (!RegExp(r'\d').hasMatch(password)) {
    return "Password should contain at least one number";
  }

  return "";
}
