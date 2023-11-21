//定义了饮食的class

import 'package:namer_app/survey_models.dart';

import 'chat_models.dart';

enum DietType {
  FormalMeal,
  NonFormalMeal,
}


class Diet {
  final String id;
  final DietType type;
  final int day;
  final List<Content>? mealContent;
  final Survey? survey;

  Diet({
    required this.id,
    required this.type,
    required this.day,
    this.mealContent,
    this.survey,
  });
}
