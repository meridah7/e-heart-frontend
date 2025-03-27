// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'strategy_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StrategyCard _$StrategyCardFromJson(Map<String, dynamic> json) {
  return _StrategyCard.fromJson(json);
}

/// @nodoc
mixin _$StrategyCard {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "user_id")
  int? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: "custom_activity")
  String get customActivity => throw _privateConstructorUsedError;
  @JsonKey(name: "details")
  String get details => throw _privateConstructorUsedError;
  @JsonKey(name: "activity_order")
  int get activityOrder => throw _privateConstructorUsedError;
  @JsonKey(name: "createdAt")
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updatedAt")
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StrategyCardCopyWith<StrategyCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StrategyCardCopyWith<$Res> {
  factory $StrategyCardCopyWith(
          StrategyCard value, $Res Function(StrategyCard) then) =
      _$StrategyCardCopyWithImpl<$Res, StrategyCard>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "user_id") int? userId,
      @JsonKey(name: "custom_activity") String customActivity,
      @JsonKey(name: "details") String details,
      @JsonKey(name: "activity_order") int activityOrder,
      @JsonKey(name: "createdAt") DateTime? createdAt,
      @JsonKey(name: "updatedAt") DateTime? updatedAt});
}

/// @nodoc
class _$StrategyCardCopyWithImpl<$Res, $Val extends StrategyCard>
    implements $StrategyCardCopyWith<$Res> {
  _$StrategyCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? customActivity = null,
    Object? details = null,
    Object? activityOrder = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      customActivity: null == customActivity
          ? _value.customActivity
          : customActivity // ignore: cast_nullable_to_non_nullable
              as String,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String,
      activityOrder: null == activityOrder
          ? _value.activityOrder
          : activityOrder // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StrategyCardImplCopyWith<$Res>
    implements $StrategyCardCopyWith<$Res> {
  factory _$$StrategyCardImplCopyWith(
          _$StrategyCardImpl value, $Res Function(_$StrategyCardImpl) then) =
      __$$StrategyCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "user_id") int? userId,
      @JsonKey(name: "custom_activity") String customActivity,
      @JsonKey(name: "details") String details,
      @JsonKey(name: "activity_order") int activityOrder,
      @JsonKey(name: "createdAt") DateTime? createdAt,
      @JsonKey(name: "updatedAt") DateTime? updatedAt});
}

/// @nodoc
class __$$StrategyCardImplCopyWithImpl<$Res>
    extends _$StrategyCardCopyWithImpl<$Res, _$StrategyCardImpl>
    implements _$$StrategyCardImplCopyWith<$Res> {
  __$$StrategyCardImplCopyWithImpl(
      _$StrategyCardImpl _value, $Res Function(_$StrategyCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? customActivity = null,
    Object? details = null,
    Object? activityOrder = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$StrategyCardImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      customActivity: null == customActivity
          ? _value.customActivity
          : customActivity // ignore: cast_nullable_to_non_nullable
              as String,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String,
      activityOrder: null == activityOrder
          ? _value.activityOrder
          : activityOrder // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StrategyCardImpl implements _StrategyCard {
  const _$StrategyCardImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "user_id") this.userId,
      @JsonKey(name: "custom_activity") required this.customActivity,
      @JsonKey(name: "details") required this.details,
      @JsonKey(name: "activity_order") required this.activityOrder,
      @JsonKey(name: "createdAt") this.createdAt,
      @JsonKey(name: "updatedAt") this.updatedAt});

  factory _$StrategyCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$StrategyCardImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "user_id")
  final int? userId;
  @override
  @JsonKey(name: "custom_activity")
  final String customActivity;
  @override
  @JsonKey(name: "details")
  final String details;
  @override
  @JsonKey(name: "activity_order")
  final int activityOrder;
  @override
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @override
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'StrategyCard(id: $id, userId: $userId, customActivity: $customActivity, details: $details, activityOrder: $activityOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StrategyCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.customActivity, customActivity) ||
                other.customActivity == customActivity) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.activityOrder, activityOrder) ||
                other.activityOrder == activityOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, customActivity,
      details, activityOrder, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StrategyCardImplCopyWith<_$StrategyCardImpl> get copyWith =>
      __$$StrategyCardImplCopyWithImpl<_$StrategyCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StrategyCardImplToJson(
      this,
    );
  }
}

abstract class _StrategyCard implements StrategyCard {
  const factory _StrategyCard(
      {@JsonKey(name: "id") final int? id,
      @JsonKey(name: "user_id") final int? userId,
      @JsonKey(name: "custom_activity") required final String customActivity,
      @JsonKey(name: "details") required final String details,
      @JsonKey(name: "activity_order") required final int activityOrder,
      @JsonKey(name: "createdAt") final DateTime? createdAt,
      @JsonKey(name: "updatedAt")
      final DateTime? updatedAt}) = _$StrategyCardImpl;

  factory _StrategyCard.fromJson(Map<String, dynamic> json) =
      _$StrategyCardImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "user_id")
  int? get userId;
  @override
  @JsonKey(name: "custom_activity")
  String get customActivity;
  @override
  @JsonKey(name: "details")
  String get details;
  @override
  @JsonKey(name: "activity_order")
  int get activityOrder;
  @override
  @JsonKey(name: "createdAt")
  DateTime? get createdAt;
  @override
  @JsonKey(name: "updatedAt")
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$StrategyCardImplCopyWith<_$StrategyCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
