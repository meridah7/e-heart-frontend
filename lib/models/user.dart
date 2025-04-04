import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:namer_app/utils/converter.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    int? id,
    String? uuid,
    String? name,
    String? email,
    @StringToDoubleConverter() double? height,
    @StringToDoubleConverter() double? weight,
    int? age,
    DateTime? birthday,
    int? currentProgress,
    int? expectedProgress,
    dynamic gender,
    DateTime? lastTaskFinishedTime,
    String? lastFinishedTaskId,
    int? progress,
    DateTime? createdAt,
    DateTime? updatedAt,
    @JsonKey(name: 'phone_number') String? phoneNumber,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
