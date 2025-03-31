import 'package:namer_app/models/user_progress.dart';
import 'package:namer_app/services/progress_service.dart';
import 'package:namer_app/tasks/daily_tasks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'progress.g.dart';

@riverpod
class Progress extends _$Progress {
  late ProgressService _progressService;

  @override
  FutureOr<UserProgress?> build() async {
    _progressService = ref.watch(progressServiceProvider);
    return null;
  }

  // Future<UserProgress?> _fetchProgress() async {
  //   try {
  //     final UserProgress? progress = await _progressService.fetchProgress();
  //     // await _fetchDisplayTaskList(progress);
  //     return progress;
  //   } catch (err) {
  //     throw Exception('Error fetching progress: $err');
  //   }
  // }

  // Future<void> updateProgress(String taskId, {bool isRequired = true}) async {
  //   state = const AsyncLoading();
  //   state = await AsyncValue.guard(() async {
  //     final progress = await ref
  //         .read(progressServiceProvider)
  //         .updateProgress(taskId, isRequired: isRequired);
  //     if (progress != null) {
  //       await _fetchDisplayTaskList(progress);
  //     }
  //     return progress;
  //   });
  // }

  Future<void> setProgress(int progress) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final updatedProgress = await _progressService.setProgress(progress);
      // await _fetchDisplayTaskList(updatedProgress!);
      return updatedProgress;
    });
  }

  Future<void> _fetchDisplayTaskList(UserProgress progress) async {
    try {
      final impulseRecordTaskList = await ref
          .read(progressServiceProvider)
          .fetchImpulseReflectionRecords();

      final requiredTasks = getTasksByIds(progress.allRequiredTaskIds)
          .map((e) =>
              e.copyWith(isCompleted: progress.finishedTaskIds?.contains(e.id)))
          .toList();

      final optionalTasks = getTasksByIds(progress.allOptionalTaskIds)
          .map((e) => e.copyWith(
              isCompleted: progress.finishedOptionalTaskIds?.contains(e.id)))
          .toList();

      // state = AsyncData(progress.copyWith(
      //   dailyTasks: [...requiredTasks, ...impulseRecordTaskList],
      //   optionalTasks: optionalTasks,
      // ));
    } catch (err) {
      throw Exception('Error fetching task list: $err');
    }
  }

// @riverpod
// List<Task> dailyTaskList(DailyTaskListRef ref) {
//   return ref.watch(progressProvider).whenOrNull(
//             data: (progress) => progress.dailyTasks ?? [],
//           ) ??
//       [];
// }

// @riverpod
// List<Task> optionalTaskList(OptionalTaskListRef ref) {
//   return ref.watch(progressProvider).whenOrNull(
//             data: (progress) => progress.optionalTasks ?? [],
//           ) ??
//       [];
}
