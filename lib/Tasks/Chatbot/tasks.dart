import '../../TodayList/task_models.dart';
import './contents.dart';

Task task1 = Task(
  title: "Understanding Binge Eating",
  id: 'task1',
  type: TaskType.CHATBOT,
  isCompleted: false,
  day: 0,
  chatbotContent: chatbotContent2,
);

Task chatbotTester = Task(
  title: "Chatbot tester",
  id: 'chatbotTester',
  type: TaskType.CHATBOT,
  isCompleted: false,
  day: 0,
  chatbotContent: chatbotTestContent,
);

Task task2 = Task(
  title: "饮食日志教学",
  id: 'task2',
  type: TaskType.CHATBOT,
  isCompleted: false,
  day: 0,
  chatbotContent: chatbotContentCustom,
);
