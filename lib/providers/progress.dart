import 'package:namer_app/models/task_models.dart';
import 'package:namer_app/models/user_progress.dart';
import 'package:namer_app/services/progress_service.dart';
import 'package:namer_app/constants/tasks/daily_tasks.dart';
import 'package:namer_app/utils/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'progress.g.dart';

@Riverpod(keepAlive: true)
class Progress extends _$Progress {
  late ProgressService _progressService;

  @override
  FutureOr<UserProgress?> build() async {
    _progressService = ref.watch(progressServiceProvider);
    return fetchProgress();
  }

  Future<UserProgress?> fetchProgress() async {
    try {
      final UserProgress? progress = await _progressService.fetchProgress();
      state = AsyncData(progress);
      return progress;
    } catch (err) {
      throw Exception('Error fetching progress: $err');
    }
  }

  Future<void> updateProgress(String taskId) async {
    state = const AsyncLoading();
    await AsyncValue.guard(() async {
      if ((state.value?.finishedTaskIds ?? []).contains(taskId) ?? false) {
        ToastUtils.showToast('当前任务已完成');
        return;
      }
      bool isRequired =
          (state.value?.allRequiredTaskIds ?? []).contains(taskId);

      final bool isUpdated =
          await _progressService.updateProgress(taskId, isRequired: isRequired);
      if (isUpdated) {
        await fetchProgress();
      }
    });
  }

  Future<void> setProgress(int progress) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final updatedProgress = await _progressService.setProgress(progress);
      // await _fetchDisplayTaskList(updatedProgress!);
      return updatedProgress;
    });
  }
}

@Riverpod(keepAlive: true)
class DailyTasks extends _$DailyTasks {
  late ProgressService _progressService;
  late UserProgress? _userProgress;

  @override
  Future<List<Task>> build() async {
    _progressService = ref.watch(progressServiceProvider);
    _userProgress = await ref.watch(progressProvider.future);
    return _processTasks();
  }

  Future<List<Task>> _processTasks() async {
    final List<Task> impulseRecordTasks =
        await _progressService.fetchImpulseReflectionRecords();
    final List<Task> requiredTasks = getTasksByIds(
      _userProgress?.allRequiredTaskIds ?? [],
    ).map((e) {
      return e.copyWith(
        isCompleted:
            (_userProgress?.finishedTaskIds ?? []).contains(e.id) ?? false,
      );
    }).toList();

    return [
      ...requiredTasks,
      ...impulseRecordTasks,
    ];
  }
}

@Riverpod(keepAlive: true)
class OptionalTasks extends _$OptionalTasks {
  late final UserProgress? _userProgress;
  @override
  Future<List<Task>> build() async {
    _userProgress = await ref.watch(progressProvider.future);
    return getTasksByIds(_userProgress?.allOptionalTaskIds ?? []).map((e) {
      return e.copyWith(
          isCompleted:
              (_userProgress?.finishedOptionalTaskIds ?? []).contains(e.id) ??
                  false);
    }).toList();
  }
}
