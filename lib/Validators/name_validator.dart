import '../texts.dart';

class NameValidator {
  dynamic validate(String? name) {
    if (name == null || name.isEmpty) {
      return fieldHint;
    }
    if (name.length < 3) {
      return true;
    } else {
      return 'The field is too short';
    }
  }
}
