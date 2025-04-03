import 'package:dio/dio.dart';
import 'package:namer_app/models/user.dart';
import 'package:namer_app/services/api_endpoints.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dio_client.dart';
import 'package:namer_app/user_preference.dart';

part 'user_service.g.dart';

@riverpod
UserService userService(UserServiceRef ref) {
  return UserService();
}

class UserService {
  final DioClient dioClient = DioClient();
  late Preferences _userPref;

  Future<User?> fetchUser() async {
    try {
      Response response = await dioClient.getRequest('/users/current');
      if (response.statusCode == 200) {
        var data = response.data['data'];
        // 每次调用接口更新 preference
        _userPref = await Preferences.getInstance(namespace: data['uuid']);
        print('User preference namespace: ${_userPref.namespace}');
        for (var entry in data.entries) {
          await _userPref.setData(entry.key, entry.value);
        }
        return User.fromJson(data);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  Future<void> logOut() async {
    try {
      Response response = await dioClient.postRequest(ApiEndpoints.LOG_OUT, {});
      if (response.statusCode == 200) {
        // 重置preference
        // 删除token
        await dioClient.clearTokens();
        dioClient.handleRedirectLogin();
      }
    } catch (e) {
      dioClient.handleRedirectLogin();
    }
  }

  Future<bool> updateUser(Map<String, dynamic> data) async {
    try {
      Response response =
          await dioClient.putRequest(ApiEndpoints.PROFILE, data);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Failed to update user $e');
      return false;
    }
  }
}
