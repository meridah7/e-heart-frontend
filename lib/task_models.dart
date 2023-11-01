//定义了任务的class

import 'package:namer_app/survey_models.dart';

import 'chat_models.dart';

enum TaskType {
  CHATBOT,
  SURVEY,
}


class Task {
  final String id;
  final TaskType type;
   bool isCompleted;
  final int day;
  final List<Content>? chatbotContent;
  final Survey? survey;

  Task({
    required this.id,
    required this.type,
    required this.isCompleted,
    required this.day,
    this.chatbotContent,
    this.survey,
  });
}
