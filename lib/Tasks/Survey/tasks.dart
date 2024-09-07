import '../../TodayList/task_models.dart';
import 'contents.dart';

Task impulseRetrospect = Task(
  title: "x 月 x 日冲动记录回顾",
  id: 'S1',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 0,
  survey: impulseRetrospectSurvey,
);

Task monitoringTeachingReflection = Task(
  title: "饮食日志反思",
  id: 'S2',
  type: TaskType.SURVEY_FLIPPABLE,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: monitoringTeachingReflectionSurvey,
);
Task task5 = Task(
  title: "每日饮食计划",
  id: 'S3',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: mealPlanningSurvey,
);

//regularDietReflection
Task regularDietReflection = Task(
  title: "饮食计划反思",
  id: 'S4',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: regularDietReflectionSurvey,
);

Task task6 = Task(
  title: "冲动记录反思",
  id: 'S5',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: bingeEatingReflectionSurvey,
);

Task reflectiveActivity = Task(
  title: "冲动应对策略制定",
  id: 'D1',
  type: TaskType.SURVEY_FLIPPABLE,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: reflectiveActivitySurvey,
);

Task task3 = Task(
  title: "改变准备",
  id: 'task3',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 0,
  survey: sampleSurvey,
);

Task dietaryIntake = Task(
  title: "饮食日志",
  id: 'task4',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: dietaryIntakeSurvey,
);

Task impulseWave = Task(
  title: "学习冲动冲浪",
  id: 'task8',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: impulseWaveSurvey,
);

//impulseRecordingSurvey
Task impulseRecording = Task(
  title: "记录冲动",
  id: 'task11',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: impulseRecordingSurvey,
);
