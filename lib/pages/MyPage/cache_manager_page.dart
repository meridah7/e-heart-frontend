import 'package:flutter/material.dart';
import 'package:namer_app/services/cache_service.dart';

class CacheManagerPage extends StatefulWidget {
  @override
  _CacheManagerPageState createState() => _CacheManagerPageState();
}

class _CacheManagerPageState extends State<CacheManagerPage> {
  final CacheService _cacheService = CacheService();
  bool _isClearing = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('缓存管理'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '缓存说明',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '应用会自动缓存网络请求数据，以便在离线时使用。缓存数据默认保存1小时。',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 24),
            Card(
              child: ListTile(
                leading: Icon(Icons.delete_outline),
                title: Text('清除所有缓存'),
                subtitle: Text('删除所有已缓存的网络请求数据'),
                trailing: _isClearing 
                  ? CircularProgressIndicator(strokeWidth: 2)
                  : Icon(Icons.arrow_forward_ios, size: 16),
                onTap: _clearCache,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _clearCache() async {
    if (_isClearing) return;
    
    setState(() {
      _isClearing = true;
    });
    
    try {
      await _cacheService.clearCache();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('缓存已清除')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('清除缓存失败: $e')),
      );
    } finally {
      setState(() {
        _isClearing = false;
      });
    }
  }
} 