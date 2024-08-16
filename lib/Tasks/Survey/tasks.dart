import '../../TodayList/task_models.dart';
import 'contents.dart';

Task impulseRetrospect = Task(
  title: "x 月 x 日冲动记录回顾",
  id: 'impulseRetrospect',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 0,
  survey: impulseRetrospectSurvey,
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

Task task5 = Task(
  title: "每日饮食计划",
  id: 'task5',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: mealPlanningSurvey,
);

Task task6 = Task(
  title: "冲动记录反思",
  id: 'task6',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: bingeEatingReflectionSurvey,
);

Task reflectiveActivity = Task(
  title: "冲动应对策略制定",
  id: 'task7',
  type: TaskType.SURVEY_FLIPPABLE,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: reflectiveActivitySurvey,
);

Task impulseWave = Task(
  title: "学习冲动冲浪",
  id: 'task8',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: impulseWaveSurvey,
);

Task monitoringTeachingReflection = Task(
  title: "饮食日志反思",
  id: 'task9',
  type: TaskType.SURVEY_FLIPPABLE,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: monitoringTeachingReflectionSurvey,
);

//regularDietReflection
Task regularDietReflection = Task(
  title: "饮食计划反思",
  id: 'task10',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: regularDietReflectionSurvey,
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
