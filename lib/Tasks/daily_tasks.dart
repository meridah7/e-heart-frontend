// Define the tasks of each day
// Each day has multiple tasks
// Task can be Chatbot or Survey
import '../TodayList/task_models.dart';
import './Chatbot/tasks.dart';
import './Survey/tasks.dart';

List<List<Task>> DailyTask = [TaskDay0];

List<Task> TaskDay0 = [
  impulseRetrospect,
  chatbotTester,
  // task1,
  day0DietLogTutor,
  task5,
  task6,
  reflectiveActivity,
  impulseWave,
  monitoringTeachingReflection,
  regularDietReflection
];
