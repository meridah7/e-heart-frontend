import 'package:json_annotation/json_annotation.dart';

part 'user_progress.g.dart';

@JsonSerializable()
class UserProgress {
  int? progress;
  @JsonKey(name: 'finished_task_ids')
  List<String>? finishedTaskIds;
  @JsonKey(name: 'all_required_task_ids')
  List<String>? allRequiredTaskIds;
  @JsonKey(name: 'all_optional_task_ids')
  List<String>? allOptionalTaskIds;
  @JsonKey(name: 'finished_optional_task_ids')
  List<String>? finishedOptionalTaskIds;

  UserProgress({
    this.progress,
    this.finishedTaskIds,
    this.allRequiredTaskIds,
    this.allOptionalTaskIds,
    this.finishedOptionalTaskIds,
  });

  @override
  String toString() {
    return 'UserProgress(progress: $progress, finishedTaskIds: $finishedTaskIds, allRequiredTaskIds: $allRequiredTaskIds, allOptionalTaskIds: $allOptionalTaskIds)';
  }

  factory UserProgress.fromMap(Map<String, dynamic> data) => UserProgress(
        progress: data['progress'] as int?,
        finishedTaskIds: data['finished_task_ids'] as List<String>,
        allRequiredTaskIds: data['all_required_task_ids'] as List<String>,
        allOptionalTaskIds: data['all_optional_task_ids'] as List<String>,
        finishedOptionalTaskIds:
            data['finished_optional_task_ids'] as List<String>,
      );

  Map<String, dynamic> toMap() => {
        'progress': progress,
        'finished_task_ids': finishedTaskIds,
        'all_required_task_ids': allRequiredTaskIds,
        'all_optional_task_ids': allOptionalTaskIds,
        'finished_optional_task_ids': finishedOptionalTaskIds,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserProgress].
  // factory UserProgress.fromJson(String data) {
  //   return UserProgress.fromMap(json.decode(data) as Map<String, dynamic>);
  // }

  // 自动生成的方法
  factory UserProgress.fromJson(Map<String, dynamic> json) =>
      _$UserProgressFromJson(json);

  Map<String, dynamic> toJson() => _$UserProgressToJson(this);

  /// `dart:convert`
  ///
  /// Converts [UserProgress] to a JSON string.
  // String toJson() => json.encode(toMap());
}
