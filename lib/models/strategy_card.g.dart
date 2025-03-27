// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strategy_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StrategyCardImpl _$$StrategyCardImplFromJson(Map<String, dynamic> json) =>
    _$StrategyCardImpl(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      customActivity: json['custom_activity'] as String,
      details: json['details'] as String,
      activityOrder: (json['activity_order'] as num).toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$StrategyCardImplToJson(_$StrategyCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'custom_activity': instance.customActivity,
      'details': instance.details,
      'activity_order': instance.activityOrder,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
