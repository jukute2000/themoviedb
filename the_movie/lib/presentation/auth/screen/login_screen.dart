import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:the_movie/core/configs/navigation/app_navigation.dart';
import 'package:the_movie/core/utils/sizes_manager.dart';
import 'package:the_movie/core/utils/text_manager.dart';
import 'package:the_movie/data/repositories/auth_repository.dart';
import 'package:the_movie/presentation/home/screen/home_screen.dart';
import 'package:the_movie/presentation/theme/screen/app_style_provider.dart';

import '../../../core/configs/assets/app_colors.dart';

class LoginScreen extends StatefulWidget {
  final bool isUpdate;
  const LoginScreen({super.key, required this.isUpdate});

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
          backgroundColor: AppColors.textWhite,
          title: Text(
            "Đăng nhập thất bại",
            style: TextManager.textStyleBlod(TextSizes.s24)
                .copyWith(color: AppColors.textBlack),
          ),
          content: Text(
            errorMessage,
            style: TextManager.textStyleMedium(TextSizes.s16)
                .copyWith(color: AppColors.textBlack),
          ),
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
              AppStrings.signIn.tr(),
              style: TextManager.textStyleBlod(TextSizes.s32),
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
      decoration: InputDecoration(
        hintText: AppStrings.account.tr(),
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
        hintText: AppStrings.password.tr(),
        errorText: (_password.isEmpty || _password.length >= 6)
            ? null
            : AppStrings.passwordError1.tr(),
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
      child: Text(
        AppStrings.signIn.tr(),
        style: TextManager.textStyleMedium(TextSizes.s16)
            .copyWith(color: AppStyleProvider.of(context).textColor()),
      ),
    );
  }
}
