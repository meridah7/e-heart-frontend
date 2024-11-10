// Define the tasks of each day
// Each day has multiple tasks
// Task can be Chatbot or Survey
import '../TodayList/task_models.dart';
import './Chatbot/tasks.dart';
import './Survey/tasks.dart';

List<List<Task>> DailyTask = [
  // ChatbotTest,
  SurveyTest,
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
// TODO: mock task
List<Task> TaskDay0 = [dietLogTutor, ...SurveyTest];
List<Task> TaskDay1 = [impulseSurfingTutor];
List<Task> TaskDay2 = [reflectiveActivity];
List<Task> TaskDay3 = [];
List<Task> TaskDay4 = [];
List<Task> TaskDay5 = [];
List<Task> TaskDay6 = [];
List<Task> TaskDay7 = [];
List<Task> TaskDay8 = [scheduleDietTutor, task5];
List<Task> TaskDay9 = [task5];
List<Task> TaskDay10 = [task5];
List<Task> TaskDay11 = [task5];
List<Task> TaskDay12 = [task5];
List<Task> TaskDay13 = [task5];
List<Task> TaskDay14 = [task5];
List<Task> TaskDay15 = [task5];
List<Task> TaskDay16 = [task5];
List<Task> TaskDay17 = [task5];
List<Task> TaskDay18 = [task5];
List<Task> TaskDay19 = [task5];
List<Task> TaskDay20 = [task5];
List<Task> TaskDay21 = [task5];
List<Task> TaskDay22 = [task5];
List<Task> TaskDay23 = [task5];
List<Task> TaskDay24 = [task5];
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

// NOTE: only for survey test
List<Task> SurveyTest = [
  task5,
  monitoringTeachingReflection,
  vomitRecord,
  // impulseRetrospect,
  dietaryIntake,
  task6,
  reflectiveActivity,
  impulseWave,
  monitoringTeachingReflection,
  regularDietReflection,
];
