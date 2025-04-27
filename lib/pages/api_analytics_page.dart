import 'package:flutter/material.dart';
import 'package:namer_app/services/api_analytics.dart';

class ApiAnalyticsPage extends StatefulWidget {
  @override
  _ApiAnalyticsPageState createState() => _ApiAnalyticsPageState();
}

class _ApiAnalyticsPageState extends State<ApiAnalyticsPage> {
  Map<String, dynamic> _analyticsData = {};
  
  @override
  void initState() {
    super.initState();
    _loadAnalytics();
  }
  
  void _loadAnalytics() {
    setState(() {
      _analyticsData = ApiAnalytics.getAnalytics();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API 分析'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadAnalytics,
          ),
        ],
      ),
      body: _analyticsData.isEmpty
          ? Center(child: Text('暂无 API 分析数据'))
          : ListView.builder(
              itemCount: _analyticsData.length,
              itemBuilder: (context, index) {
                String endpoint = _analyticsData.keys.elementAt(index);
                Map<String, dynamic> data = _analyticsData[endpoint];
                
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          endpoint,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('请求次数: ${data['totalRequests']}'),
                            Text('平均响应时间: ${data['avgResponseTime'].toStringAsFixed(1)}ms'),
                          ],
                        ),
                        SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: 1.0 - (data['errorRate'] ?? 0),
                          color: _getColorForErrorRate(data['errorRate'] ?? 0),
                        ),
                        SizedBox(height: 4),
                        Text('成功率: ${((1 - (data['errorRate'] ?? 0)) * 100).toStringAsFixed(1)}%'),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ApiAnalytics.reset();
          _loadAnalytics();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('分析数据已重置')),
          );
        },
        child: Icon(Icons.delete),
      ),
    );
  }
  
  Color _getColorForErrorRate(double errorRate) {
    if (errorRate > 0.5) return Colors.red;
    if (errorRate > 0.2) return Colors.orange;
    return Colors.green;
  }
} 