
import 'package:flutter/material.dart';
import '../res/index.dart';

// Considering test methods the ternary operator is used in return values. Since we can't pass context from test.
String? validateEmail(value, BuildContext? cxt) {
  if (value.isEmpty) {
    return  'Email Required';
  }
  if (!emailRegex.hasMatch(value)) {
    return  'Email Not Valid';
  }
  return null;
}

String? validatePwd(value, BuildContext? cxt) {
  if (value.isEmpty) {
    return  'Password Required';
  }
  if (!passwordRegex.hasMatch(value)) {
    return  'Password Not Valid';
  }
  return null;
}



