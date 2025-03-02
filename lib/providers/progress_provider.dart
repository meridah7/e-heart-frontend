import 'package:flutter/material.dart';
import 'package:namer_app/models/user_progress.dart';
import 'package:namer_app/models/task_models.dart';
import 'package:namer_app/services/api_service.dart';
import 'package:namer_app/tasks/daily_tasks.dart';

class ProgressProvider with ChangeNotifier {
  String? _inputValue;

  String? get inputValue => _inputValue;

  final ProgressApiService apiService;
  UserProgress? _userProgress;

  ProgressProvider({required this.apiService});

  UserProgress? get userProgress => _userProgress;

  int get progress => _userProgress?.progress ?? 0;
  List<String> get finishedTaskIds => _userProgress?.finishedTaskIds ?? [];
  List<String> get finishedOptionalTaskIds =>
      _userProgress?.finishedOptionalTaskIds ?? [];

  List<String> get allRequiredTaskIds =>
      _userProgress?.allRequiredTaskIds ?? [];
  List<String> get allOptionalTaskIds =>
      _userProgress?.allOptionalTaskIds ?? [];

  List<Task> dailyTaskList = [];

  List<Task> optionalTaskList = [];

  Future<void> fetchProgress() async {
    try {
      _userProgress = await apiService.fetchProgress();
    } catch (err) {
      print('Error in parse user progress $err');
      throw Exception(err);
    }
    notifyListeners();
  }

  Future<void> updateProgress(String taskId, {bool isRequired = true}) async {
    try {
      _userProgress =
          await apiService.updateProgress(taskId, isRequired: isRequired);
      await fetchProgress();
      fetchDisplayTaskList();
    } catch (err) {
      print('Error in parse user progress $err');
      throw Exception(err);
    }
    notifyListeners();
  }

  Future<void> setProgress(int progress) async {
    try {
      _userProgress = await apiService.setProgress(progress);
      await fetchProgress();
      fetchDisplayTaskList();
    } catch (err) {
      print('Error in parse user progress $err');
      throw Exception(err);
    }
    notifyListeners();
  }

  Future<void> fetchDisplayTaskList() async {
    try {
      if (_userProgress == null) {
        await fetchProgress();
      }
      List<Task> impulseRecordTaskList =
          await apiService.fetchImpulseReflectionRecords();
      // 聚合所有任务 并给完成的任务打上标记
      // 已完成的任务
      List<Task> requiredTasks = getTasksByIds(allRequiredTaskIds)
          .map((e) => e.copyWith(isCompleted: finishedTaskIds.contains(e.id)))
          .toList();
      List<Task> optionalTasks = getTasksByIds(allOptionalTaskIds)
          .map((e) =>
              e.copyWith(isCompleted: finishedOptionalTaskIds.contains(e.id)))
          .toList();
      optionalTaskList = optionalTasks;
      dailyTaskList = requiredTasks;
      dailyTaskList.addAll(impulseRecordTaskList);
    } catch (err) {
      print('Error in fetch display task list $err');
      throw Exception(err);
    }
    notifyListeners();
  }

  // 更新用户进度输入值并通知监听者
  void updateInputValue(String value) {
    _inputValue = value;
    setProgress(int.parse(value));
  }
}
