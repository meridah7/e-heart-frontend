import '../DAO/database_helper.dart';

class User {
  final int id;
  final String name;
  final int age;

  User({required this.id, required this.name, required this.age});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      age: map['age'],
    );
  }
}

Future<User> getUserInfo() async {
  var dbHelper = await DatabaseHelper.createInstance();
  final List<Map<String, Object?>> users = await dbHelper.getUsers(); // 假设这个函数返回第一个用户
  if (users.isNotEmpty) {
    return User.fromMap(users.first);
  } else {
    throw Exception('No User Found');
  }
}
