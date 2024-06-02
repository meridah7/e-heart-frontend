//定义了任务的class

import 'package:namer_app/Survey/survey_models.dart';

import '../Chatbot/chat_models.dart';

enum TaskType {
  // 对话机器人
  CHATBOT,
  // 普通问卷
  SURVEY,
  // 可翻页的问卷
  SURVEY_FLIPPABLE,
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
