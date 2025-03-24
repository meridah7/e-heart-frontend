import 'package:dio/dio.dart';
import 'package:namer_app/models/strategy_card.dart';
import 'package:namer_app/services/api_service.dart';
import 'package:namer_app/services/api_endpoints.dart';
import 'dio_client.dart';

class StrategyService implements StrategyApiService {
  final DioClient dioClient = DioClient();

  @override
  Future<bool> addStrategy(StrategyCard strategy) async {
    try {
      Response response = await dioClient.postRequest(
        ApiEndpoints.IMPULSE_STRATEGIES,
        {
          'activity_order': strategy.activityOrder,
          'custom_activity': strategy.customActivity,
          'details': strategy.details,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('Error adding strategy: $err');
      throw Exception(err);
    }
  }

  @override
  Future<bool> deleteStrategy(StrategyCard strategy) async {
    try {
      Response response = await dioClient.deleteRequest(
        '${ApiEndpoints.IMPULSE_STRATEGIES}/${strategy.id}',
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('Error deleting strategy: $err');
      throw Exception(err);
    }
  }

  @override
  Future<List<StrategyCard>?> fetchStrategies() async {
    try {
      Response response =
          await dioClient.getRequest(ApiEndpoints.IMPULSE_STRATEGIES);
      if (response.statusCode == 200) {
        final strategyCardList = strategyCardFromJson(response.data ?? []);
        return strategyCardList;
      } else {
        throw Exception('Failed to load strategies');
      }
    } catch (err) {
      print('Error fetching strategies: $err');
      return [];
    }
  }

  @override
  Future<bool> updateStrategy(StrategyCard strategy) async {
    try {
      Response response = await dioClient.putRequest(
        '${ApiEndpoints.IMPULSE_STRATEGIES}/${strategy.id}',
        strategy.toJson(),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('Error updating strategy: $err');
      throw Exception(err);
    }
  }
}
