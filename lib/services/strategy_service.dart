import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
import 'package:namer_app/models/strategy_card.dart';
// import 'package:namer_app/services/api_service.dart';
import 'package:namer_app/services/api_endpoints.dart';
import 'dio_client.dart';

class StrategyService {
  static final DioClient dioClient = DioClient();

  static Future<bool> addStrategy(StrategyCard strategy) async {
    try {
      Response response = await dioClient.postRequest(
        ApiEndpoints.IMPULSE_STRATEGIES,
        {
          'activity_order': strategy.activityOrder,
          'custom_activity': strategy.customActivity,
          'details': strategy.details,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('Error adding strategy: $err');
      throw Exception(err);
    }
  }

  static Future<bool> deleteStrategy(StrategyCard strategy) async {
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

  static Future<List<StrategyCard>?> fetchStrategies() async {
    try {
      Response response =
          await dioClient.getRequest(ApiEndpoints.IMPULSE_STRATEGIES);
      if (response.statusCode == 200) {
        List<StrategyCard> strategyCardList = [];
        for (var strategy in response.data) {
          strategyCardList.add(StrategyCard.fromJson(strategy));
        }
        strategyCardList
            .sort((a, b) => a.activityOrder.compareTo(b.activityOrder));
        return strategyCardList;
      } else {
        throw Exception('Failed to load strategies');
      }
    } catch (err) {
      print('Error fetching strategies: $err');
      return [];
    }
  }

  static Future<bool> updateStrategy(StrategyCard strategy) async {
    try {
      Response response = await dioClient
          .putRequest('${ApiEndpoints.IMPULSE_STRATEGIES}/${strategy.id}', {
        "custom_activity": strategy.customActivity,
        "details": strategy.details,
        "activity_order": strategy.activityOrder,
      });
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

  static Future<bool> reorderStrategies(
      List<StrategyCard> newStrategyList) async {
    try {
      List<int?> orderList = newStrategyList.map((e) => e.id).toList();
      print('Reordering strategies: $orderList');
      Response response = await dioClient.putRequest(
        ApiEndpoints.IMPULSE_STRATEGIES_REORDER,
        {
          'strategy_order': orderList,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('Error reordering strategies: $err');
      throw Exception(err);
    }
  }
}
