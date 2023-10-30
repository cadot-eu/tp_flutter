import 'package:flutter/material.dart';

import '../../styles/login.dart';

class TextFieldDecoration {
  static const InputBorder border = UnderlineInputBorder();
  static Icon? prefixIcon;
  static Icon? suffixicon;
  static String? labelText;
  static String? hintText;
  static TextStyle style = fieldStyle;

  static InputDecoration fieldDecoration(
      {Icon? suffixicon,
      prefixIcon,
      String? labelText,
      String? hintText,
      TextStyle? style}) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      prefixIcon: prefixIcon,
      suffixIcon: suffixicon,
      hintText: hintText,
      border: border,
      labelText: labelText,
      labelStyle: style,
    );
  }
}
