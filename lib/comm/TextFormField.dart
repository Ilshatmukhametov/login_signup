import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:task/comm/comHelper.dart';


class getTextFormField extends StatelessWidget {
  TextEditingController controller;
  String name;
  String hintName;
  IconData icon;
  bool isObscureText;
  TextInputType inputType;
  bool isEnable;
  String ?initialValue;

  getTextFormField(
      {required this.controller,
        required this.name,
        required this.hintName,
        required this.icon,

        this.isObscureText = false,
        this.inputType = TextInputType.text,
        this.isEnable = true,
       this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        enabled: isEnable,
        keyboardType: inputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            String hint = hintName.toLowerCase();
            return 'Пожалуйста, заполните поле $hint';
          }
          if (name == "Email" && EmailValidator.validate(value) == false) {
            return 'Пожалуйста, введите верную почту';
          }
          if (name == 'Password' && !validatePassword(value)) {
            return 'Пароль должен быть не менее 8 символов и содержать латинские символы с цифрами';
          }
          return null;
        },
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
          prefixText: initialValue,
          prefixStyle: TextStyle(fontSize: 16),
          errorMaxLines: 2,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          prefixIcon: Icon(icon),
          hintText: hintName,
          labelText: hintName,
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}