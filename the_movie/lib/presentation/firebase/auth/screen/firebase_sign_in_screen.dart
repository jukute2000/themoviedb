import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_colors.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/configs/validator/app_validator.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/presentation/firebase/auth/bloc/auth_cubit.dart';
import 'package:the_movie/presentation/firebase/auth/bloc/auth_state.dart';
import 'package:the_movie/presentation/firebase/auth/screen/firebase_login_screen.dart';
import 'package:the_movie/presentation/firebase/home/home/home_screen.dart';

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
                        AppStrings.signUp.tr(),
                        style: TextManager.textStyleBlod(TextSizes.s32)
                            .copyWith(color: AppColors.borderSelected),
                        textAlign: TextAlign.center,
                      ),
                      GapsManager.h40,
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: AppStrings.name.tr(),
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          errorText: _nameError,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _nameError = AppValidator.validateName(value);
                          });
                        },
                      ),
                      GapsManager.h20,
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: AppStrings.enterGmail.tr(),
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
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
                            borderRadius: BorderRadius.circular(10.r),
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
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.all(PaddingSizes.p16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          AppStrings.signUp.tr(),
                          style: TextManager.textStyleBlod(TextSizes.s16),
                        ),
                      ),
                      GapsManager.h20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.alreadyAccount.tr(),
                            style: TextManager.textStyleMedium(TextSizes.s16),
                          ),
                          GestureDetector(
                            onTap: _navigateToLogin,
                            child: Text(
                              AppStrings.signIn.tr(),
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
