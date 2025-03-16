import 'package:dio/dio.dart';
import 'package:namer_app/models/user.dart';
import 'package:namer_app/services/api_service.dart';
import 'dio_client.dart';
import 'package:namer_app/user_preference.dart';

class UserService implements UserApiService {
  final DioClient dioClient = DioClient();
  late Preferences _userPref;

  @override
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

  @override
  Future<void> logOut() async {
    try {
      Response response = await dioClient.postRequest('/auth/logout', {});
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
}
