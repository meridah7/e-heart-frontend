// This class maintains a singleton about user preferences
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Preferences {
  SharedPreferences? _prefs;
  // Use UserName to distinguish between different user data
  final String namespace;

  // Private constructor with an asynchronous initialization
  Preferences._internal(this.namespace);

  // Static variable to hold the instance
  static Preferences? _instance;

  static Future<Preferences> getInstance({required String namespace}) async {
    if (_instance == null || _instance!.namespace != namespace) {
      _instance = Preferences._internal(namespace);
      await _instance!._init(); // Initialize SharedPreferences

      // === prefs registry
      // 用户 id
      if (_instance!.getData('completedTaskAnswers') == null) {
        _instance!.setData('userId', '');
      }
      // 用户昵称
      if (_instance!.getData('username') == null) {
        _instance!.setData('username', '');
      }
      // 用户邮箱
      if (_instance!.getData('email') == null) {
        _instance!.setData('email', '');
      }
      // 用户进度到第几天了
      if (_instance!.getData('progress') == null) {
        _instance!.setData('progress', 0);
      }
      // 用户当天完成的任务 ID 列表（只会保存当天的信息，因为不需要过去天数完成的任务信息）
      if (_instance!.getData('progressLastUpdatedDate') == null) {
        _instance!.setData('progressLastUpdatedDate', '');
      }
      // 用户当前天数完成的任务 ID 列表
      if (_instance!.getData('finishedTaskIds') == null) {
        _instance!.setData('finishedTaskIds', []);
      }
      // 用户填写的答案
      if (_instance!.getData('completedTaskAnswers') == null) {
        _instance!.setData('completedTaskAnswers', {});
      }
    }
    return _instance!;
  }

  // Initialization method for SharedPreferences
  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Set data method for various types
  Future<void> setData(String key, dynamic value) async {
    if (_prefs == null) {
      throw Exception("SharedPreferences not initialized. Call init() first.");
    }

    String fullKey = '';

    if (value is String) {
      fullKey = 'String_${namespace}_$key';
      await _prefs!.setString(fullKey, value);
    } else if (value is int) {
      fullKey = 'Int_${namespace}_$key';
      await _prefs!.setInt(fullKey, value);
    } else if (value is double) {
      fullKey = 'Double_${namespace}_$key';
      await _prefs!.setDouble(fullKey, value);
    } else if (value is bool) {
      fullKey = 'Bool_${namespace}_$key';
      await _prefs!.setBool(fullKey, value);
    } else if (value is List<String>) {
      fullKey = 'List<String>_${namespace}_$key';
      await _prefs!.setStringList(fullKey, value);
    } else if (value is List || value is Map) {
      fullKey = 'JSON_${namespace}_$key';
      await _prefs!.setString(fullKey, jsonEncode(value));
    } else if (value == null || value == null) {
      return;
    } else {
      throw ArgumentError('Unsupported value type');
    }
  }

  // Get data method without needing a type
  dynamic getData(String key) {
    if (_prefs == null) {
      throw Exception("SharedPreferences not initialized. Call init() first.");
    }

    String? fullKey = _prefs!
        .getKeys()
        .firstWhere((k) => k.contains('_${namespace}_$key'), orElse: () => '');

    if (fullKey.isEmpty) {
      return null;
    }

    if (fullKey.startsWith('String_')) {
      return _prefs!.getString(fullKey);
    } else if (fullKey.startsWith('Int_')) {
      return _prefs!.getInt(fullKey);
    } else if (fullKey.startsWith('Double_')) {
      return _prefs!.getDouble(fullKey);
    } else if (fullKey.startsWith('Bool_')) {
      return _prefs!.getBool(fullKey);
    } else if (fullKey.startsWith('List<String>_')) {
      return _prefs!.getStringList(fullKey);
    } else if (fullKey.startsWith('JSON_')) {
      String? jsonString = _prefs!.getString(fullKey);
      return jsonString != null ? jsonDecode(jsonString) : null;
    } else {
      throw ArgumentError('Unsupported type found for the key: $key');
    }
  }

  String? getNamespace() {
    return namespace;
  }

  // Method to get all keys
  Set<String> getAllKeys() {
    if (_prefs == null) {
      throw Exception("SharedPreferences not initialized. Call init() first.");
    }
    return _prefs!.getKeys();
  }

  // Check if there is a corresponding key
  bool hasKey(String key) {
    String? fullKey = _prefs!
        .getKeys()
        .firstWhere((k) => k.contains('_${namespace}_$key'), orElse: () => '');
    return fullKey.isNotEmpty;
  }

  // Method to delete a key
  Future<void> deleteKey(String key) async {
    if (_prefs == null) {
      throw Exception("SharedPreferences not initialized. Call init() first.");
    }

    String? fullKey = _prefs!
        .getKeys()
        .firstWhere((k) => k.contains('_${namespace}_$key'), orElse: () => '');

    if (fullKey.isNotEmpty) {
      await _prefs!.remove(fullKey);
    }
  }

  Future<void> deleteAllKeys() async {
    if (_prefs == null) {
      throw Exception("SharedPreferences not initialized. Call init() first.");
    }

    Set<String> allKeys = _prefs!.getKeys();
    List<String> keysToDelete =
        allKeys.where((key) => key.contains('_${namespace}_')).toList();

    for (String key in keysToDelete) {
      await _prefs!.remove(key);
    }
  }
}
