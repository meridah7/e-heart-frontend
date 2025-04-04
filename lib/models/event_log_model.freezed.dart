// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EventLogModel _$EventLogModelFromJson(Map<String, dynamic> json) {
  return _EventLogModel.fromJson(json);
}

/// @nodoc
mixin _$EventLogModel {
  @JsonKey(name: "mealPlans")
  List<MealPlan> get mealPlans => throw _privateConstructorUsedError;
  @JsonKey(name: "dietLogs")
  List<DietLog> get dietLogs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventLogModelCopyWith<EventLogModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventLogModelCopyWith<$Res> {
  factory $EventLogModelCopyWith(
          EventLogModel value, $Res Function(EventLogModel) then) =
      _$EventLogModelCopyWithImpl<$Res, EventLogModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "mealPlans") List<MealPlan> mealPlans,
      @JsonKey(name: "dietLogs") List<DietLog> dietLogs});
}

/// @nodoc
class _$EventLogModelCopyWithImpl<$Res, $Val extends EventLogModel>
    implements $EventLogModelCopyWith<$Res> {
  _$EventLogModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mealPlans = null,
    Object? dietLogs = null,
  }) {
    return _then(_value.copyWith(
      mealPlans: null == mealPlans
          ? _value.mealPlans
          : mealPlans // ignore: cast_nullable_to_non_nullable
              as List<MealPlan>,
      dietLogs: null == dietLogs
          ? _value.dietLogs
          : dietLogs // ignore: cast_nullable_to_non_nullable
              as List<DietLog>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventLogModelImplCopyWith<$Res>
    implements $EventLogModelCopyWith<$Res> {
  factory _$$EventLogModelImplCopyWith(
          _$EventLogModelImpl value, $Res Function(_$EventLogModelImpl) then) =
      __$$EventLogModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "mealPlans") List<MealPlan> mealPlans,
      @JsonKey(name: "dietLogs") List<DietLog> dietLogs});
}

/// @nodoc
class __$$EventLogModelImplCopyWithImpl<$Res>
    extends _$EventLogModelCopyWithImpl<$Res, _$EventLogModelImpl>
    implements _$$EventLogModelImplCopyWith<$Res> {
  __$$EventLogModelImplCopyWithImpl(
      _$EventLogModelImpl _value, $Res Function(_$EventLogModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mealPlans = null,
    Object? dietLogs = null,
  }) {
    return _then(_$EventLogModelImpl(
      mealPlans: null == mealPlans
          ? _value._mealPlans
          : mealPlans // ignore: cast_nullable_to_non_nullable
              as List<MealPlan>,
      dietLogs: null == dietLogs
          ? _value._dietLogs
          : dietLogs // ignore: cast_nullable_to_non_nullable
              as List<DietLog>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventLogModelImpl implements _EventLogModel {
  const _$EventLogModelImpl(
      {@JsonKey(name: "mealPlans") required final List<MealPlan> mealPlans,
      @JsonKey(name: "dietLogs") required final List<DietLog> dietLogs})
      : _mealPlans = mealPlans,
        _dietLogs = dietLogs;

  factory _$EventLogModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventLogModelImplFromJson(json);

  final List<MealPlan> _mealPlans;
  @override
  @JsonKey(name: "mealPlans")
  List<MealPlan> get mealPlans {
    if (_mealPlans is EqualUnmodifiableListView) return _mealPlans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mealPlans);
  }

  final List<DietLog> _dietLogs;
  @override
  @JsonKey(name: "dietLogs")
  List<DietLog> get dietLogs {
    if (_dietLogs is EqualUnmodifiableListView) return _dietLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dietLogs);
  }

  @override
  String toString() {
    return 'EventLogModel(mealPlans: $mealPlans, dietLogs: $dietLogs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventLogModelImpl &&
            const DeepCollectionEquality()
                .equals(other._mealPlans, _mealPlans) &&
            const DeepCollectionEquality().equals(other._dietLogs, _dietLogs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_mealPlans),
      const DeepCollectionEquality().hash(_dietLogs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventLogModelImplCopyWith<_$EventLogModelImpl> get copyWith =>
      __$$EventLogModelImplCopyWithImpl<_$EventLogModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventLogModelImplToJson(
      this,
    );
  }
}

abstract class _EventLogModel implements EventLogModel {
  const factory _EventLogModel(
          {@JsonKey(name: "mealPlans") required final List<MealPlan> mealPlans,
          @JsonKey(name: "dietLogs") required final List<DietLog> dietLogs}) =
      _$EventLogModelImpl;

  factory _EventLogModel.fromJson(Map<String, dynamic> json) =
      _$EventLogModelImpl.fromJson;

  @override
  @JsonKey(name: "mealPlans")
  List<MealPlan> get mealPlans;
  @override
  @JsonKey(name: "dietLogs")
  List<DietLog> get dietLogs;
  @override
  @JsonKey(ignore: true)
  _$$EventLogModelImplCopyWith<_$EventLogModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DietLog _$DietLogFromJson(Map<String, dynamic> json) {
  return _DietLog.fromJson(json);
}

/// @nodoc
mixin _$DietLog {
  @JsonKey(name: "id")
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: "user_id")
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: "eating_time")
  int get eatingTime => throw _privateConstructorUsedError;
  @JsonKey(name: "food_details")
  String get foodDetails => throw _privateConstructorUsedError;
  @JsonKey(name: "emotion_intensity")
  int get emotionIntensity => throw _privateConstructorUsedError;
  @JsonKey(name: "emotion_type")
  String get emotionType => throw _privateConstructorUsedError;
  @JsonKey(name: "eating_location")
  String get eatingLocation => throw _privateConstructorUsedError;
  @JsonKey(name: "specific_location")
  String get specificLocation => throw _privateConstructorUsedError;
  @JsonKey(name: "dieting")
  bool get dieting => throw _privateConstructorUsedError;
  @JsonKey(name: "binge_eating")
  bool get bingeEating => throw _privateConstructorUsedError;
  @JsonKey(name: "trigger")
  String get trigger => throw _privateConstructorUsedError;
  @JsonKey(name: "additional_info")
  String get additionalInfo => throw _privateConstructorUsedError;
  @JsonKey(name: "meal_type")
  String get mealType => throw _privateConstructorUsedError;
  @JsonKey(name: "createdAt")
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updatedAt")
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DietLogCopyWith<DietLog> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DietLogCopyWith<$Res> {
  factory $DietLogCopyWith(DietLog value, $Res Function(DietLog) then) =
      _$DietLogCopyWithImpl<$Res, DietLog>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "user_id") int userId,
      @JsonKey(name: "eating_time") int eatingTime,
      @JsonKey(name: "food_details") String foodDetails,
      @JsonKey(name: "emotion_intensity") int emotionIntensity,
      @JsonKey(name: "emotion_type") String emotionType,
      @JsonKey(name: "eating_location") String eatingLocation,
      @JsonKey(name: "specific_location") String specificLocation,
      @JsonKey(name: "dieting") bool dieting,
      @JsonKey(name: "binge_eating") bool bingeEating,
      @JsonKey(name: "trigger") String trigger,
      @JsonKey(name: "additional_info") String additionalInfo,
      @JsonKey(name: "meal_type") String mealType,
      @JsonKey(name: "createdAt") DateTime createdAt,
      @JsonKey(name: "updatedAt") DateTime updatedAt});
}

/// @nodoc
class _$DietLogCopyWithImpl<$Res, $Val extends DietLog>
    implements $DietLogCopyWith<$Res> {
  _$DietLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? eatingTime = null,
    Object? foodDetails = null,
    Object? emotionIntensity = null,
    Object? emotionType = null,
    Object? eatingLocation = null,
    Object? specificLocation = null,
    Object? dieting = null,
    Object? bingeEating = null,
    Object? trigger = null,
    Object? additionalInfo = null,
    Object? mealType = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      eatingTime: null == eatingTime
          ? _value.eatingTime
          : eatingTime // ignore: cast_nullable_to_non_nullable
              as int,
      foodDetails: null == foodDetails
          ? _value.foodDetails
          : foodDetails // ignore: cast_nullable_to_non_nullable
              as String,
      emotionIntensity: null == emotionIntensity
          ? _value.emotionIntensity
          : emotionIntensity // ignore: cast_nullable_to_non_nullable
              as int,
      emotionType: null == emotionType
          ? _value.emotionType
          : emotionType // ignore: cast_nullable_to_non_nullable
              as String,
      eatingLocation: null == eatingLocation
          ? _value.eatingLocation
          : eatingLocation // ignore: cast_nullable_to_non_nullable
              as String,
      specificLocation: null == specificLocation
          ? _value.specificLocation
          : specificLocation // ignore: cast_nullable_to_non_nullable
              as String,
      dieting: null == dieting
          ? _value.dieting
          : dieting // ignore: cast_nullable_to_non_nullable
              as bool,
      bingeEating: null == bingeEating
          ? _value.bingeEating
          : bingeEating // ignore: cast_nullable_to_non_nullable
              as bool,
      trigger: null == trigger
          ? _value.trigger
          : trigger // ignore: cast_nullable_to_non_nullable
              as String,
      additionalInfo: null == additionalInfo
          ? _value.additionalInfo
          : additionalInfo // ignore: cast_nullable_to_non_nullable
              as String,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DietLogImplCopyWith<$Res> implements $DietLogCopyWith<$Res> {
  factory _$$DietLogImplCopyWith(
          _$DietLogImpl value, $Res Function(_$DietLogImpl) then) =
      __$$DietLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "user_id") int userId,
      @JsonKey(name: "eating_time") int eatingTime,
      @JsonKey(name: "food_details") String foodDetails,
      @JsonKey(name: "emotion_intensity") int emotionIntensity,
      @JsonKey(name: "emotion_type") String emotionType,
      @JsonKey(name: "eating_location") String eatingLocation,
      @JsonKey(name: "specific_location") String specificLocation,
      @JsonKey(name: "dieting") bool dieting,
      @JsonKey(name: "binge_eating") bool bingeEating,
      @JsonKey(name: "trigger") String trigger,
      @JsonKey(name: "additional_info") String additionalInfo,
      @JsonKey(name: "meal_type") String mealType,
      @JsonKey(name: "createdAt") DateTime createdAt,
      @JsonKey(name: "updatedAt") DateTime updatedAt});
}

/// @nodoc
class __$$DietLogImplCopyWithImpl<$Res>
    extends _$DietLogCopyWithImpl<$Res, _$DietLogImpl>
    implements _$$DietLogImplCopyWith<$Res> {
  __$$DietLogImplCopyWithImpl(
      _$DietLogImpl _value, $Res Function(_$DietLogImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? eatingTime = null,
    Object? foodDetails = null,
    Object? emotionIntensity = null,
    Object? emotionType = null,
    Object? eatingLocation = null,
    Object? specificLocation = null,
    Object? dieting = null,
    Object? bingeEating = null,
    Object? trigger = null,
    Object? additionalInfo = null,
    Object? mealType = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$DietLogImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      eatingTime: null == eatingTime
          ? _value.eatingTime
          : eatingTime // ignore: cast_nullable_to_non_nullable
              as int,
      foodDetails: null == foodDetails
          ? _value.foodDetails
          : foodDetails // ignore: cast_nullable_to_non_nullable
              as String,
      emotionIntensity: null == emotionIntensity
          ? _value.emotionIntensity
          : emotionIntensity // ignore: cast_nullable_to_non_nullable
              as int,
      emotionType: null == emotionType
          ? _value.emotionType
          : emotionType // ignore: cast_nullable_to_non_nullable
              as String,
      eatingLocation: null == eatingLocation
          ? _value.eatingLocation
          : eatingLocation // ignore: cast_nullable_to_non_nullable
              as String,
      specificLocation: null == specificLocation
          ? _value.specificLocation
          : specificLocation // ignore: cast_nullable_to_non_nullable
              as String,
      dieting: null == dieting
          ? _value.dieting
          : dieting // ignore: cast_nullable_to_non_nullable
              as bool,
      bingeEating: null == bingeEating
          ? _value.bingeEating
          : bingeEating // ignore: cast_nullable_to_non_nullable
              as bool,
      trigger: null == trigger
          ? _value.trigger
          : trigger // ignore: cast_nullable_to_non_nullable
              as String,
      additionalInfo: null == additionalInfo
          ? _value.additionalInfo
          : additionalInfo // ignore: cast_nullable_to_non_nullable
              as String,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DietLogImpl implements _DietLog {
  const _$DietLogImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "user_id") required this.userId,
      @JsonKey(name: "eating_time") required this.eatingTime,
      @JsonKey(name: "food_details") required this.foodDetails,
      @JsonKey(name: "emotion_intensity") required this.emotionIntensity,
      @JsonKey(name: "emotion_type") required this.emotionType,
      @JsonKey(name: "eating_location") required this.eatingLocation,
      @JsonKey(name: "specific_location") required this.specificLocation,
      @JsonKey(name: "dieting") required this.dieting,
      @JsonKey(name: "binge_eating") required this.bingeEating,
      @JsonKey(name: "trigger") required this.trigger,
      @JsonKey(name: "additional_info") required this.additionalInfo,
      @JsonKey(name: "meal_type") required this.mealType,
      @JsonKey(name: "createdAt") required this.createdAt,
      @JsonKey(name: "updatedAt") required this.updatedAt});

  factory _$DietLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$DietLogImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int id;
  @override
  @JsonKey(name: "user_id")
  final int userId;
  @override
  @JsonKey(name: "eating_time")
  final int eatingTime;
  @override
  @JsonKey(name: "food_details")
  final String foodDetails;
  @override
  @JsonKey(name: "emotion_intensity")
  final int emotionIntensity;
  @override
  @JsonKey(name: "emotion_type")
  final String emotionType;
  @override
  @JsonKey(name: "eating_location")
  final String eatingLocation;
  @override
  @JsonKey(name: "specific_location")
  final String specificLocation;
  @override
  @JsonKey(name: "dieting")
  final bool dieting;
  @override
  @JsonKey(name: "binge_eating")
  final bool bingeEating;
  @override
  @JsonKey(name: "trigger")
  final String trigger;
  @override
  @JsonKey(name: "additional_info")
  final String additionalInfo;
  @override
  @JsonKey(name: "meal_type")
  final String mealType;
  @override
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @override
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;

  @override
  String toString() {
    return 'DietLog(id: $id, userId: $userId, eatingTime: $eatingTime, foodDetails: $foodDetails, emotionIntensity: $emotionIntensity, emotionType: $emotionType, eatingLocation: $eatingLocation, specificLocation: $specificLocation, dieting: $dieting, bingeEating: $bingeEating, trigger: $trigger, additionalInfo: $additionalInfo, mealType: $mealType, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DietLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.eatingTime, eatingTime) ||
                other.eatingTime == eatingTime) &&
            (identical(other.foodDetails, foodDetails) ||
                other.foodDetails == foodDetails) &&
            (identical(other.emotionIntensity, emotionIntensity) ||
                other.emotionIntensity == emotionIntensity) &&
            (identical(other.emotionType, emotionType) ||
                other.emotionType == emotionType) &&
            (identical(other.eatingLocation, eatingLocation) ||
                other.eatingLocation == eatingLocation) &&
            (identical(other.specificLocation, specificLocation) ||
                other.specificLocation == specificLocation) &&
            (identical(other.dieting, dieting) || other.dieting == dieting) &&
            (identical(other.bingeEating, bingeEating) ||
                other.bingeEating == bingeEating) &&
            (identical(other.trigger, trigger) || other.trigger == trigger) &&
            (identical(other.additionalInfo, additionalInfo) ||
                other.additionalInfo == additionalInfo) &&
            (identical(other.mealType, mealType) ||
                other.mealType == mealType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      eatingTime,
      foodDetails,
      emotionIntensity,
      emotionType,
      eatingLocation,
      specificLocation,
      dieting,
      bingeEating,
      trigger,
      additionalInfo,
      mealType,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DietLogImplCopyWith<_$DietLogImpl> get copyWith =>
      __$$DietLogImplCopyWithImpl<_$DietLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DietLogImplToJson(
      this,
    );
  }
}

abstract class _DietLog implements DietLog {
  const factory _DietLog(
      {@JsonKey(name: "id") required final int id,
      @JsonKey(name: "user_id") required final int userId,
      @JsonKey(name: "eating_time") required final int eatingTime,
      @JsonKey(name: "food_details") required final String foodDetails,
      @JsonKey(name: "emotion_intensity") required final int emotionIntensity,
      @JsonKey(name: "emotion_type") required final String emotionType,
      @JsonKey(name: "eating_location") required final String eatingLocation,
      @JsonKey(name: "specific_location")
      required final String specificLocation,
      @JsonKey(name: "dieting") required final bool dieting,
      @JsonKey(name: "binge_eating") required final bool bingeEating,
      @JsonKey(name: "trigger") required final String trigger,
      @JsonKey(name: "additional_info") required final String additionalInfo,
      @JsonKey(name: "meal_type") required final String mealType,
      @JsonKey(name: "createdAt") required final DateTime createdAt,
      @JsonKey(name: "updatedAt")
      required final DateTime updatedAt}) = _$DietLogImpl;

  factory _DietLog.fromJson(Map<String, dynamic> json) = _$DietLogImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int get id;
  @override
  @JsonKey(name: "user_id")
  int get userId;
  @override
  @JsonKey(name: "eating_time")
  int get eatingTime;
  @override
  @JsonKey(name: "food_details")
  String get foodDetails;
  @override
  @JsonKey(name: "emotion_intensity")
  int get emotionIntensity;
  @override
  @JsonKey(name: "emotion_type")
  String get emotionType;
  @override
  @JsonKey(name: "eating_location")
  String get eatingLocation;
  @override
  @JsonKey(name: "specific_location")
  String get specificLocation;
  @override
  @JsonKey(name: "dieting")
  bool get dieting;
  @override
  @JsonKey(name: "binge_eating")
  bool get bingeEating;
  @override
  @JsonKey(name: "trigger")
  String get trigger;
  @override
  @JsonKey(name: "additional_info")
  String get additionalInfo;
  @override
  @JsonKey(name: "meal_type")
  String get mealType;
  @override
  @JsonKey(name: "createdAt")
  DateTime get createdAt;
  @override
  @JsonKey(name: "updatedAt")
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$DietLogImplCopyWith<_$DietLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealPlan _$MealPlanFromJson(Map<String, dynamic> json) {
  return _MealPlan.fromJson(json);
}

/// @nodoc
mixin _$MealPlan {
  @JsonKey(name: "id")
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: "user_id")
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: "type")
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: "food_details")
  String get foodDetails => throw _privateConstructorUsedError;
  @JsonKey(name: "time")
  String get time => throw _privateConstructorUsedError;
  @JsonKey(name: "date")
  int get date => throw _privateConstructorUsedError;
  @JsonKey(name: "target_date")
  int get targetDate => throw _privateConstructorUsedError;
  @JsonKey(name: "state")
  bool get state => throw _privateConstructorUsedError;
  @JsonKey(name: "createdAt")
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updatedAt")
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MealPlanCopyWith<MealPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealPlanCopyWith<$Res> {
  factory $MealPlanCopyWith(MealPlan value, $Res Function(MealPlan) then) =
      _$MealPlanCopyWithImpl<$Res, MealPlan>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "user_id") int userId,
      @JsonKey(name: "type") String type,
      @JsonKey(name: "food_details") String foodDetails,
      @JsonKey(name: "time") String time,
      @JsonKey(name: "date") int date,
      @JsonKey(name: "target_date") int targetDate,
      @JsonKey(name: "state") bool state,
      @JsonKey(name: "createdAt") DateTime createdAt,
      @JsonKey(name: "updatedAt") DateTime updatedAt});
}

/// @nodoc
class _$MealPlanCopyWithImpl<$Res, $Val extends MealPlan>
    implements $MealPlanCopyWith<$Res> {
  _$MealPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? foodDetails = null,
    Object? time = null,
    Object? date = null,
    Object? targetDate = null,
    Object? state = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      foodDetails: null == foodDetails
          ? _value.foodDetails
          : foodDetails // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as int,
      targetDate: null == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealPlanImplCopyWith<$Res>
    implements $MealPlanCopyWith<$Res> {
  factory _$$MealPlanImplCopyWith(
          _$MealPlanImpl value, $Res Function(_$MealPlanImpl) then) =
      __$$MealPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "user_id") int userId,
      @JsonKey(name: "type") String type,
      @JsonKey(name: "food_details") String foodDetails,
      @JsonKey(name: "time") String time,
      @JsonKey(name: "date") int date,
      @JsonKey(name: "target_date") int targetDate,
      @JsonKey(name: "state") bool state,
      @JsonKey(name: "createdAt") DateTime createdAt,
      @JsonKey(name: "updatedAt") DateTime updatedAt});
}

/// @nodoc
class __$$MealPlanImplCopyWithImpl<$Res>
    extends _$MealPlanCopyWithImpl<$Res, _$MealPlanImpl>
    implements _$$MealPlanImplCopyWith<$Res> {
  __$$MealPlanImplCopyWithImpl(
      _$MealPlanImpl _value, $Res Function(_$MealPlanImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? foodDetails = null,
    Object? time = null,
    Object? date = null,
    Object? targetDate = null,
    Object? state = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$MealPlanImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      foodDetails: null == foodDetails
          ? _value.foodDetails
          : foodDetails // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as int,
      targetDate: null == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealPlanImpl implements _MealPlan {
  const _$MealPlanImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "user_id") required this.userId,
      @JsonKey(name: "type") required this.type,
      @JsonKey(name: "food_details") required this.foodDetails,
      @JsonKey(name: "time") required this.time,
      @JsonKey(name: "date") required this.date,
      @JsonKey(name: "target_date") required this.targetDate,
      @JsonKey(name: "state") required this.state,
      @JsonKey(name: "createdAt") required this.createdAt,
      @JsonKey(name: "updatedAt") required this.updatedAt});

  factory _$MealPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealPlanImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int id;
  @override
  @JsonKey(name: "user_id")
  final int userId;
  @override
  @JsonKey(name: "type")
  final String type;
  @override
  @JsonKey(name: "food_details")
  final String foodDetails;
  @override
  @JsonKey(name: "time")
  final String time;
  @override
  @JsonKey(name: "date")
  final int date;
  @override
  @JsonKey(name: "target_date")
  final int targetDate;
  @override
  @JsonKey(name: "state")
  final bool state;
  @override
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @override
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;

  @override
  String toString() {
    return 'MealPlan(id: $id, userId: $userId, type: $type, foodDetails: $foodDetails, time: $time, date: $date, targetDate: $targetDate, state: $state, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.foodDetails, foodDetails) ||
                other.foodDetails == foodDetails) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, type, foodDetails,
      time, date, targetDate, state, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MealPlanImplCopyWith<_$MealPlanImpl> get copyWith =>
      __$$MealPlanImplCopyWithImpl<_$MealPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealPlanImplToJson(
      this,
    );
  }
}

abstract class _MealPlan implements MealPlan {
  const factory _MealPlan(
          {@JsonKey(name: "id") required final int id,
          @JsonKey(name: "user_id") required final int userId,
          @JsonKey(name: "type") required final String type,
          @JsonKey(name: "food_details") required final String foodDetails,
          @JsonKey(name: "time") required final String time,
          @JsonKey(name: "date") required final int date,
          @JsonKey(name: "target_date") required final int targetDate,
          @JsonKey(name: "state") required final bool state,
          @JsonKey(name: "createdAt") required final DateTime createdAt,
          @JsonKey(name: "updatedAt") required final DateTime updatedAt}) =
      _$MealPlanImpl;

  factory _MealPlan.fromJson(Map<String, dynamic> json) =
      _$MealPlanImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int get id;
  @override
  @JsonKey(name: "user_id")
  int get userId;
  @override
  @JsonKey(name: "type")
  String get type;
  @override
  @JsonKey(name: "food_details")
  String get foodDetails;
  @override
  @JsonKey(name: "time")
  String get time;
  @override
  @JsonKey(name: "date")
  int get date;
  @override
  @JsonKey(name: "target_date")
  int get targetDate;
  @override
  @JsonKey(name: "state")
  bool get state;
  @override
  @JsonKey(name: "createdAt")
  DateTime get createdAt;
  @override
  @JsonKey(name: "updatedAt")
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$MealPlanImplCopyWith<_$MealPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
