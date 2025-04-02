class SafeNull {
  static String? checkString(String? text) {
    if (text != null && text.trim().isNotEmpty) {
      return text;
    }
    return null;
  }

  static int checkInt(dynamic ex) {
    try {
      if (ex is int) {
        return ex;
      } else if (ex is String) {
        return int.tryParse(ex) ?? 0;
      }
      return -1;
    } catch (e) {
      return -1;
    }
  }

  static double checkDouble(dynamic ex) {
    try {
      if (ex is double) {
        return ex;
      } else if (ex is String) {
        return double.tryParse(ex) ?? 0.0;
      }
      return -1.0;
    } catch (e) {
      return -1.0;
    }
  }

  static DateTime? checkDateTime(dynamic ex) {
    try {
      if (ex is String && ex.isNotEmpty) {
        return DateTime.parse(ex);
      } else if (ex is DateTime) {
        return ex;
      } else if (ex is int) {
        // Kiểm tra nếu giá trị quá lớn thì dùng microseconds, nếu không thì milliseconds
        return ex > 9999999999
            ? DateTime.fromMicrosecondsSinceEpoch(ex)
            : DateTime.fromMillisecondsSinceEpoch(ex);
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
        String lowerEx = ex.trim().toLowerCase();
        if (lowerEx == "true") return true;
        if (lowerEx == "false") return false;
      }
      return false;
    } catch (e) {
      return false; // Tránh lỗi nếu có ngoại lệ
    }
  }
}
