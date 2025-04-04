import 'package:namer_app/services/user_service.dart';
import 'package:namer_app/utils/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user.dart';

part 'user_data.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  late UserService _userService;

  @override
  FutureOr<User?> build() {
    _userService = ref.watch(userServiceProvider);
    return fetchUser();
  }

  Future<User?> fetchUser() async {
    try {
      final user = await _userService.fetchUser();
      state = AsyncData(user);
      return user;
    } catch (err) {
      throw Exception('Error fetching user: $err');
    }
  }

  Future<void> logOut() async {
    state = const AsyncLoading();
    await AsyncValue.guard(() async {
      await _userService.logOut();
      state = const AsyncData(null);
    });
  }

  Future<void> updateUser(Map<String, dynamic> data) async {
    try {
      bool res = await _userService.updateUser(data);
      if (res) {
        await fetchUser();
      } else {
        ToastUtils.showToast('更新用户信息失败');
      }
    } catch (e) {
      print("Error in update user");
    }
  }
}
