class SafeNull {
  static String checkString(dynamic text) {
    try {
      if (text != null && text is String && text.isNotEmpty) {
        return text;
      }
      return ""; // Trả về chuỗi rỗng thay vì null
    } catch (e) {
      return ""; // Nếu có lỗi, trả về chuỗi rỗng
    }
  }

  static int checkInt(dynamic ex) {
    try {
      if (ex is int) {
        return ex;
      } else if (ex is String) {
        return int.tryParse(ex) ?? 0;
      }
      return 0; // Giá trị mặc định nếu không parse được
    } catch (e) {
      return 0; // Tránh lỗi nếu có ngoại lệ
    }
  }

  static double checkDouble(dynamic ex) {
    try {
      if (ex is double) {
        return ex;
      } else if (ex is String) {
        return double.tryParse(ex) ?? 0.0;
      }
      return 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  static DateTime? checkDateTime(dynamic ex) {
    try {
      if (ex is String && ex.isNotEmpty) {
        return DateTime.parse(ex);
      } else if (ex is DateTime) {
        return ex;
      }
      return null;
    } catch (e) {
      return null; // Trả về null nếu có lỗi khi parse DateTime
    }
  }

  static bool checkBool(dynamic ex) {
    try {
      if (ex is bool) {
        return ex;
      } else if (ex is String) {
        return ex.toLowerCase() == 'true'; // Chuyển đổi chuỗi thành boolean
      }
      return false;
    } catch (e) {
      return false; // Tránh lỗi nếu có ngoại lệ
    }
  }
}