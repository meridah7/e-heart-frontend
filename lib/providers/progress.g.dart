// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$progressHash() => r'fde60fa06ed843b5ff0b8c67fd206a39f389fc9e';

/// See also [Progress].
@ProviderFor(Progress)
final progressProvider =
    AsyncNotifierProvider<Progress, UserProgress?>.internal(
  Progress.new,
  name: r'progressProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$progressHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Progress = AsyncNotifier<UserProgress?>;
String _$dailyTasksHash() => r'1868f5d221ac298cf9a0a9386ab28bc0d3fad66d';

/// See also [DailyTasks].
@ProviderFor(DailyTasks)
final dailyTasksProvider =
    AsyncNotifierProvider<DailyTasks, List<Task>>.internal(
  DailyTasks.new,
  name: r'dailyTasksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dailyTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DailyTasks = AsyncNotifier<List<Task>>;
String _$optionalTasksHash() => r'e801ad0703d15cfdd322dbed4c055e541ca67095';

/// See also [OptionalTasks].
@ProviderFor(OptionalTasks)
final optionalTasksProvider =
    AsyncNotifierProvider<OptionalTasks, List<Task>>.internal(
  OptionalTasks.new,
  name: r'optionalTasksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$optionalTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OptionalTasks = AsyncNotifier<List<Task>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
