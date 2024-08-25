import '../../TodayList/task_models.dart';
import './contents.dart';

Task dietLogTutor = Task(
  title: "饮食日志教学",
  id: 'M1',
  type: TaskType.CHATBOT,
  isCompleted: false,
  day: 0,
  chatbotContent: dietLogTutorContent,
);

Task impulseSurfingTutor = Task(
  title: "冲动冲浪教学",
  id: 'M2',
  type: TaskType.CHATBOT,
  isCompleted: false,
  day: 1,
  chatbotContent: impulseSurfingTutorContent,
);

Task scheduleDietTutor = Task(
  title: "计划饮食教学",
  id: 'M3',
  type: TaskType.CHATBOT,
  isCompleted: false,
  day: 8,
  chatbotContent: scheduleDietTutorContent,
);
Task dealingWithSetback = Task(
  title: "应对挫折策略",
  id: 'M4',
  type: TaskType.CHATBOT,
  isCompleted: false,
  day: 8,
  chatbotContent: dealingWithSetbackContent,
);

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
