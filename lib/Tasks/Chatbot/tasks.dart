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
  title: "Chatbot tester day 0",
  id: 'chatbotTester',
  type: TaskType.CHATBOT,
  isCompleted: false,
  day: 0,
  chatbotContent: chatbotTestContent,
);

Task chatbotTester1 = Task(
  title: "Chatbot tester day 1",
  id: 'chatbotTester1',
  type: TaskType.CHATBOT,
  isCompleted: false,
  day: 1,
  chatbotContent: chatbotTestContent,
);

Task day0DietLogTutor = Task(
  title: "饮食日志教学",
  id: 'task2',
  type: TaskType.CHATBOT,
  isCompleted: false,
  day: 0,
  chatbotContent: day0DietLogTutorContent,
);
