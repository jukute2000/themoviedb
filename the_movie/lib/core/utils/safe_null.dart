class SafeNull {
  static String? checkString(String text) {
    if (text.isNotEmpty && text != "") {
      return text;
    }
    return null;
  }

  static int? checkInt(dynamic ex) {
    try {
      if (ex is int) {
        return ex;
      } else if (ex is String) {
        return int.tryParse(ex);
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  static double? checkDouble(dynamic ex) {
    try {
      if (ex is double) {
        return ex;
      } else if (ex is String) {
        return double.tryParse(ex);
      }
      return 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  static DateTime? checkDateTime(dynamic ex) {
    try {
      if (ex != null && ex is String) {
        return DateTime.parse(ex);
      } else if (ex is DateTime) {
        return ex;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static bool? checkBool(dynamic ex) {
    try {
      if (ex is bool) {
        return ex;
      } else if (ex is String) {
        return bool.tryParse(ex);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
