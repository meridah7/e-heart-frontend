// To parse this JSON data, do
//
//     final strategyCard = strategyCardFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'strategy_card.g.dart';

List<StrategyCard> strategyCardFromJson(String str) => List<StrategyCard>.from(
    json.decode(str).map((x) => StrategyCard.fromJson(x)));

String strategyCardToJson(List<StrategyCard> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class StrategyCard {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "user_id")
  int userId;
  @JsonKey(name: "custom_activity")
  String customActivity;
  @JsonKey(name: "details")
  String details;
  @JsonKey(name: "activity_order")
  int activityOrder;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;

  StrategyCard({
    required this.id,
    required this.userId,
    required this.customActivity,
    required this.details,
    required this.activityOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  StrategyCard copyWith({
    int? id,
    int? userId,
    String? customActivity,
    String? details,
    int? activityOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      StrategyCard(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        customActivity: customActivity ?? this.customActivity,
        details: details ?? this.details,
        activityOrder: activityOrder ?? this.activityOrder,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory StrategyCard.fromJson(Map<String, dynamic> json) =>
      _$StrategyCardFromJson(json);

  Map<String, dynamic> toJson() => _$StrategyCardToJson(this);
}
