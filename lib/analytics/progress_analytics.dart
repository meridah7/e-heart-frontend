import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:namer_app/services/dio_client.dart';
import 'package:namer_app/utils/error_handler.dart';
import 'package:namer_app/models/user_progress.dart';
import 'package:intl/intl.dart';

class ProgressAnalytics extends StatefulWidget {
  @override
  _ProgressAnalyticsState createState() => _ProgressAnalyticsState();
}

class _ProgressAnalyticsState extends State<ProgressAnalytics> {
  bool _isLoading = true;
  dynamic _error;
  final DioClient dioClient = DioClient();
  
  // 分析数据
  List<ProgressPoint> _progressHistory = [];
  Map<String, dynamic> _taskCompletion = {};
  Map<String, dynamic> _progressPrediction = {};
  
  @override
  void initState() {
    super.initState();
    _loadProgressAnalytics();
  }
  
  Future<void> _loadProgressAnalytics() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    try {
      final response = await dioClient.getRequest('/users/progress/analytics');
      
      if (response.statusCode == 200) {
        setState(() {
          _progressHistory = (response.data['progressHistory'] as List)
              .map((item) => ProgressPoint.fromJson(item))
              .toList();
          _taskCompletion = response.data['taskCompletion'];
          _progressPrediction = response.data['progressPrediction'];
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
        ? ErrorHandler.buildErrorWidget(_error, _loadProgressAnalytics)
        : SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProgressTracker(),
                SizedBox(height: 24),
                _buildTaskCompletionRates(),
                SizedBox(height: 24),
                _buildProgressPrediction(),
                SizedBox(height: 24),
                _buildAchievementInsights(),
              ],
            ),
          );
  }
  
  Widget _buildProgressTracker() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('进度追踪', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Container(
              height: 250,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 && value.toInt() < _progressHistory.length) {
                            final date = DateTime.fromMillisecondsSinceEpoch(
                              _progressHistory[value.toInt()].timestamp
                            );
                            return Text(
                              DateFormat('MM/dd').format(date),
                              style: TextStyle(fontSize: 10),
                            );
                          }
                          return Text('');
                        },
                        interval: 5,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _progressHistory.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value.progressValue.toDouble());
                      }).toList(),
                      isCurved: true,
                      color: Theme.of(context).primaryColor,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: true, color: Theme.of(context).primaryColor.withOpacity(0.2)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTaskCompletionRates() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('任务完成率', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                          toY: (_taskCompletion['dailyTasks'] * 100).toDouble(),
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
                          toY: (_taskCompletion['weeklyTasks'] * 100).toDouble(),
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
                          toY: (_taskCompletion['dietLogs'] * 100).toDouble(),
                          color: Colors.orange,
                          width: 20,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                        )
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                          toY: (_taskCompletion['impulseRecords'] * 100).toDouble(),
                          color: Colors.purple,
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
                          List<String> titles = ['日常任务', '每周任务', '饮食记录', '冲动记录'];
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
  
  Widget _buildProgressPrediction() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('进度预测', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.timeline, color: Theme.of(context).primaryColor, size: 36),
              title: Text('预计完成时间'),
              subtitle: Text('${_progressPrediction['estimatedCompletionDate']}'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.speed, color: Colors.orange, size: 36),
              title: Text('当前进度速率'),
              subtitle: Text('${_progressPrediction['progressRate']} 天/阶段'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.insights, color: Colors.purple, size: 36),
              title: Text('下一阶段预计到达'),
              subtitle: Text('${_progressPrediction['nextLevelETA']}'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAchievementInsights() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('成就与洞察', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            _buildInsightItem(
              '连续记录',
              '您已连续记录饮食 ${_taskCompletion['streak']} 天，真棒！',
              Icons.emoji_events,
              Colors.amber,
            ),
            SizedBox(height: 12),
            _buildInsightItem(
              '任务完成率',
              '您的任务完成率高于 ${(_taskCompletion['completionPercentile']).toStringAsFixed(0)}% 的用户',
              Icons.people,
              Colors.blue,
            ),
            SizedBox(height: 12),
            _buildInsightItem(
              '持续进步',
              _progressPrediction['isOnTrack'] 
                ? '您的进度符合预期，继续保持！' 
                : '您的进度略微落后，尝试更规律地完成任务。',
              Icons.trending_up,
              _progressPrediction['isOnTrack'] ? Colors.green : Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInsightItem(String title, String description, IconData icon, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(description, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
            ],
          ),
        ),
      ],
    );
  }
}

class ProgressPoint {
  final int timestamp;
  final int progressValue;
  
  ProgressPoint({required this.timestamp, required this.progressValue});
  
  factory ProgressPoint.fromJson(Map<String, dynamic> json) {
    return ProgressPoint(
      timestamp: json['timestamp'],
      progressValue: json['progressValue'],
    );
  }
} 