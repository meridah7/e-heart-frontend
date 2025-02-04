import 'package:namer_app/models/user.dart';
import 'package:namer_app/models/user_progress.dart';
import 'package:namer_app/models/task_models.dart';

// 用于描述服务层的行为
// 用户相关接口
abstract class UserApiService {
  Future<User?> fetchUser(); // 获取用户

  // Future<void> logIn(); // 登录
  Future<void> logOut(); // 登出
}

// 用户进度相关接口
abstract class ProgressApiService {
  Future<UserProgress?> fetchProgress(); // 获取用户进度

  Future<UserProgress?> updateProgress(String taskId); // 更新用户进度

  Future<UserProgress?> setProgress(int progress); // 设置用户进度 仅调试使用

  Future<List<Task>> fetchImpulseReflectionRecords(); // 获取冲动记录回顾
}
