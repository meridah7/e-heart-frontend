import 'package:intl/intl.dart';

class Helper {
  static double? safeParseNumber(dynamic num) {
    if (num == null) return 0;
    return (num is double) ? num : (num is String ? double.tryParse(num) : 0);
  }

  static String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
}
