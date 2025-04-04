// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  int? get id => throw _privateConstructorUsedError;
  String? get uuid => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @StringToDoubleConverter()
  double? get height => throw _privateConstructorUsedError;
  @StringToDoubleConverter()
  double? get weight => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  DateTime? get birthday => throw _privateConstructorUsedError;
  int? get currentProgress => throw _privateConstructorUsedError;
  int? get expectedProgress => throw _privateConstructorUsedError;
  dynamic get gender => throw _privateConstructorUsedError;
  DateTime? get lastTaskFinishedTime => throw _privateConstructorUsedError;
  String? get lastFinishedTaskId => throw _privateConstructorUsedError;
  int? get progress => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_number')
  String? get phoneNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {int? id,
      String? uuid,
      String? name,
      String? email,
      @StringToDoubleConverter() double? height,
      @StringToDoubleConverter() double? weight,
      int? age,
      DateTime? birthday,
      int? currentProgress,
      int? expectedProgress,
      dynamic gender,
      DateTime? lastTaskFinishedTime,
      String? lastFinishedTaskId,
      int? progress,
      DateTime? createdAt,
      DateTime? updatedAt,
      @JsonKey(name: 'phone_number') String? phoneNumber});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? height = freezed,
    Object? weight = freezed,
    Object? age = freezed,
    Object? birthday = freezed,
    Object? currentProgress = freezed,
    Object? expectedProgress = freezed,
    Object? gender = freezed,
    Object? lastTaskFinishedTime = freezed,
    Object? lastFinishedTaskId = freezed,
    Object? progress = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentProgress: freezed == currentProgress
          ? _value.currentProgress
          : currentProgress // ignore: cast_nullable_to_non_nullable
              as int?,
      expectedProgress: freezed == expectedProgress
          ? _value.expectedProgress
          : expectedProgress // ignore: cast_nullable_to_non_nullable
              as int?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as dynamic,
      lastTaskFinishedTime: freezed == lastTaskFinishedTime
          ? _value.lastTaskFinishedTime
          : lastTaskFinishedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastFinishedTaskId: freezed == lastFinishedTaskId
          ? _value.lastFinishedTaskId
          : lastFinishedTaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? uuid,
      String? name,
      String? email,
      @StringToDoubleConverter() double? height,
      @StringToDoubleConverter() double? weight,
      int? age,
      DateTime? birthday,
      int? currentProgress,
      int? expectedProgress,
      dynamic gender,
      DateTime? lastTaskFinishedTime,
      String? lastFinishedTaskId,
      int? progress,
      DateTime? createdAt,
      DateTime? updatedAt,
      @JsonKey(name: 'phone_number') String? phoneNumber});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? height = freezed,
    Object? weight = freezed,
    Object? age = freezed,
    Object? birthday = freezed,
    Object? currentProgress = freezed,
    Object? expectedProgress = freezed,
    Object? gender = freezed,
    Object? lastTaskFinishedTime = freezed,
    Object? lastFinishedTaskId = freezed,
    Object? progress = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(_$UserImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentProgress: freezed == currentProgress
          ? _value.currentProgress
          : currentProgress // ignore: cast_nullable_to_non_nullable
              as int?,
      expectedProgress: freezed == expectedProgress
          ? _value.expectedProgress
          : expectedProgress // ignore: cast_nullable_to_non_nullable
              as int?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as dynamic,
      lastTaskFinishedTime: freezed == lastTaskFinishedTime
          ? _value.lastTaskFinishedTime
          : lastTaskFinishedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastFinishedTaskId: freezed == lastFinishedTaskId
          ? _value.lastFinishedTaskId
          : lastFinishedTaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {this.id,
      this.uuid,
      this.name,
      this.email,
      @StringToDoubleConverter() this.height,
      @StringToDoubleConverter() this.weight,
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
      @JsonKey(name: 'phone_number') this.phoneNumber});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final int? id;
  @override
  final String? uuid;
  @override
  final String? name;
  @override
  final String? email;
  @override
  @StringToDoubleConverter()
  final double? height;
  @override
  @StringToDoubleConverter()
  final double? weight;
  @override
  final int? age;
  @override
  final DateTime? birthday;
  @override
  final int? currentProgress;
  @override
  final int? expectedProgress;
  @override
  final dynamic gender;
  @override
  final DateTime? lastTaskFinishedTime;
  @override
  final String? lastFinishedTaskId;
  @override
  final int? progress;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @override
  String toString() {
    return 'User(id: $id, uuid: $uuid, name: $name, email: $email, height: $height, weight: $weight, age: $age, birthday: $birthday, currentProgress: $currentProgress, expectedProgress: $expectedProgress, gender: $gender, lastTaskFinishedTime: $lastTaskFinishedTime, lastFinishedTaskId: $lastFinishedTaskId, progress: $progress, createdAt: $createdAt, updatedAt: $updatedAt, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.currentProgress, currentProgress) ||
                other.currentProgress == currentProgress) &&
            (identical(other.expectedProgress, expectedProgress) ||
                other.expectedProgress == expectedProgress) &&
            const DeepCollectionEquality().equals(other.gender, gender) &&
            (identical(other.lastTaskFinishedTime, lastTaskFinishedTime) ||
                other.lastTaskFinishedTime == lastTaskFinishedTime) &&
            (identical(other.lastFinishedTaskId, lastFinishedTaskId) ||
                other.lastFinishedTaskId == lastFinishedTaskId) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      uuid,
      name,
      email,
      height,
      weight,
      age,
      birthday,
      currentProgress,
      expectedProgress,
      const DeepCollectionEquality().hash(gender),
      lastTaskFinishedTime,
      lastFinishedTaskId,
      progress,
      createdAt,
      updatedAt,
      phoneNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {final int? id,
      final String? uuid,
      final String? name,
      final String? email,
      @StringToDoubleConverter() final double? height,
      @StringToDoubleConverter() final double? weight,
      final int? age,
      final DateTime? birthday,
      final int? currentProgress,
      final int? expectedProgress,
      final dynamic gender,
      final DateTime? lastTaskFinishedTime,
      final String? lastFinishedTaskId,
      final int? progress,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      @JsonKey(name: 'phone_number') final String? phoneNumber}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  int? get id;
  @override
  String? get uuid;
  @override
  String? get name;
  @override
  String? get email;
  @override
  @StringToDoubleConverter()
  double? get height;
  @override
  @StringToDoubleConverter()
  double? get weight;
  @override
  int? get age;
  @override
  DateTime? get birthday;
  @override
  int? get currentProgress;
  @override
  int? get expectedProgress;
  @override
  dynamic get gender;
  @override
  DateTime? get lastTaskFinishedTime;
  @override
  String? get lastFinishedTaskId;
  @override
  int? get progress;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'phone_number')
  String? get phoneNumber;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
