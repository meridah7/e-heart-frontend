//定义了任务的class
import 'package:namer_app/models/survey_models.dart';
import 'package:namer_app/models/chat_models.dart';

enum TaskType {
  // 对话机器人
  CHATBOT,
  // 普通问卷
  SURVEY,
  // 可翻页的问卷
  SURVEY_FLIPPABLE,
  // 每日饮食计划页面
  MEAL_PLANNING
}

class Task {
  Task({
    required this.title,
    required this.id,
    required this.type,
    required this.isCompleted,
    required this.day,
    this.chatbotContent,
    this.survey,
  });

  final List<Content>? chatbotContent;
  final int day;
  final String id;
  bool isCompleted;
  final Survey? survey;
  final String title;
  final TaskType type;

  /// 实现 copyWith 方法
  Task copyWith({
    String? title,
    String? id,
    TaskType? type,
    bool? isCompleted,
    int? day,
    List<Content>? chatbotContent,
    Survey? survey,
  }) {
    return Task(
      title: title ?? this.title,
      id: id ?? this.id,
      type: type ?? this.type,
      isCompleted: isCompleted ?? this.isCompleted,
      day: day ?? this.day,
      chatbotContent: chatbotContent ?? this.chatbotContent,
      survey: survey ?? this.survey,
    );
  }
}
