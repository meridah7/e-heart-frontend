import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static void showToast(
    String message, [
    //方括号里是可选参数，可以不填，等号右边是默认值
    Toast time = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.CENTER,
    Color backColor = Colors.black45,
    Color textColor = Colors.white,
  ]) {
    Fluttertoast.showToast(
        msg: message, //消息内容
        toastLength: time, //停留时间
        gravity: gravity, //出现的位置
        timeInSecForIosWeb: 1,
        backgroundColor: backColor, //背景色
        textColor: textColor, //前景色
        fontSize: 16.0); //文本字号
  }
}

Widget customLoading() {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      strokeWidth: 2.0,
    ),
  );
}

Color generateColor(String? type) {
  final hash = type.hashCode;
  return Color.fromRGBO(
    (hash & 0xFF0000) >> 16,
    (hash & 0x00FF00) >> 8,
    hash & 0x0000FF,
    1,
  );
}

List<MapEntry<K, V>> mapToEntryList<K, V>(Map<K, V>? map) {
  return map?.entries.toList() ?? [];
}

/// 将 List<Map<String, dynamic>> 转换为 List<MapEntry<K, V>>
/// [keyName]：Map中作为键的字段名，[valueName]：Map中作为值的字段名
/// 类型不匹配或字段缺失时返回空MapEntry（避免崩溃）
List<MapEntry<K, V>> convertListToMapEntries<K, V>(
  List<Map<String, dynamic>> sourceList, {
  required String keyName,
  required String valueName,
}) {
  return sourceList.map((item) {
    final key = item[keyName];
    final value = item[valueName];
    // 类型检查 + 空值处理
    if (key is K && value is V) {
      return MapEntry<K, V>(key, value);
    }
    // 可选：日志记录错误（生产环境可移除）
    debugPrint('Invalid type for $keyName or $valueName in $item');
    return MapEntry<K, V>(null as K, null as V); // 返回安全空值
  }).toList();
}
