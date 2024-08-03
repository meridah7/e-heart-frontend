enum DetailScene { edit, add, check }

class ResponseCardModel {
  final String custom_activity;
  final String details;
  final int activity_order;

  ResponseCardModel(
      {required this.custom_activity,
      required this.details,
      required this.activity_order});

  // 添加 fromJson 工厂构造函数
  factory ResponseCardModel.fromJson(Map<String, dynamic> json) {
    return ResponseCardModel(
      activity_order: json['activity_order'] as int,
      custom_activity: json['custom_activity'] as String,
      details: json['details'] as String,
    );
  }

  // 可选：添加 toJson 方法，用于将对象转换回 JSON
  Map<String, dynamic> toJson() {
    return {
      'activity_order': activity_order,
      'custom_activity': custom_activity,
      'details': details,
    };
  }
}
