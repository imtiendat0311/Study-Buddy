bool checkEmail(String email) {
  return RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(email) &&
      email.isNotEmpty;
}

bool checkPassword(String password, String password2) {
  return password == password2 && password.isNotEmpty;
}
