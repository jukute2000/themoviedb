class SafeNull {
  static String? checkString(String? text) {
    if (text != null && text.trim().isNotEmpty) {
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
      } else if (ex is int) {
        return DateTime.fromMillisecondsSinceEpoch(ex);
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
        String lowerEx = ex.trim().toLowerCase();
        if (lowerEx == "true") return true;
        if (lowerEx == "false") return false;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
