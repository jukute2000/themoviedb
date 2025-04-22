import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/configs/validator/app_validator.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';
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
              barrierDismissible: false,
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
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(PaddingSizes.p24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppStrings.signIn.tr(),
                        style: TextManager.textStyleBlod(TextSizes.s32)
                            .copyWith(color: AppColors.borderSelected),
                        textAlign: TextAlign.center,
                      ),
                      GapsManager.h40,
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: AppStrings.enterGmail.tr(),
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
                      GapsManager.h20,
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: AppStrings.password.tr(),
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
                      GapsManager.h20,
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
                        child: Text(
                          AppStrings.signIn.tr(),
                          style: TextManager.textStyleBlack(TextSizes.s16),
                        ),
                      ),
                      GapsManager.h20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.unAlreadyAccount.tr(),
                            style: TextManager.textStyleMedium(
                              TextSizes.s16,
                            ),
                          ),
                          GestureDetector(
                            onTap: _navigateToRegister,
                            child: Text(
                              AppStrings.signUp.tr(),
                              style: TextManager.textStyleBlod(TextSizes.s16)
                                  .copyWith(color: AppColors.borderSelected),
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
