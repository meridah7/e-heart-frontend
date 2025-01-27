import 'package:flutter/material.dart';
import 'package:namer_app/models/user_progress.dart';
import 'package:namer_app/services/api_service.dart';

class ProgressProvider with ChangeNotifier {
  final ProgressApiService apiService;
  UserProgress? _userProgress;

  ProgressProvider({required this.apiService});

  UserProgress? get userProgress => _userProgress;

  int? get progress => _userProgress?.progress;
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
}
