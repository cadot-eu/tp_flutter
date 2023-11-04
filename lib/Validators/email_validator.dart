import 'package:regexpattern/regexpattern.dart';

import '../texts.dart';

class EmailValidator {
  dynamic validate(String? email) {
    if (email == null || email.isEmpty) {
      return fieldHint;
    }
    if (email.isEmail()) {
      return true;
    } else {
      return 'The email is not valid';
    }
  }
}
