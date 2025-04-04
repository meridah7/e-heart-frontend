// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_progress copy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProgress _$UserProgressFromJson(Map<String, dynamic> json) => UserProgress(
      progress: (json['progress'] as num?)?.toInt(),
      finishedTaskIds: (json['finished_task_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      allRequiredTaskIds: (json['all_required_task_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      allOptionalTaskIds: (json['all_optional_task_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      finishedOptionalTaskIds:
          (json['finished_optional_task_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$UserProgressToJson(UserProgress instance) =>
    <String, dynamic>{
      'progress': instance.progress,
      'finished_task_ids': instance.finishedTaskIds,
      'all_required_task_ids': instance.allRequiredTaskIds,
      'all_optional_task_ids': instance.allOptionalTaskIds,
      'finished_optional_task_ids': instance.finishedOptionalTaskIds,
    };
