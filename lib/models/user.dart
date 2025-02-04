import 'package:json_annotation/json_annotation.dart';
import 'package:namer_app/utils/converter.dart';
import 'package:collection/collection.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  User(
      {this.id,
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
      this.phoneNumber});

  // 自动生成的方法
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  int? age;
  DateTime? birthday;
  DateTime? createdAt;
  int? currentProgress;
  String? email;
  int? expectedProgress;
  dynamic gender;
  @StringToDoubleConverter()
  double? height;
  @StringToDoubleConverter()
  double? weight;
  int? id;
  String? lastFinishedTaskId;
  DateTime? lastTaskFinishedTime;
  String? name;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;
  int? progress;
  DateTime? updatedAt;
  String? uuid;

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

  @override
  String toString() {
    return 'User(id: $id, phoneNumber: $phoneNumber, uuid: $uuid, name: $name, email: $email, height: $height, weight: $weight, age: $age, birthday: $birthday, currentProgress: $currentProgress, expectedProgress: $expectedProgress, gender: $gender, lastTaskFinishedTime: $lastTaskFinishedTime, lastFinishedTaskId: $lastFinishedTaskId, progress: $progress, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
