import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:namer_app/services/dio_client.dart';
import 'package:namer_app/utils/error_handler.dart';

class ImpulseAnalytics extends StatefulWidget {
  @override
  _ImpulseAnalyticsState createState() => _ImpulseAnalyticsState();
}

class _ImpulseAnalyticsState extends State<ImpulseAnalytics> {
  bool _isLoading = true;
  dynamic _error;
  final DioClient dioClient = DioClient();
  
  // 分析数据
  Map<String, dynamic> _impulseStats = {};
  List<String> _commonTriggers = [];
  List<TimeOfDayData> _timeDistribution = [];
  List<EmotionData> _emotionDistribution = [];
  
  @override
  void initState() {
    super.initState();
    _loadImpulseAnalytics();
  }
  
  Future<void> _loadImpulseAnalytics() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    try {
      // 获取过去30天的冲动记录分析
      final endDate = DateTime.now();
      final startDate = endDate.subtract(Duration(days: 30));
      
      final response = await dioClient.getRequest(
        '/impulse/analytics/${startDate.millisecondsSinceEpoch}/${endDate.millisecondsSinceEpoch}'
      );
      
      if (response.statusCode == 200) {
        setState(() {
          _impulseStats = response.data['stats'];
          _commonTriggers = List<String>.from(response.data['commonTriggers']);
          _timeDistribution = (response.data['timeDistribution'] as List)
              .map((item) => TimeOfDayData.fromJson(item))
              .toList();
          _emotionDistribution = (response.data['emotionDistribution'] as List)
              .map((item) => EmotionData.fromJson(item))
              .toList();
          _isLoading = false;
        });
      }
    } catch (e, stackTrace) {
      ErrorHandler.logError(e, stackTrace: stackTrace);
      setState(() {
        _error = e;
        _isLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return _isLoading
      ? Center(child: CircularProgressIndicator())
      : _error != null
        ? ErrorHandler.buildErrorWidget(_error, _loadImpulseAnalytics)
        : SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryStats(),
                SizedBox(height: 24),
                _buildTimeOfDayDistribution(),
                SizedBox(height: 24),
                _buildEmotionalTriggers(),
                SizedBox(height: 24),
                _buildCommonTriggers(),
                SizedBox(height: 24),
                _buildStrategyEffectiveness(),
              ],
            ),
          );
  }
  
  Widget _buildSummaryStats() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('冲动概览', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('记录总数', '${_impulseStats['totalRecords']}', Icons.assignment),
                _buildStatItem('平均强度', '${_impulseStats['avgIntensity'].toStringAsFixed(1)}', Icons.trending_up),
                _buildStatItem('成功应对率', '${(_impulseStats['successRate'] * 100).toStringAsFixed(1)}%', Icons.check_circle),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Theme.of(context).primaryColor),
        SizedBox(height: 8),
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }
  
  Widget _buildTimeOfDayDistribution() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('冲动发生时间分布', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Container(
              height: 250,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.center,
                  maxY: _timeDistribution.map((d) => d.count).reduce((a, b) => a > b ? a : b) * 1.2,
                  barGroups: _timeDistribution.asMap().entries.map((entry) {
                    return BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value.count.toDouble(),
                          color: Theme.of(context).primaryColor,
                          width: 20,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                        )
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(_timeDistribution[value.toInt()].timeSlot, 
                                 style: TextStyle(fontSize: 10));
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEmotionalTriggers() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('情绪触发因素', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Container(
              height: 250,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: _emotionDistribution.map((emotion) {
                    return PieChartSectionData(
                      value: emotion.count.toDouble(),
                      title: '${emotion.emotion}\n${emotion.count}',
                      radius: 100,
                      color: _getEmotionColor(emotion.emotion),
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Color _getEmotionColor(String emotion) {
    switch (emotion) {
      case '愤怒': return Colors.red;
      case '悲伤': return Colors.blue;
      case '焦虑': return Colors.purple;
      case '无聊': return Colors.grey;
      case '孤独': return Colors.indigo;
      case '疲惫': return Colors.brown;
      default: return Colors.teal;
    }
  }
  
  Widget _buildCommonTriggers() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('常见触发因素', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Column(
              children: _commonTriggers.asMap().entries.map((entry) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${entry.key + 1}'),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  title: Text(entry.value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStrategyEffectiveness() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('应对策略效果分析', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Container(
              height: 250,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.center,
                  maxY: 100,
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: (_impulseStats['strategyEffectiveness']['distraction'] * 100).toDouble(),
                          color: Colors.blue,
                          width: 20,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                        )
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: (_impulseStats['strategyEffectiveness']['relaxation'] * 100).toDouble(),
                          color: Colors.green,
                          width: 20,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                        )
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: (_impulseStats['strategyEffectiveness']['cognitive'] * 100).toDouble(),
                          color: Colors.purple,
                          width: 20,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                        )
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                          toY: (_impulseStats['strategyEffectiveness']['social'] * 100).toDouble(),
                          color: Colors.orange,
                          width: 20,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                        )
                      ],
                    ),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          List<String> titles = ['转移注意', '放松技巧', '认知重构', '社交支持'];
                          return Text(titles[value.toInt()], style: TextStyle(fontSize: 10));
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeOfDayData {
  final String timeSlot;
  final int count;
  
  TimeOfDayData({required this.timeSlot, required this.count});
  
  factory TimeOfDayData.fromJson(Map<String, dynamic> json) {
    return TimeOfDayData(
      timeSlot: json['timeSlot'],
      count: json['count'],
    );
  }
}

class EmotionData {
  final String emotion;
  final int count;
  
  EmotionData({required this.emotion, required this.count});
  
  factory EmotionData.fromJson(Map<String, dynamic> json) {
    return EmotionData(
      emotion: json['emotion'],
      count: json['count'],
    );
  }
} 