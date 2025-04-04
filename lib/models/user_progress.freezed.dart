// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProgress _$UserProgressFromJson(Map<String, dynamic> json) {
  return _UserProgress.fromJson(json);
}

/// @nodoc
mixin _$UserProgress {
  @JsonKey(name: "progress")
  int get progress => throw _privateConstructorUsedError;
  @JsonKey(name: "finished_task_ids", defaultValue: [])
  List<String> get finishedTaskIds => throw _privateConstructorUsedError;
  @JsonKey(name: "finished_optional_task_ids", defaultValue: [])
  List<String> get finishedOptionalTaskIds =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "all_required_task_ids", defaultValue: [])
  List<String> get allRequiredTaskIds => throw _privateConstructorUsedError;
  @JsonKey(name: "all_optional_task_ids", defaultValue: [])
  List<String> get allOptionalTaskIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserProgressCopyWith<UserProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProgressCopyWith<$Res> {
  factory $UserProgressCopyWith(
          UserProgress value, $Res Function(UserProgress) then) =
      _$UserProgressCopyWithImpl<$Res, UserProgress>;
  @useResult
  $Res call(
      {@JsonKey(name: "progress") int progress,
      @JsonKey(name: "finished_task_ids", defaultValue: [])
      List<String> finishedTaskIds,
      @JsonKey(name: "finished_optional_task_ids", defaultValue: [])
      List<String> finishedOptionalTaskIds,
      @JsonKey(name: "all_required_task_ids", defaultValue: [])
      List<String> allRequiredTaskIds,
      @JsonKey(name: "all_optional_task_ids", defaultValue: [])
      List<String> allOptionalTaskIds});
}

/// @nodoc
class _$UserProgressCopyWithImpl<$Res, $Val extends UserProgress>
    implements $UserProgressCopyWith<$Res> {
  _$UserProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? finishedTaskIds = null,
    Object? finishedOptionalTaskIds = null,
    Object? allRequiredTaskIds = null,
    Object? allOptionalTaskIds = null,
  }) {
    return _then(_value.copyWith(
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      finishedTaskIds: null == finishedTaskIds
          ? _value.finishedTaskIds
          : finishedTaskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      finishedOptionalTaskIds: null == finishedOptionalTaskIds
          ? _value.finishedOptionalTaskIds
          : finishedOptionalTaskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allRequiredTaskIds: null == allRequiredTaskIds
          ? _value.allRequiredTaskIds
          : allRequiredTaskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allOptionalTaskIds: null == allOptionalTaskIds
          ? _value.allOptionalTaskIds
          : allOptionalTaskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProgressImplCopyWith<$Res>
    implements $UserProgressCopyWith<$Res> {
  factory _$$UserProgressImplCopyWith(
          _$UserProgressImpl value, $Res Function(_$UserProgressImpl) then) =
      __$$UserProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "progress") int progress,
      @JsonKey(name: "finished_task_ids", defaultValue: [])
      List<String> finishedTaskIds,
      @JsonKey(name: "finished_optional_task_ids", defaultValue: [])
      List<String> finishedOptionalTaskIds,
      @JsonKey(name: "all_required_task_ids", defaultValue: [])
      List<String> allRequiredTaskIds,
      @JsonKey(name: "all_optional_task_ids", defaultValue: [])
      List<String> allOptionalTaskIds});
}

/// @nodoc
class __$$UserProgressImplCopyWithImpl<$Res>
    extends _$UserProgressCopyWithImpl<$Res, _$UserProgressImpl>
    implements _$$UserProgressImplCopyWith<$Res> {
  __$$UserProgressImplCopyWithImpl(
      _$UserProgressImpl _value, $Res Function(_$UserProgressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? finishedTaskIds = null,
    Object? finishedOptionalTaskIds = null,
    Object? allRequiredTaskIds = null,
    Object? allOptionalTaskIds = null,
  }) {
    return _then(_$UserProgressImpl(
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      finishedTaskIds: null == finishedTaskIds
          ? _value._finishedTaskIds
          : finishedTaskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      finishedOptionalTaskIds: null == finishedOptionalTaskIds
          ? _value._finishedOptionalTaskIds
          : finishedOptionalTaskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allRequiredTaskIds: null == allRequiredTaskIds
          ? _value._allRequiredTaskIds
          : allRequiredTaskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allOptionalTaskIds: null == allOptionalTaskIds
          ? _value._allOptionalTaskIds
          : allOptionalTaskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProgressImpl implements _UserProgress {
  const _$UserProgressImpl(
      {@JsonKey(name: "progress") required this.progress,
      @JsonKey(name: "finished_task_ids", defaultValue: [])
      final List<String> finishedTaskIds = const [],
      @JsonKey(name: "finished_optional_task_ids", defaultValue: [])
      final List<String> finishedOptionalTaskIds = const [],
      @JsonKey(name: "all_required_task_ids", defaultValue: [])
      final List<String> allRequiredTaskIds = const [],
      @JsonKey(name: "all_optional_task_ids", defaultValue: [])
      final List<String> allOptionalTaskIds = const []})
      : _finishedTaskIds = finishedTaskIds,
        _finishedOptionalTaskIds = finishedOptionalTaskIds,
        _allRequiredTaskIds = allRequiredTaskIds,
        _allOptionalTaskIds = allOptionalTaskIds;

  factory _$UserProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProgressImplFromJson(json);

  @override
  @JsonKey(name: "progress")
  final int progress;
  final List<String> _finishedTaskIds;
  @override
  @JsonKey(name: "finished_task_ids", defaultValue: [])
  List<String> get finishedTaskIds {
    if (_finishedTaskIds is EqualUnmodifiableListView) return _finishedTaskIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_finishedTaskIds);
  }

  final List<String> _finishedOptionalTaskIds;
  @override
  @JsonKey(name: "finished_optional_task_ids", defaultValue: [])
  List<String> get finishedOptionalTaskIds {
    if (_finishedOptionalTaskIds is EqualUnmodifiableListView)
      return _finishedOptionalTaskIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_finishedOptionalTaskIds);
  }

  final List<String> _allRequiredTaskIds;
  @override
  @JsonKey(name: "all_required_task_ids", defaultValue: [])
  List<String> get allRequiredTaskIds {
    if (_allRequiredTaskIds is EqualUnmodifiableListView)
      return _allRequiredTaskIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allRequiredTaskIds);
  }

  final List<String> _allOptionalTaskIds;
  @override
  @JsonKey(name: "all_optional_task_ids", defaultValue: [])
  List<String> get allOptionalTaskIds {
    if (_allOptionalTaskIds is EqualUnmodifiableListView)
      return _allOptionalTaskIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allOptionalTaskIds);
  }

  @override
  String toString() {
    return 'UserProgress(progress: $progress, finishedTaskIds: $finishedTaskIds, finishedOptionalTaskIds: $finishedOptionalTaskIds, allRequiredTaskIds: $allRequiredTaskIds, allOptionalTaskIds: $allOptionalTaskIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProgressImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            const DeepCollectionEquality()
                .equals(other._finishedTaskIds, _finishedTaskIds) &&
            const DeepCollectionEquality().equals(
                other._finishedOptionalTaskIds, _finishedOptionalTaskIds) &&
            const DeepCollectionEquality()
                .equals(other._allRequiredTaskIds, _allRequiredTaskIds) &&
            const DeepCollectionEquality()
                .equals(other._allOptionalTaskIds, _allOptionalTaskIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      progress,
      const DeepCollectionEquality().hash(_finishedTaskIds),
      const DeepCollectionEquality().hash(_finishedOptionalTaskIds),
      const DeepCollectionEquality().hash(_allRequiredTaskIds),
      const DeepCollectionEquality().hash(_allOptionalTaskIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProgressImplCopyWith<_$UserProgressImpl> get copyWith =>
      __$$UserProgressImplCopyWithImpl<_$UserProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProgressImplToJson(
      this,
    );
  }
}

abstract class _UserProgress implements UserProgress {
  const factory _UserProgress(
      {@JsonKey(name: "progress") required final int progress,
      @JsonKey(name: "finished_task_ids", defaultValue: [])
      final List<String> finishedTaskIds,
      @JsonKey(name: "finished_optional_task_ids", defaultValue: [])
      final List<String> finishedOptionalTaskIds,
      @JsonKey(name: "all_required_task_ids", defaultValue: [])
      final List<String> allRequiredTaskIds,
      @JsonKey(name: "all_optional_task_ids", defaultValue: [])
      final List<String> allOptionalTaskIds}) = _$UserProgressImpl;

  factory _UserProgress.fromJson(Map<String, dynamic> json) =
      _$UserProgressImpl.fromJson;

  @override
  @JsonKey(name: "progress")
  int get progress;
  @override
  @JsonKey(name: "finished_task_ids", defaultValue: [])
  List<String> get finishedTaskIds;
  @override
  @JsonKey(name: "finished_optional_task_ids", defaultValue: [])
  List<String> get finishedOptionalTaskIds;
  @override
  @JsonKey(name: "all_required_task_ids", defaultValue: [])
  List<String> get allRequiredTaskIds;
  @override
  @JsonKey(name: "all_optional_task_ids", defaultValue: [])
  List<String> get allOptionalTaskIds;
  @override
  @JsonKey(ignore: true)
  _$$UserProgressImplCopyWith<_$UserProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
