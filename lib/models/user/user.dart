import 'dart:convert';

import 'data.dart';

class User {
  int? status;
  Data? data;

  User({this.status, this.data});

  @override
  String toString() => 'User(status: $status, data: $data)';

  factory User.fromMap(Map<String, dynamic> data) => User(
        status: data['status'] as int?,
        data: data['data'] == null
            ? null
            : Data.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());
}
