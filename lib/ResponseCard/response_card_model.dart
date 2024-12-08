import 'package:flutter/material.dart';
import 'package:namer_app/utils/dio_client.dart';
import 'package:dio/dio.dart';

enum DetailScene { edit, add, check }

class ResponseCardModel {
  final String custom_activity;
  final String details;
  final int activity_order;
  final int? id;

  ResponseCardModel(
      {required this.custom_activity,
      required this.details,
      required this.activity_order,
      this.id});

  // 添加 fromJson 工厂构造函数
  factory ResponseCardModel.fromJson(Map<String, dynamic> json) {
    return ResponseCardModel(
      activity_order: json['activity_order'] as int,
      custom_activity: json['custom_activity'] as String,
      details: json['details'] as String,
      id: json['id'] as int,
    );
  }

  // 可选：添加 toJson 方法，用于将对象转换回 JSON
  Map<String, dynamic> toJson() {
    return {
      'activity_order': activity_order,
      'custom_activity': custom_activity,
      'details': details,
      'id': id,
    };
  }
}

class ResponseCardModelProvider with ChangeNotifier {
  final DioClient dioClient = DioClient();
  List<ResponseCardModel> _responseCardList = [];

  List<ResponseCardModel> get responseCardList => _responseCardList;

  Future<void> loadData() async {
    // 模拟获取数据，调用你的 dio 请求逻辑
    try {
      Response response =
          await dioClient.getRequest('/impulse/impulse-strategies');
      List<dynamic> data = response.data;

      _responseCardList =
          data.map((val) => ResponseCardModel.fromJson(val)).toList();

      // 按照 order 字段升序排序
      _responseCardList
          .sort((a, b) => a.activity_order.compareTo(b.activity_order));

      // 通知监听者数据已更新
      notifyListeners();
    } catch (e) {
      print('Error in fetching data $e');
      throw Exception(e);
    }
  }
}
