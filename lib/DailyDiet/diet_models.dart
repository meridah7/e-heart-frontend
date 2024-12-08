//定义了饮食的class

import 'package:namer_app/Survey/survey_models.dart';

import '../Chatbot/chat_models.dart';

enum DietType {
  FormalMeal,
  NonFormalMeal,
}

class Diet {
  final String food;
  final String id;
  final String type;
  final int day;
  final int createTime;
  final List<Content>? mealContent;
  final Survey? survey;
  Diet? planedDiet;
  int? guzzleLevel;
  int? dietTime;

  Diet({
    required this.food,
    required this.id,
    required this.type,
    required this.day,
    required this.createTime,
    this.planedDiet,
    this.mealContent,
    this.survey,
    this.guzzleLevel,
  });

  // String getStatusText() {
  //   switch (status) {
  //     case DietStatus.checked:
  //       return '已完成';
  //     case DietStatus.pending:
  //       return '';
  //     case DietStatus.modified:
  //       return '已变更';
  //     default:
  //       return '';
  //   }
  // }
}

class MealPlan {
  final int id;
  final int userId;
  final String type;
  final String foodDetails;
  final String time;
  final int date;
  final int targetDate;
  final bool state;
  final DateTime createdAt;
  final DateTime updatedAt;

  MealPlan({
    required this.id,
    required this.userId,
    required this.type,
    required this.foodDetails,
    required this.time,
    required this.date,
    required this.targetDate,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return MealPlan(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      type: json['type'] as String,
      foodDetails: json['food_details'] as String,
      time: json['time'] as String,
      date: json['date'] as int,
      targetDate: json['target_date'] as int,
      state: json['state'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
