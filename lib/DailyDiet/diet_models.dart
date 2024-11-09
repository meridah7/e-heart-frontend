//定义了饮食的class

import 'package:namer_app/Survey/survey_models.dart';

import '../Chatbot/chat_models.dart';

enum DietType {
  FormalMeal,
  NonFormalMeal,
}

enum DietStatus { checked, pending, modified }

class Diet {
  final String food;
  final String id;
  final String type;
  final int day;
  final int createTime;
  final List<Content>? mealContent;
  final Survey? survey;
  List<Diet>? dietLog;
  DietStatus status = DietStatus.pending;
  int? guzzleLevel;
  int? dietTime;

  Diet({
    required this.food,
    required this.id,
    required this.type,
    required this.day,
    required this.createTime,
    required this.status,
    this.dietLog,
    this.mealContent,
    this.survey,
    this.guzzleLevel,
  });
}
