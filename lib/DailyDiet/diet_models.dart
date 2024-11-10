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
  Diet? planedDiet;
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
    this.planedDiet,
    this.mealContent,
    this.survey,
    this.guzzleLevel,
  });

  String getStatusText() {
    switch (status) {
      case DietStatus.checked:
        return '已完成';
      case DietStatus.pending:
        return '';
      case DietStatus.modified:
        return '已变更';
      default:
        return '';
    }
  }
}
