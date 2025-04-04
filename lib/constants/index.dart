// 维护餐食类型枚举
// ignore_for_file: constant_identifier_names

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

// 需要接口生成的问卷TaskId
class SurveyTask {
  static const List<String> NEED_GENERATED_TASK_IDS = ['S4', 'S5'];
  // 需要展示总结页面的任务id
  static const List<String> SUMMARY_TASK_IDS = ['S3', 'S4', 'S5', 'D1'];
}
