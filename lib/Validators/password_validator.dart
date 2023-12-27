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
// 8 characters and one letter and one number
    bool isValidPassword = password.isPasswordNormal1();
    if (!isValidPassword) {
      return passwordHint;
    }
//match
    if (password == repeatPassword) {
      return true;
    } else {
      return notmatch;
    }
  }
}
