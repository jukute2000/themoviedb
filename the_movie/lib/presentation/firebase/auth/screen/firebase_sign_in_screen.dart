import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/configs/validator/app_validator.dart';
import 'package:the_movie/presentation/firebase/auth/bloc/auth_cubit.dart';
import 'package:the_movie/presentation/firebase/auth/bloc/auth_state.dart';
import 'package:the_movie/presentation/firebase/auth/screen/firebase_login_screen.dart';
import 'package:the_movie/presentation/firebase/home/screen/home/home_screen.dart';

class FirebaseSignInScreen extends StatefulWidget {
  const FirebaseSignInScreen({super.key});

  @override
  State<FirebaseSignInScreen> createState() => _FirebaseSignInScreenState();
}

class _FirebaseSignInScreenState extends State<FirebaseSignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  void _register() async {
    setState(() {
      _nameError = AppValidator.validateName(_nameController.text);
      _emailError = AppValidator.validateEmail(_emailController.text);
      _passwordError = AppValidator.validatePassword(_passwordController.text);
    });

    if (_nameError == null && _emailError == null && _passwordError == null) {
      try {
        context.read<AuthCubit>().signIn(
              email: _emailController.text,
              password: _passwordController.text,
              name: _nameController.text,
            );
      } catch (e) {
        print(e.toString());
      }
    } else {
      showLoginErrorDialog(context, AppStrings.ErrorSignIn);
    }
  }

  void _navigateToLogin() {
    AppNavigator.pushReplacement(context, const FirebaseLoginScreen());
  }

  void showLoginErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(AppStrings.ErrorSignIn),
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
                        AppStrings.signInChat,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: AppStrings.name,
                          hintText: AppStrings.hintextName,
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorText: _nameError,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _nameError = AppValidator.validateName(value);
                          });
                        },
                      ),
                      const SizedBox(height: 16),
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
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          AppStrings.signIn,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(AppStrings.alreadyAccount),
                          GestureDetector(
                            onTap: _navigateToLogin,
                            child: const Text(
                              AppStrings.signInHere,
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
