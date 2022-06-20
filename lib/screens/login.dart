import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/comm/TextFormField.dart';
import 'package:task/screens/signup.dart';
import 'package:task/screens/user.dart';

class Login_page extends StatefulWidget {
  Login_page({Key? key}) : super(key: key);

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  late SharedPreferences pref;

  String logg = '';

  String pass = '';

  String number = '';

  String email = '';

  logIn() async{
    if(_formKey.currentState!.validate()) {
      pref = await SharedPreferences.getInstance();
      logg = pref.getString('name').toString();
      pass = pref.getString('password').toString();
      number = pref.getString('number').toString();
      email = pref.getString('email').toString();

      if ((_login.text == email && _password.text == pass) || (_login.text == number && _password.text == pass)) {
        print('круто');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                User_page(login: logg, password: pass, number: number, email: email),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Авторизация успешна!'), duration: Duration(milliseconds: 1000))
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Неверный логин или пароль. \nПри входе с помощью номера, вводите без +7 или 8.'), duration: Duration(milliseconds: 2000))
        );
      }
    }
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _login = TextEditingController();

  final TextEditingController _password = TextEditingController();

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
                  'Авторизация',
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
                      getTextFormField(controller: _login, hintName: 'Почта или номер телефона', icon: Icons.person, name: 'Email or number',),
                      const SizedBox(
                        height: 20,
                      ),
                      getTextFormField(controller: _password, hintName: 'Пароль', icon: Icons.lock, isObscureText: true, name: 'Password'),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: logIn,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                        ),
                        child: const Text(
                          'Войти',
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
                          const Text('Еще не зарегистрированы?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  Signup_page(),
                                ),
                              );
                            },
                            child: const Text('Создать аккаунт'),
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
