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

  List<Task> displayTaskList = [];

  int? get progress => _userProgress?.progress ?? 0;
  List<String> get finishedTaskIds => _userProgress?.finishedTaskIds ?? [];
  List<String> get allRequiredTaskIds =>
      _userProgress?.allRequiredTaskIds ?? [];
  List<String> get allOptionalTaskIds =>
      _userProgress?.allOptionalTaskIds ?? [];

  Future<void> fetchProgress() async {
    try {
      _userProgress = await apiService.fetchProgress();
    } catch (err) {
      print('Error in parse user progress $err');
      throw Exception(err);
    }
    notifyListeners();
  }

  Future<void> updateProgress(String taskId) async {
    try {
      _userProgress = await apiService.updateProgress(taskId);
      await fetchProgress();
    } catch (err) {
      print('Error in parse user progress $err');
      throw Exception(err);
    }
    notifyListeners();
  }

  Future<void> setProgress(int progress) async {
    try {
      _userProgress = await apiService.setProgress(progress);
    } catch (err) {
      print('Error in parse user progress $err');
      throw Exception(err);
    }
    notifyListeners();
  }

  Future<List<Task>> fetchDisplayTaskList() async {
    try {
      if (_userProgress == null) {
        await fetchProgress();
      }
      List<Task> impulseRecordTaskList =
          await apiService.fetchImpulseReflectionRecords();
      // 聚合所有任务 并给完成的任务打上标记
      List<String> displayTaskIds = [
        ...allRequiredTaskIds,
        ...allOptionalTaskIds,
      ];
      // 已完成的任务
      List<Task> displayTasks = getTasksByIds(displayTaskIds)
          .map((e) => e.copyWith(isCompleted: finishedTaskIds.contains(e.id)))
          .toList();
      // FIXME: 临时替换mock 数据
      displayTaskList = displayTasks;
      // displayTaskList = [taskMap['S2']!];
      displayTaskList.addAll(impulseRecordTaskList);
      return displayTasks;
    } catch (err) {
      print('Error in fetch display task list $err');
      // FIXME: 临时替换mock 数据
      // return [taskMap['S2']!];
      throw Exception(err);
    }
  }

  // 更新用户进度输入值并通知监听者
  void updateInputValue(String value) {
    _inputValue = value;
    setProgress(int.parse(value));
  }
}
