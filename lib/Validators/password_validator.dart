import 'package:regexpattern/regexpattern.dart';
import 'package:tp/texts.dart';

class PasswordValidator {
  dynamic validate(String? password, String? repeatPassword) {
    if (password == null ||
        password.isEmpty ||
        repeatPassword == null ||
        repeatPassword.isEmpty) {
      return notempty;
    }
//on vérifie que le mot de passe >8 caractères etqu'il contient au moins une lettre et un nombre
    bool isValidPassword = password.isPasswordNormal1();
    if (!isValidPassword) {
      return passwordHint;
    }
    if (password == repeatPassword) {
      return true;
    } else {
      return notmatch;
    }
  }
}
