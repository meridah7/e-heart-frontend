import 'dart:convert';

class Data {
  int? id;
  String? phoneNumber;
  String? uuid;
  String? name;
  String? email;
  double? height;
  double? weight;
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

  Data({
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

  @override
  String toString() {
    return 'Data(id: $id, phoneNumber: $phoneNumber, uuid: $uuid, name: $name, email: $email, height: $height, weight: $weight, age: $age, birthday: $birthday, currentProgress: $currentProgress, expectedProgress: $expectedProgress, gender: $gender, lastTaskFinishedTime: $lastTaskFinishedTime, lastFinishedTaskId: $lastFinishedTaskId, progress: $progress, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        id: data['id'] as int?,
        phoneNumber: data['phone_number'] as String?,
        uuid: data['uuid'] as String?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        height: data['height'] as double?,
        weight: data['weight'] as double?,
        age: data['age'] as int?,
        birthday: data['birthday'] == null
            ? null
            : DateTime.parse(data['birthday'] as String),
        currentProgress: data['current_progress'] as int?,
        expectedProgress: data['expected_progress'] as int?,
        gender: data['gender'] as dynamic,
        lastTaskFinishedTime: data['lastTaskFinishedTime'] == null
            ? null
            : DateTime.parse(data['lastTaskFinishedTime'] as String),
        lastFinishedTaskId: data['lastFinishedTaskId'] as String?,
        progress: data['progress'] as int?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
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

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());
}
