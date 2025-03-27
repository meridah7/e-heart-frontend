// To parse this JSON data, do
//
//     final strategyCard = strategyCardFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'strategy_card.freezed.dart';
part 'strategy_card.g.dart';

enum DetailScene { edit, add, check }

StrategyCard strategyCardFromJson(String str) =>
    StrategyCard.fromJson(json.decode(str));

String strategyCardToJson(StrategyCard data) => json.encode(data.toJson());

@freezed
class StrategyCard with _$StrategyCard {
  const factory StrategyCard({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "user_id") int? userId,
    @JsonKey(name: "custom_activity") required String customActivity,
    @JsonKey(name: "details") required String details,
    @JsonKey(name: "activity_order") required int activityOrder,
    @JsonKey(name: "createdAt") DateTime? createdAt,
    @JsonKey(name: "updatedAt") DateTime? updatedAt,
  }) = _StrategyCard;

  factory StrategyCard.fromJson(Map<String, dynamic> json) =>
      _$StrategyCardFromJson(json);
}
