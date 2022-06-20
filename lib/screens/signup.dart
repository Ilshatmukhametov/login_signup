import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/redux/app_state.dart';
import 'package:task/redux/reducers.dart';
import 'package:task/screens/login.dart';

import '../comm/TextFormField.dart';


class Signup_page extends StatefulWidget {
  Signup_page({Key? key}) : super(key: key);

  @override
  State<Signup_page> createState() => _Signup_pageState();
}

class _Signup_pageState extends State<Signup_page> {
  late SharedPreferences pref;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _login = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _name = TextEditingController();

  final TextEditingController _number = TextEditingController();

  signUp() async{
    if(_formKey.currentState!.validate()) {
      pref = await SharedPreferences.getInstance();
      pref.setString('email', _login.text);
      pref.setString('password', _password.text);
      pref.setString('name', _name.text);
      pref.setString('number', _number.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Login_page()
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Регистрация успешна!'), duration: Duration(milliseconds: 1000))
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ошибка регистрации!'), duration: Duration(milliseconds: 1000))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: ListView(
        children: [
          SizedBox(height: 70),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Регистрация',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      getTextFormField(controller: _name, hintName: 'Имя', icon: Icons.person, name: 'Name',),
                      const SizedBox(
                        height: 20,
                      ),
                      getTextFormField(controller: _number, hintName: 'Номер телефона', icon: Icons.phone, initialValue: '+7 или 8 ', name: 'Number', inputType: TextInputType.number),
                      const SizedBox(
                        height: 20,
                      ),
                      getTextFormField(controller: _login, hintName: 'Почта', icon: Icons.email, name: 'Email',),

                      const SizedBox(
                        height: 20,
                      ),
                      getTextFormField(controller: _password, hintName: 'Пароль', icon: Icons.lock, isObscureText: true, name: 'Password',),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: signUp,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                        ),
                        child: const Text(
                          'Зарегистрироваться',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Уже зарегистрированы?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  Login_page(),
                                ),
                              );
                            },
                            child: const Text('Войти'),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
