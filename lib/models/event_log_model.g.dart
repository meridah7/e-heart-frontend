// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventLogModelImpl _$$EventLogModelImplFromJson(Map<String, dynamic> json) =>
    _$EventLogModelImpl(
      mealPlans: (json['mealPlans'] as List<dynamic>)
          .map((e) => MealPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
      dietLogs: (json['dietLogs'] as List<dynamic>)
          .map((e) => DietLog.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$EventLogModelImplToJson(_$EventLogModelImpl instance) =>
    <String, dynamic>{
      'mealPlans': instance.mealPlans,
      'dietLogs': instance.dietLogs,
    };

_$DietLogImpl _$$DietLogImplFromJson(Map<String, dynamic> json) =>
    _$DietLogImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      eatingTime: (json['eating_time'] as num).toInt(),
      foodDetails: json['food_details'] as String,
      emotionIntensity: (json['emotion_intensity'] as num).toInt(),
      emotionType: json['emotion_type'] as String,
      eatingLocation: json['eating_location'] as String,
      specificLocation: json['specific_location'] as String,
      dieting: json['dieting'] as bool,
      bingeEating: json['binge_eating'] as bool,
      trigger: json['trigger'] as String,
      additionalInfo: json['additional_info'] as String,
      mealType: json['meal_type'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DietLogImplToJson(_$DietLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'eating_time': instance.eatingTime,
      'food_details': instance.foodDetails,
      'emotion_intensity': instance.emotionIntensity,
      'emotion_type': instance.emotionType,
      'eating_location': instance.eatingLocation,
      'specific_location': instance.specificLocation,
      'dieting': instance.dieting,
      'binge_eating': instance.bingeEating,
      'trigger': instance.trigger,
      'additional_info': instance.additionalInfo,
      'meal_type': instance.mealType,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$MealPlanImpl _$$MealPlanImplFromJson(Map<String, dynamic> json) =>
    _$MealPlanImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      type: json['type'] as String,
      foodDetails: json['food_details'] as String,
      time: json['time'] as String,
      date: (json['date'] as num).toInt(),
      targetDate: (json['target_date'] as num).toInt(),
      state: json['state'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$MealPlanImplToJson(_$MealPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'type': instance.type,
      'food_details': instance.foodDetails,
      'time': instance.time,
      'date': instance.date,
      'target_date': instance.targetDate,
      'state': instance.state,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
