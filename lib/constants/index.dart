// 维护餐食类型枚举
enum MealType {
  breakfast('早餐', 'Breakfast'),
  morningSnack('上午点心', 'Morning Snack'),
  lunch('午餐', 'Lunch'),
  afternoonSnack('下午点心', 'Afternoon Snack'),
  dinner('晚餐', 'Dinner'),
  nightSnack('夜宵', 'Night Snacks'),
  other('其他', 'Other'),
  beverages('饮料', 'Beverages');

  final String chinese;
  final String english;
  const MealType(this.chinese, this.english);

  static MealType? fromChinese(String chinese) {
    return MealType.values.firstWhere(
      (type) => type.chinese == chinese,
      orElse: () => MealType.other,
    );
  }

  static MealType fromEnglish(String english) {
    return MealType.values.firstWhere(
      (type) => type.english == english,
      orElse: () => MealType.other,
    );
  }

  String get name => english;
  String get displayName => chinese;
}
