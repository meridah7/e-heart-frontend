import 'package:json_annotation/json_annotation.dart';

class StringToDoubleConverter implements JsonConverter<double, Object> {
  const StringToDoubleConverter();

  @override
  double fromJson(Object json) {
    print('covert json to double $json');
    if (json is String) {
      return double.tryParse(json) ?? 0.0; // 字符串转换为 double
    } else if (json is num) {
      return json.toDouble(); // 如果是数字，直接转换
    }
    throw FormatException('Invalid type for double: $json');
  }

  @override
  Object toJson(double object) => object; // double 转回 JSON
}
