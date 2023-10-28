import 'package:regexpattern/regexpattern.dart';

class EmailValidator {
  dynamic validate(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please fill this field';
    }
    if (email.isEmail()) {
      return true;
    } else {
      return 'The email is not valid';
    }
  }
}
