class Helper {
  static int? safeParseInt(dynamic num) {
    if (num == null) return 0;
    return (num is int) ? num : (num is String ? int.tryParse(num) : 0);
  }
}
