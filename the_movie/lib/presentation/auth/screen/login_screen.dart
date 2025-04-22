import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/configs/validator/app_validator.dart';
import 'package:the_movie/core/utils/gaps_manager.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/presentation/auth/bloc/auth_movie_cubit.dart';
import 'package:the_movie/presentation/auth/bloc/auth_movie_state.dart';
import 'package:the_movie/presentation/home/screen/home_screen.dart';
import '../../../core/configs/assets/app_colors.dart';

class LoginScreen extends StatefulWidget {
  final bool isUpdate;
  const LoginScreen({super.key, required this.isUpdate});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _nameError;
  String? _passwordError;

  void _login() async {
    setState(() {
      _nameError = AppValidator.validateName(_nameController.text);
      _passwordError = AppValidator.validatePassword(_passwordController.text);
    });

    if (_nameError == null && _passwordError == null) {
      try {
        context.read<AuthMovieCubit>().login(
              name: _nameController.text,
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

  void showUpdate() {
    if (widget.isUpdate == true) {
      showPromotionDialog();
    }
  }

  void showPromotionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.textWhite,
          title: Text("Thông báo",
              style: TextManager.textStyleBlod(TextSizes.s24).copyWith(
                color: AppColors.textBlack,
              )),
          content: Text("Ứng dụng đã có phiên bản mới, vui lòng cập nhât.",
              style: TextManager.textStyleMedium(TextSizes.s18).copyWith(
                color: AppColors.textBlack,
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK",
                  style: TextManager.textStyleMedium(TextSizes.s18).copyWith(
                    color: AppColors.textBlack,
                  )),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      showUpdate();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthMovieCubit, AuthMovieState>(
      listener: (context, state) => {
        if (state is AuthMovieLoading)
          {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const Center(child: CircularProgressIndicator());
              },
            )
          }
        else if (state is AuthMovieSuccess)
          {
            Navigator.of(context, rootNavigator: true).pop(),
            if (state.result == true)
              {AppNavigator.pushReplacement(context, const HomeScreen())}
            else
              {showLoginErrorDialog(context, AppStrings.ErrorLogin)}
          }
        else if (state is AuthMovieFailure)
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
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: AppStrings.userName.tr(),
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
}
