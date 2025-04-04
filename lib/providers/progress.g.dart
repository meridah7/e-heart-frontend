// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$progressHash() => r'08901edc9fea865db745d447f84deb9c30ff64dd';

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
String _$dailyTasksHash() => r'1e474aa1bfb948f62d9d3e893fdf0d941e3a084c';

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
String _$optionalTasksHash() => r'8ccb1b17c7629a70990f27e6266da13d0a1404a4';

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
