//定义了任务的class

import 'package:namer_app/Survey/survey_models.dart';

import '../Chatbot/chat_models.dart';

enum TaskType {
  CHATBOT,
  SURVEY,
}


class Task {
  final String title;
  final String id;
  final TaskType type;
  bool isCompleted;
  final int day;
  final List<Content>? chatbotContent;
  final Survey? survey;

  Task({
    required this.title,
    required this.id,
    required this.type,
    required this.isCompleted,
    required this.day,
    this.chatbotContent,
    this.survey,
  });
}
