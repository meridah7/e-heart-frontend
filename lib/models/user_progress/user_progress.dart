import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class UserProgress {
  int? status;
  Data? data;

  UserProgress({this.status, this.data});

  @override
  String toString() => 'UserProgress(status: $status, data: $data)';

  factory UserProgress.fromMap(Map<String, dynamic> data) => UserProgress(
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
  /// Parses the string and returns the resulting Json object as [UserProgress].
  factory UserProgress.fromJson(String data) {
    return UserProgress.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserProgress] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserProgress) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}
