import 'package:flutter/material.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/data/auth/repositories/auth_repository_impl.dart';
import 'package:the_movie/main.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _userlCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _signinText(),
            const SizedBox(
              height: 30,
            ),
            _emailField(),
            const SizedBox(
              height: 20,
            ),
            _passwordField(),
            const SizedBox(
              height: 60,
            ),
            _signinButton(context),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _signinText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _userlCon,
      decoration: const InputDecoration(hintText: 'UserName'),
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _passwordCon,
      decoration: const InputDecoration(hintText: 'Password'),
    );
  }

  Widget _signinButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        AuthRepositoryImpl.instance
            .loginUser(_userlCon.text, _passwordCon.text)
            .then((result) {
          if (result == true) {
            AppNavigator.pushAndRemove(context, MovieScreen());
          } else {
            print("Login thất bại!");
          }
        });
      },
      child: Text("Login"),
    );
  }
}
