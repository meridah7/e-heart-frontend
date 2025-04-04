// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num?)?.toInt(),
      uuid: json['uuid'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      height: const StringToDoubleConverter().fromJson(json['height']),
      weight: const StringToDoubleConverter().fromJson(json['weight']),
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
      phoneNumber: json['phone_number'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'name': instance.name,
      'email': instance.email,
      'height': const StringToDoubleConverter().toJson(instance.height),
      'weight': const StringToDoubleConverter().toJson(instance.weight),
      'age': instance.age,
      'birthday': instance.birthday?.toIso8601String(),
      'currentProgress': instance.currentProgress,
      'expectedProgress': instance.expectedProgress,
      'gender': instance.gender,
      'lastTaskFinishedTime': instance.lastTaskFinishedTime?.toIso8601String(),
      'lastFinishedTaskId': instance.lastFinishedTaskId,
      'progress': instance.progress,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'phone_number': instance.phoneNumber,
    };
