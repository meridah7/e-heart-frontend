// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProgressImpl _$$UserProgressImplFromJson(Map<String, dynamic> json) =>
    _$UserProgressImpl(
      progress: (json['progress'] as num).toInt(),
      finishedTaskIds: json['finished_task_ids'] ?? const [],
      finishedOptionalTaskIds: json['finished_optional_task_ids'] ?? const [],
      allRequiredTaskIds: (json['all_required_task_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      allOptionalTaskIds: (json['all_optional_task_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserProgressImplToJson(_$UserProgressImpl instance) =>
    <String, dynamic>{
      'progress': instance.progress,
      'finished_task_ids': instance.finishedTaskIds,
      'finished_optional_task_ids': instance.finishedOptionalTaskIds,
      'all_required_task_ids': instance.allRequiredTaskIds,
      'all_optional_task_ids': instance.allOptionalTaskIds,
    };
