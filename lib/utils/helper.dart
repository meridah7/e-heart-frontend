class Helper {
  static double? safeParseNumber(dynamic num) {
    if (num == null) return 0;
    return (num is double) ? num : (num is String ? double.tryParse(num) : 0);
  }
}
