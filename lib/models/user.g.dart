// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      phoneNumber: json['phoneNumber'] as String?,
      uuid: json['uuid'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      height: _$JsonConverterFromJson<Object, double>(
          json['height'], const StringToDoubleConverter().fromJson),
      weight: _$JsonConverterFromJson<Object, double>(
          json['weight'], const StringToDoubleConverter().fromJson),
      age: (json['age'] as num?)?.toInt(),
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      currentProgress: (json['currentProgress'] as num?)?.toInt(),
      expectedProgress: (json['expectedProgress'] as num?)?.toInt(),
      gender: json['gender'],
      lastTaskFinishedTime: json['lastTaskFinishedTime'] == null
          ? null
          : DateTime.parse(json['lastTaskFinishedTime'] as String),
      lastFinishedTaskId: json['lastFinishedTaskId'] as String?,
      progress: (json['progress'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'age': instance.age,
      'birthday': instance.birthday?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'currentProgress': instance.currentProgress,
      'email': instance.email,
      'expectedProgress': instance.expectedProgress,
      'gender': instance.gender,
      'height': _$JsonConverterToJson<Object, double>(
          instance.height, const StringToDoubleConverter().toJson),
      'weight': _$JsonConverterToJson<Object, double>(
          instance.weight, const StringToDoubleConverter().toJson),
      'id': instance.id,
      'lastFinishedTaskId': instance.lastFinishedTaskId,
      'lastTaskFinishedTime': instance.lastTaskFinishedTime?.toIso8601String(),
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'progress': instance.progress,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'uuid': instance.uuid,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
