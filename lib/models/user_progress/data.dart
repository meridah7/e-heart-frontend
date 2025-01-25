import 'dart:convert';

import 'package:collection/collection.dart';

class Data {
  int? progress;
  List<String>? finishedTaskIds;
  List<String>? allRequiredTaskIds;
  List<String>? allOptionalTaskIds;

  Data({
    this.progress,
    this.finishedTaskIds,
    this.allRequiredTaskIds,
    this.allOptionalTaskIds,
  });

  @override
  String toString() {
    return 'Data(progress: $progress, finishedTaskIds: $finishedTaskIds, allRequiredTaskIds: $allRequiredTaskIds, allOptionalTaskIds: $allOptionalTaskIds)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        progress: data['progress'] as int?,
        finishedTaskIds: data['finished_task_ids'] as List<String>?,
        allRequiredTaskIds: data['all_required_task_ids'] as List<String>?,
        allOptionalTaskIds: data['all_optional_task_ids'] as List<String>?,
      );

  Map<String, dynamic> toMap() => {
        'progress': progress,
        'finished_task_ids': finishedTaskIds,
        'all_required_task_ids': allRequiredTaskIds,
        'all_optional_task_ids': allOptionalTaskIds,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      progress.hashCode ^
      finishedTaskIds.hashCode ^
      allRequiredTaskIds.hashCode ^
      allOptionalTaskIds.hashCode;
}
