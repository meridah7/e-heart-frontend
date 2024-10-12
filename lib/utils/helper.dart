import 'package:intl/intl.dart';

class Helper {
  static double? safeParseNumber(dynamic num) {
    if (num == null) return 0;
    return (num is double) ? num : (num is String ? double.tryParse(num) : 0);
  }

  static int? safeParseInt(dynamic num) {
    if (num == null) return 0;
    return (num is int) ? num : (num is String ? int.tryParse(num) : 0);
  }

  static DateTime? safeParseDateTime(dynamic dateTime) {
    if (dateTime == null) return null;
    return DateTime.tryParse(dateTime);
  }

  static String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
}
