import 'package:collection/collection.dart';

class User {
  int? id;
  String? phoneNumber;
  String? uuid;
  String? name;
  String? email;
  String? height;
  String? weight;
  int? age;
  DateTime? birthday;
  int? currentProgress;
  int? expectedProgress;
  dynamic gender;
  DateTime? lastTaskFinishedTime;
  String? lastFinishedTaskId;
  int? progress;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.phoneNumber,
    this.uuid,
    this.name,
    this.email,
    this.height,
    this.weight,
    this.age,
    this.birthday,
    this.currentProgress,
    this.expectedProgress,
    this.gender,
    this.lastTaskFinishedTime,
    this.lastFinishedTaskId,
    this.progress,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        phoneNumber: json['phone_number'] as String?,
        uuid: json['uuid'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        height: json['height'] as String?,
        weight: json['weight'] as String?,
        age: json['age'] as int?,
        birthday: json['birthday'] == null
            ? null
            : DateTime.parse(json['birthday'] as String),
        currentProgress: json['current_progress'] as int?,
        expectedProgress: json['expected_progress'] as int?,
        gender: json['gender'] as dynamic,
        lastTaskFinishedTime: json['lastTaskFinishedTime'] == null
            ? null
            : DateTime.parse(json['lastTaskFinishedTime'] as String),
        lastFinishedTaskId: json['lastFinishedTaskId'] as String?,
        progress: json['progress'] as int?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'phone_number': phoneNumber,
        'uuid': uuid,
        'name': name,
        'email': email,
        'height': height,
        'weight': weight,
        'age': age,
        'birthday': birthday?.toIso8601String(),
        'current_progress': currentProgress,
        'expected_progress': expectedProgress,
        'gender': gender,
        'lastTaskFinishedTime': lastTaskFinishedTime?.toIso8601String(),
        'lastFinishedTaskId': lastFinishedTaskId,
        'progress': progress,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! User) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      phoneNumber.hashCode ^
      uuid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      height.hashCode ^
      weight.hashCode ^
      age.hashCode ^
      birthday.hashCode ^
      currentProgress.hashCode ^
      expectedProgress.hashCode ^
      gender.hashCode ^
      lastTaskFinishedTime.hashCode ^
      lastFinishedTaskId.hashCode ^
      progress.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
