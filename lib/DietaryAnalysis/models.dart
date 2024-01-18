
class BingeEatingEvent {
  String time;
  String description;

  BingeEatingEvent(this.time, this.description);
}

class FoodClearanceEmotionData {
  String time;
  int emotionLevel;

  FoodClearanceEmotionData(this.time, this.emotionLevel);
}

class BingeEatingEmotionData {
  String time; // 时间
  String emotion; // 情绪描述，例如“开心”，“难过”，“焦虑”等

  BingeEatingEmotionData(this.time, this.emotion);
}


class WeeklyData {
  final String dayOfWeek; // 星期几，例如 "周一", "周二" 等
  final int count; // 食物清除次数

  WeeklyData(this.dayOfWeek, this.count);
}


class EatingEmotionData {
  final String dayOfWeek;
  final Map<String, int> emotions;

  EatingEmotionData(this.dayOfWeek, this.emotions);
}
