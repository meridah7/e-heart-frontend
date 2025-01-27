import 'package:dio/dio.dart';
import 'dio_client.dart';
import 'package:namer_app/models/user_progress.dart';
import 'package:namer_app/services/api_service.dart';
import 'package:namer_app/user_preference.dart';

class ProgressService implements ProgressApiService {
  late Preferences _userPref;
  final DioClient dioClient = DioClient();

  @override
  Future<UserProgress?> fetchProgress() async {
    try {
      Response response = await dioClient.getRequest('/users/progress');
      if (response.statusCode == 200) {
        return UserProgress.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  @override
  Future<UserProgress?> updateProgress(String taskId) async {
    try {
      Response response = await dioClient.postRequest('/users/task', {
        'task_id': taskId,
      });
      if (response.statusCode == 200) {
        return UserProgress.fromJson(response.data);
      } else {
        throw Exception('Failed to update user task');
      }
    } catch (e) {
      print('Error updating user task: $e');
      throw Exception(e);
    }
  }

  @override
  Future<UserProgress?> setProgress(int progress) async {
    try {
      Response response = await dioClient.postRequest('/users/progress', {
        'progress': progress,
      });
      if (response.statusCode == 200) {
        return UserProgress.fromJson(response.data);
      } else {
        throw Exception('Failed to update user task');
      }
    } catch (e) {
      print('Error updating user task: $e');
      throw Exception(e);
    }
  }
}
