import 'package:intl/intl.dart';

class FormatDate {
  static bool isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  static String format(DateTime? date) {
    try {
      final String formatDate = DateFormat('MMMM d, y').format(date!);
      return formatDate;
    } catch (e) {
      return '';
    }
  }

  static String formatDateHeader(DateTime date) {
    final now = DateTime.now();

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Hôm nay';
    } else if (date.year == now.subtract(const Duration(days: 1)).year &&
        date.month == now.subtract(const Duration(days: 1)).month &&
        date.day == now.subtract(const Duration(days: 1)).day) {
      return 'Hôm qua';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}