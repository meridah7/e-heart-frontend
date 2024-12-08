//定义了饮食的class

import 'package:namer_app/Survey/survey_models.dart';
import 'package:namer_app/Survey/utils.dart';
import '../Chatbot/chat_models.dart';

enum DietType {
  FormalMeal,
  NonFormalMeal,
}

class Diet {
  final int id;
  final int eatingTime;
  final String foodDetails;
  final Survey? survey;
  MealType? mealType;
  Diet? planedDiet;
  int emotionIntensity;
  bool? isDieting;
  bool? isBingeEating;

  Diet({
    required this.id,
    required this.eatingTime,
    required this.emotionIntensity,
    this.mealType,
    this.planedDiet,
    required this.foodDetails,
    this.survey,
  });

  factory Diet.fromJson(Map<String, dynamic> json) {
    try {
      return Diet(
        id: json['id'] as int,
        eatingTime: json['eating_time'] as int,
        emotionIntensity: json['emotion_intensity'] as int,
        foodDetails: json['food_details'] != null
            ? (json['food_details'] as String)
                .trim()
                .replaceAll('[', '')
                .replaceAll(']', '')
            : '未填写',
        planedDiet: json['planed_diet'] != null
            ? Diet.fromJson(json['planed_diet'])
            : null,
      )
        ..isDieting = json['is_dieting'] as bool?
        ..isBingeEating = json['is_binge_eating'] as bool?
        ..mealType = json['meal_type'] != null
            ? MealType.fromEnglish(json['meal_type'])
            : null;
    } catch (e) {
      print('Error in Diet.fromJson: $e');
      throw Exception(e);
    }
  }

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
