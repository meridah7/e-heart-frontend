// Define the tasks of each day
// Each day has multiple tasks
// Task can be Chatbot or Survey
import '../TodayList/task_models.dart';
import './Chatbot/tasks.dart';
import './Survey/tasks.dart';

List<List<Task>> DailyTask = [
  // ChatbotTest,
  TaskDay0,
  TaskDay1,
  TaskDay2,
  TaskDay3,
  TaskDay4,
  TaskDay5,
  TaskDay6,
  TaskDay7,
  TaskDay8,
  TaskDay9,
  TaskDay10,
  TaskDay11,
  TaskDay12,
  TaskDay13,
  TaskDay14,
  TaskDay15,
  TaskDay16,
  TaskDay17,
  TaskDay18,
  TaskDay19,
  TaskDay20,
  TaskDay21,
  TaskDay22,
  TaskDay23,
  TaskDay24,
  TaskDay25
];

List<Task> TaskDay0 = [dietLogTutor];
List<Task> TaskDay1 = [impulseSurfingTutor];
List<Task> TaskDay2 = [];
List<Task> TaskDay3 = [];
List<Task> TaskDay4 = [];
List<Task> TaskDay5 = [];
List<Task> TaskDay6 = [];
List<Task> TaskDay7 = [];
List<Task> TaskDay8 = [scheduleDietTutor];
List<Task> TaskDay9 = [];
List<Task> TaskDay10 = [];
List<Task> TaskDay11 = [];
List<Task> TaskDay12 = [];
List<Task> TaskDay13 = [];
List<Task> TaskDay14 = [];
List<Task> TaskDay15 = [];
List<Task> TaskDay16 = [];
List<Task> TaskDay17 = [];
List<Task> TaskDay18 = [];
List<Task> TaskDay19 = [];
List<Task> TaskDay20 = [];
List<Task> TaskDay21 = [];
List<Task> TaskDay22 = [];
List<Task> TaskDay23 = [];
List<Task> TaskDay24 = [];
List<Task> TaskDay25 = [dealingWithSetback];

// NOTE: only for test
List<Task> Test = [chatbotTester, chatbotTester1];

// NOTE: only for chatbot test
List<Task> ChatbotTest = [
  dietLogTutor,
  impulseSurfingTutor,
  scheduleDietTutor,
  dealingWithSetback
];
