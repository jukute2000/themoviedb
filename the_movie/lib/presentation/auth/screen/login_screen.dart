import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/data/repositories/auth_repository.dart';
import 'package:the_movie/presentation/home/screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  String _email = "";
  String _password = "";
  bool _isValid = false;

  Future signIn() async {
    // loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    bool result = await AuthRepositoryImpl.instance
        .loginUser(_emailCon.text, _passwordCon.text);
    if (result) {
      Navigator.of(context).pop();
      AppNavigator.pushAndRemove(
        context,
        const HomeScreen(),
      );
    } else {
      Navigator.of(context).pop();
      showLoginErrorDialog(context, "Tên đăng nhập hoặc mật khẩu không đúng");
    }
  }

  void showLoginErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Đăng nhập thất bại"),
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
  void dispose() {
    _emailCon.dispose();
    _passwordCon.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isValid = _email.isNotEmpty && _password.length >= 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: 100.h, right: 16.w, left: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Sign In',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
            ),
            SizedBox(height: 30.h),
            _emailField(),
            SizedBox(height: 20.h),
            _passwordField(),
            SizedBox(height: 60.h),
            _signinButton(),
          ],
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailCon,
      decoration: const InputDecoration(
        hintText: 'UserName',
        errorText: null,
      ),
      onChanged: (value) {
        setState(() {
          _email = value;
          _validateForm();
        });
      },
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _passwordCon,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        errorText: (_password.isEmpty || _password.length >= 6)
            ? null
            : "Password must be at least 6 characters",
      ),
      onChanged: (value) {
        setState(() {
          _password = value;
          _validateForm();
        });
      },
    );
  }

  Widget _signinButton() {
    return ElevatedButton(
      onPressed: _isValid
          ? () async {
              await signIn();
            }
          : null, // Disable button if form is invalid
      child: const Text("Login"),
    );
  }
}
