import 'package:regexpattern/regexpattern.dart';

class PasswordValidator {
  dynamic validate(String? password, String? repeatPassword) {
    if (password == null ||
        password.isEmpty ||
        repeatPassword == null ||
        repeatPassword.isEmpty) {
      return 'Password or repeat password is empty';
    }
//on vérifie que le mot de passe >8 caractères etqu'il contient au moins une lettre et un nombre
    bool isValidPassword = password.isPasswordNormal1();
    if (!isValidPassword) {
      return 'Password must be at least 8 characters and must contain at least one letter and one number';
    }
    if (password == repeatPassword) {
      return true;
    } else {
      return 'The passwords do not match';
    }
  }
}
