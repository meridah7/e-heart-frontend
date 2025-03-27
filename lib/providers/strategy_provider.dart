import 'package:flutter/foundation.dart';
import '../models/strategy_card.dart';
import '../services/api_service.dart';

class StrategyProvider with ChangeNotifier {
  final StrategyApiService apiService;

  List<StrategyCard> _strategyCards = [];

  List<StrategyCard> get strategyCards => _strategyCards;

  bool _isLoading = false;

  StrategyProvider({required this.apiService});

  bool get isLoading => _isLoading;

  Future<void> fetchStrategies() async {
    _isLoading = true;
    notifyListeners();
    try {
      List<StrategyCard> cardList = await apiService.fetchStrategies() ?? [];
      cardList.sort((a, b) => a.activityOrder.compareTo(b.activityOrder));
      _strategyCards = cardList;
    } catch (err) {
      print('Error in parse strategies $err');
      throw Exception(err);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateStrategy(StrategyCard strategy) async {
    try {
      await apiService.updateStrategy(strategy);
      await fetchStrategies();
    } catch (err) {
      print('Error in parse strategies $err');
      throw Exception(err);
    }
  }

  Future<void> deleteStrategy(StrategyCard strategy) async {
    try {
      await apiService.deleteStrategy(strategy);
      await fetchStrategies();
    } catch (err) {
      print('Error in parse strategies $err');
      throw Exception(err);
    }
  }

  Future<void> addStrategy(StrategyCard strategy) async {
    try {
      await apiService.addStrategy(strategy);
      await fetchStrategies();
    } catch (err) {
      print('Error in parse strategies $err');
      throw Exception(err);
    }
  }
}
