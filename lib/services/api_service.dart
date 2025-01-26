import 'package:namer_app/models/user/user.dart';

// 用于描述服务层的行为
abstract class ApiService {
  Future<User?> fetchUser(); // 获取用户
  // Future<void> logIn(); // 登录
  Future<void> logOut(); // 登出
}
