import 'package:flutter/material.dart';

validatePassword(String password) {
  final passReg = new RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  return passReg.hasMatch(password);
}

