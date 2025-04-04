// Define the tasks of each day
// Each day has multiple tasks
// Task can be Chatbot or Survey
import 'package:namer_app/models/task_models.dart';

import 'Chatbot/tasks.dart';
import 'Survey/tasks.dart';

Map<String, Task> taskMap = {
  // Chatbot
  'M1': dietLogTutor,
  'M2': impulseSurfingTutor,
  'M3': scheduleDietTutor,
  'M4': dealingWithSetback,
  // Survey
  'S2': monitoringTeachingReflection,
  'S3': task5,
  'S4': regularDietReflection,
  'S5': task6,
  'D1': reflectiveActivity,
  'X1': x1,
  'X2': x2,
  'X3': x3,
  // 'C1': C1,
};

// 根据任务 ID 列表返回任务对象列表
List<Task> getTasksByIds(List<String> taskIds) {
  return taskIds
      .where((id) => taskMap.containsKey(id)) // 过滤掉不存在的任务 ID
      .map((id) => taskMap[id]!) // 获取对应的任务对象
      .toList();
}
