//定义了饮食的class

import 'package:namer_app/Survey/survey_models.dart';

import 'chat_models.dart';

enum DietType {
  FormalMeal,
  NonFormalMeal,
}


class Diet {
  final String food;
  final String id;
  final String type;
  final int day;
  final List<Content>? mealContent;
  final Survey? survey;

  Diet({
    required this.food,
    required this.id,
    required this.type,
    required this.day,
    this.mealContent,
    this.survey,
  });
}
