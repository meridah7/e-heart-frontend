import 'package:freezed_annotation/freezed_annotation.dart';
part 'event_log_model.freezed.dart';
part 'event_log_model.g.dart';

@freezed
class EventLogModel with _$EventLogModel {
  const factory EventLogModel({
    @JsonKey(name: "mealPlans") required List<MealPlan> mealPlans,
    @JsonKey(name: "dietLogs") required List<DietLog> dietLogs,
  }) = _EventLogModel;

  factory EventLogModel.fromJson(Map<String, dynamic> json) =>
      _$EventLogModelFromJson(json);
}

@freezed
class DietLog with _$DietLog {
  const factory DietLog({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "user_id") required int userId,
    @JsonKey(name: "eating_time") required int eatingTime,
    @JsonKey(name: "food_details") required String foodDetails,
    @JsonKey(name: "emotion_intensity") required int emotionIntensity,
    @JsonKey(name: "emotion_type") required String emotionType,
    @JsonKey(name: "eating_location") required String eatingLocation,
    @JsonKey(name: "specific_location") required String specificLocation,
    @JsonKey(name: "dieting") required bool dieting,
    @JsonKey(name: "binge_eating") required bool bingeEating,
    @JsonKey(name: "trigger") required String trigger,
    @JsonKey(name: "additional_info") required String additionalInfo,
    @JsonKey(name: "meal_type") required String mealType,
    @JsonKey(name: "createdAt") required DateTime createdAt,
    @JsonKey(name: "updatedAt") required DateTime updatedAt,
  }) = _DietLog;
  // 添加 fromJson 方法
  factory DietLog.fromJson(Map<String, dynamic> json) =>
      _$DietLogFromJson(json);
}

@freezed
class MealPlan with _$MealPlan {
  const factory MealPlan({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "user_id") required int userId,
    @JsonKey(name: "type") required String type,
    @JsonKey(name: "food_details") required String foodDetails,
    @JsonKey(name: "time") required String time,
    @JsonKey(name: "date") required int date,
    @JsonKey(name: "target_date") required int targetDate,
    @JsonKey(name: "state") required bool state,
    @JsonKey(name: "createdAt") required DateTime createdAt,
    @JsonKey(name: "updatedAt") required DateTime updatedAt,
  }) = _MealPlan;

  factory MealPlan.fromJson(Map<String, dynamic> json) =>
      _$MealPlanFromJson(json);
}
