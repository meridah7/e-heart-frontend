import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static const String _prefix = 'cache_';
  static const Duration defaultExpiry = Duration(hours: 1);

  Future<void> cacheResponse(String key, dynamic data, {Duration? expiry}) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheData = {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'expiry': (expiry ?? defaultExpiry).inMilliseconds,
    };
    await prefs.setString(_prefix + key, jsonEncode(cacheData));
  }

  Future<dynamic> getCachedResponse(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedString = prefs.getString(_prefix + key);
    
    if (cachedString == null) return null;
    
    final cachedData = jsonDecode(cachedString);
    final timestamp = cachedData['timestamp'];
    final expiry = cachedData['expiry'];
    
    if (DateTime.now().millisecondsSinceEpoch - timestamp > expiry) {
      // Cache expired
      await prefs.remove(_prefix + key);
      return null;
    }
    
    return cachedData['data'];
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith(_prefix)) {
        await prefs.remove(key);
      }
    }
  }
} 