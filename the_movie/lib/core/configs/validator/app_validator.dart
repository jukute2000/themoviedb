class AppValidator {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email không được để trống';
    } else if (!_isValidEmail(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'Tên không được để trống';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Mật khẩu không được để trống';
    } else if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    return null;
  }

  static bool _isValidEmail(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }
}
