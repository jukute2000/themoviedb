import 'package:intl/intl.dart';

class FormatDate {
  static String format(DateTime? date) {
    try {
      final String formatDate = DateFormat('MMMM d, y').format(date!);
      return formatDate;
    } catch (e) {
      return '';
    }
  }
}