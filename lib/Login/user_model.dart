// import 'package:flutter/material.dart';
// import 'package:namer_app/services/api_service.dart';
// import 'package:namer_app/utils/helper.dart';

// class User {
//   final String uuid;
//   final int? id; // 用户ID
//   final String name;
//   final String email;
//   double? height; // 身高
//   double? weight; // 体重
//   String? phoneNumber; // 手机号
//   DateTime? birthday; // 生日

//   User({
//     required this.uuid,
//     required this.id,
//     required this.name,
//     required this.email,
//     this.height,
//     this.weight,
//     this.phoneNumber,
//     this.birthday,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//         uuid: json['uuid'],
//         id: json['id'],
//         name: json['name'],
//         email: json['email'],
//         height: Helper.safeParseNumber(json['height']),
//         weight: Helper.safeParseNumber(json['weight']),
//         phoneNumber: json['phone_number'],
//         birthday: Helper.safeParseDateTime(json['birthday']));
//   }
// }

// class UserProvider extends ChangeNotifier {
//   User? _user;

//   User? get user => _user;

//   String? get name => _user?.name;

//   int? get id => _user?.id;

//   String? get email => _user?.email;

//   double get height => _user?.height ?? 0;

//   double get weight => _user?.weight ?? 0;

//   String? get phoneNumber => _user?.phoneNumber;

//   String get uuid => _user?.uuid ?? '';

//   DateTime get birthday => _user?.birthday ?? DateTime(2003, 9, 7);

//   final ApiService apiService;

//   // Future<void> fetchUser() async {
//   //   try {
//   //     _user = await apiService.fetchUser();
//   //   } catch (err) {
//   //     print('Error in parse user props $err');
//   //     throw Exception(err);
//   //   }
//   //   notifyListeners();
//   // }

//   void logOut() async {
//     _user = null;
//     notifyListeners();
//   }

//   void setUser(User newUser) {
//     _user = newUser;
//     notifyListeners();
//   }
// }
