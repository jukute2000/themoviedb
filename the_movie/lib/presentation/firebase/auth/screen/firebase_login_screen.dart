import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/configs/validator/app_validator.dart';
import 'package:the_movie/presentation/firebase/auth/bloc/auth_cubit.dart';
import 'package:the_movie/presentation/firebase/auth/bloc/auth_state.dart';
import 'package:the_movie/presentation/firebase/auth/screen/firebase_sign_in_screen.dart';
import 'package:the_movie/presentation/firebase/home/home/home_screen.dart';

class FirebaseLoginScreen extends StatefulWidget {
  const FirebaseLoginScreen({super.key});

  @override
  State<FirebaseLoginScreen> createState() => _FirebaseLoginScreenState();
}

class _FirebaseLoginScreenState extends State<FirebaseLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  void _login() async {
    setState(() {
      _emailError = AppValidator.validateEmail(_emailController.text);
      _passwordError = AppValidator.validatePassword(_passwordController.text);
    });

    if (_emailError == null && _passwordError == null) {
      try {
        context.read<AuthCubit>().login(
              email: _emailController.text,
              password: _passwordController.text,
            );
      } catch (e) {
        print(e.toString());
      }
    } else {
      showLoginErrorDialog(context, AppStrings.ErrorLogin);
    }
  }

  void showLoginErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(AppStrings.ErrorLogin),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToRegister() {
    // Chuyển đến trang đăng ký ở đây
    AppNavigator.pushReplacement(context, const FirebaseSignInScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) => {
        if (state is AuthLoading)
          {
            showDialog(
              context: context,
              builder: (context) {
                return const Center(child: CircularProgressIndicator());
              },
            )
          }
        else if (state is AuthSuccess)
          {
            Navigator.of(context, rootNavigator: true).pop(),
            if (state.user.result == true)
              {AppNavigator.pushReplacement(context, const HomeScreen())}
            else
              {showLoginErrorDialog(context, state.user.error)}
          }
        else if (state is AuthFailure)
          {
            Navigator.of(context, rootNavigator: true).pop(),
            showLoginErrorDialog(context, state.error)
          }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        AppStrings.Login,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: AppStrings.email,
                          hintText: AppStrings.hintextEmail,
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorText: _emailError,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            _emailError = AppValidator.validateEmail(value);
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: AppStrings.passwordChat,
                          hintText: AppStrings.hintextPassword,
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorText: _passwordError,
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            _passwordError =
                                AppValidator.validatePassword(value);
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          AppStrings.Login,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(AppStrings.unAlreadyAccount),
                          GestureDetector(
                            onTap: _navigateToRegister,
                            child: const Text(
                              AppStrings.signInChat,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
