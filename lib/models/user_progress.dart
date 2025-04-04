import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_progress.freezed.dart';
part 'user_progress.g.dart';

@freezed
class UserProgress with _$UserProgress {
  const factory UserProgress({
    @JsonKey(name: "progress") required int progress,
    @JsonKey(name: "finished_task_ids", defaultValue: [])
    @Default([])
    List<String> finishedTaskIds,
    @JsonKey(name: "finished_optional_task_ids", defaultValue: [])
    @Default([])
    List<String> finishedOptionalTaskIds,
    @JsonKey(name: "all_required_task_ids", defaultValue: [])
    @Default([])
    List<String> allRequiredTaskIds,
    @JsonKey(name: "all_optional_task_ids", defaultValue: [])
    @Default([])
    List<String> allOptionalTaskIds,
  }) = _UserProgress;

  factory UserProgress.fromJson(Map<String, dynamic> json) =>
      _$UserProgressFromJson(json);
}
