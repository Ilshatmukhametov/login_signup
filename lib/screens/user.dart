


import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/comm/TextFormField.dart';
import 'package:task/redux/actions.dart';
import 'package:task/screens/login.dart';
import 'package:task/screens/signup.dart';

import '../redux/app_state.dart';
import '../redux/reducers.dart';

class User_page extends StatefulWidget {
  final String login;
  final String password;
  final String email;
  final String number;


  User_page({Key? key, required this.login,required this.password, required this.email, required this.number }) : super(key: key);

  @override
  State<User_page> createState() => _User_pageState();
}

class _User_pageState extends State<User_page> {
  late SharedPreferences pref;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _login = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _name = TextEditingController();

  final TextEditingController _number = TextEditingController();

  final Store<AppState> store = Store(reducer, initialState: AppState(name: 'login', email: 'email', password: 'password', number: 'number'));

  @override
  void initState() {
    super.initState();
    getUserData();

  }

  Future<void> getUserData() async {
    pref = await SharedPreferences.getInstance();

    setState(() {
      _login.text = pref.getString("email").toString();
      _password.text = pref.getString("password").toString();
      _name.text = pref.getString("name").toString();
      _number.text = pref.getString("number").toString();
    ;});
  }

  update() async{
    if (_formKey.currentState!.validate()) {
      pref = await SharedPreferences.getInstance();
      setState(() {
        pref.setString('email', _login.text);
        pref.setString('password', _password.text);
        pref.setString('name', _name.text);
        pref.setString('number', _number.text);
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Редактирование данных успешно!'), duration: Duration(milliseconds: 2000))
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ошибка редактирования данных'), duration: Duration(milliseconds: 2000))
      );
    }
  }

  delete() async {
    pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            Signup_page(),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Профиль успешно удален!'), duration: Duration(milliseconds: 3000))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Редактирование')),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getTextFormField(controller: _login, name: 'email', hintName: 'Логин', icon: Icons.email),
              SizedBox(height: 15),
              getTextFormField(controller: _name, name: 'name', hintName: 'Имя', icon: Icons.person),
              SizedBox(height: 15),
              getTextFormField(controller: _number, name: 'num', hintName: 'Номер', icon: Icons.phone),
              SizedBox(height: 15),
              getTextFormField(controller: _password, name: 'pass', hintName: 'Пароль', icon: Icons.lock),
              SizedBox(height: 30),
              TextButton.icon(
                  onPressed: update,
                  label: Text('Обновить', style: TextStyle(fontSize: 20)),
                  icon: Icon(Icons.update, size: 25)
              ),
              TextButton.icon(
                  onPressed: delete,
                  icon: Icon(Icons.delete_forever,color: Colors.red, size: 20),
                  label: Text('Удалить', style: TextStyle(color: Colors.red, fontSize: 15))
              )
            ],
          ),
        ),
      ),
    );
  }
}



