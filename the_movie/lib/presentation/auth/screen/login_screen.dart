import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/data/repositories/auth_repository.dart';
import 'package:the_movie/presentation/auth/bloc/login_cuit.dart';
import 'package:the_movie/presentation/auth/bloc/login_state.dart';
import 'package:the_movie/presentation/home/screen/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  void dispose() {
    _emailCon.dispose();
    _passwordCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Sign In',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            const SizedBox(height: 30),
            _emailField(context),
            const SizedBox(height: 20),
            _passwordField(context),
            const SizedBox(height: 60),
            _signinButton(context),
          ],
        ),
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextField(
          controller: _emailCon,
          decoration: InputDecoration(
            hintText: 'UserName',
            // fix email Empty
            errorText: state.email.isEmpty ? "Email cannot be empty" : null,
          ),
          onChanged: (value) => context.read<LoginCubit>().emailChanged(value),
        );
      },
    );
  }

  Widget _passwordField(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextField(
          controller: _passwordCon,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            errorText: (state.password.isEmpty || state.password.length >= 6)
                ? null
                : "Password must be at least 6 characters",
          ),
          onChanged: (value) =>
              context.read<LoginCubit>().passwordChanged(value),
        );
      },
    );
  }

  Widget _signinButton(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.isValid
              ? () async {
                  bool result = await AuthRepositoryImpl.instance
                      .loginUser(_emailCon.text, _passwordCon.text);
                  if (result) {
                    AppNavigator.pushAndRemove(context, const HomeScreen());
                  } else {
                    print("Login thất bại!");
                  }
                }
              : null, // Disable button if form is invalid
          child: const Text("Login"),
        );
      },
    );
  }
}
