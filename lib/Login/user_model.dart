import 'package:flutter/material.dart';
import 'package:namer_app/utils/api_service.dart';
import 'package:namer_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/user_preference.dart';

class User {
  final String uuid;
  final int? id; // 用户ID
  final String name;
  final String email;
  double? height; // 身高
  double? weight; // 体重
  String? phoneNumber; // 手机号
  DateTime? birthday; // 生日

  User({
    required this.uuid,
    required this.id,
    required this.name,
    required this.email,
    this.height,
    this.weight,
    this.phoneNumber,
    this.birthday,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['uuid'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      height: Helper.safeParseNumber(json['height']),
      weight: Helper.safeParseNumber(json['weight']),
      phoneNumber: json['phone_number'],
      // TODO 生日解析
      // birthday: DateTime.tryParse(json['birthday']),
    );
  }
}

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  String? get name => _user?.name;

  int? get id => _user?.id;

  String? get email => _user?.email;

  double? get height => _user?.height;

  double? get weight => _user?.weight;

  String? get phoneNumber => _user?.phoneNumber;

  String get uuid => _user?.uuid ?? '';

  DateTime? get birthday => _user?.birthday;

  final ApiService apiService = ApiService();

  Future<void> fetchUser() async {
    try {
      _user = await apiService.fetchUser();
    } catch (err) {
      print('Error in parse user props $err');
      throw Exception(err);
    }
    notifyListeners();
  }

  void logOut() async {
    _user = null;
    notifyListeners();
  }

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  void setUserFromSavedData(String uuid, int id, String name, String email,
      {double? height,
      double? weight,
      String? phoneNumber,
      DateTime? birthday}) {
    _user = User(
      uuid: uuid,
      id: id,
      name: name,
      email: email,
      height: height,
      weight: weight,
      phoneNumber: phoneNumber,
      birthday: birthday,
    );
    notifyListeners();
  }
}
