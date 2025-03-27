import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:namer_app/services/strategy_service.dart';
import 'package:namer_app/models/strategy_card.dart';

part 'strategy_list.g.dart';

@riverpod
class StrategyList extends _$StrategyList {
  @override
  Future<List<StrategyCard>> build() async {
    return await StrategyService.fetchStrategies() ?? [];
  }

  Future<void> updateStrategy(StrategyCard strategy) async {
    await StrategyService.updateStrategy(strategy);
    ref.invalidateSelf();
    await future;
  }

  Future<void> deleteStrategy(StrategyCard strategy) async {
    await StrategyService.deleteStrategy(strategy);
    ref.invalidateSelf();
    await future;
  }

  Future<bool> addStrategy(StrategyCard strategy) async {
    bool res = await StrategyService.addStrategy(strategy);
    ref.invalidateSelf();
    await future;
    return res;
  }

  Future<bool> addNewStrategy() async {
    bool res = await addStrategy(StrategyCard(
      customActivity: '请填写你的冲动应对策略',
      details: '请填应对策略的详细执行方法',
      activityOrder: state.value?.length ?? 0,
    ));
    return res;
  }

  Future<void> reorderStrategies(List<StrategyCard> strategies) async {
    setList(strategies);
    await StrategyService.reorderStrategies(strategies);
    ref.invalidateSelf();
    await future;
  }

  void setList(List<StrategyCard> list) async {
    state = AsyncData(list);
  }
}
