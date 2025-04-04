import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:namer_app/services/dio_client.dart';
import 'package:namer_app/utils/error_handler.dart';
import 'package:namer_app/DailyDiet/diet_models.dart';
import 'package:intl/intl.dart';

class DietAnalytics extends StatefulWidget {
  @override
  _DietAnalyticsState createState() => _DietAnalyticsState();
}

class _DietAnalyticsState extends State<DietAnalytics> {
  bool _isLoading = true;
  dynamic _error;
  final DioClient dioClient = DioClient();
  
  // 分析数据
  Map<String, dynamic> _dietStats = {};
  List<DietTrend> _dietTrends = [];
  List<MealTypeStats> _mealTypeStats = [];
  
  @override
  void initState() {
    super.initState();
    _loadDietAnalytics();
  }
  
  Future<void> _loadDietAnalytics() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    try {
      // 获取过去30天的饮食数据
      final endDate = DateTime.now();
      final startDate = endDate.subtract(Duration(days: 30));
      
      final response = await dioClient.getRequest(
        '/diet_analytics/summary/${startDate.millisecondsSinceEpoch}/${endDate.millisecondsSinceEpoch}'
      );
      
      if (response.statusCode == 200) {
        setState(() {
          _dietStats = response.data['stats'];
          _dietTrends = (response.data['trends'] as List)
              .map((item) => DietTrend.fromJson(item))
              .toList();
          _mealTypeStats = (response.data['mealTypes'] as List)
              .map((item) => MealTypeStats.fromJson(item))
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
        ? ErrorHandler.buildErrorWidget(_error, _loadDietAnalytics)
        : SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryStats(),
                SizedBox(height: 24),
                _buildDietTrendsChart(),
                SizedBox(height: 24),
                _buildMealTypeDistribution(),
                SizedBox(height: 24),
                _buildInsightsSection(),
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
            Text('饮食概览', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('总餐次', '${_dietStats['totalMeals']}', Icons.restaurant),
                _buildStatItem('计划执行率', '${(_dietStats['planCompletionRate'] * 100).toStringAsFixed(1)}%', Icons.assignment_turned_in),
                _buildStatItem('平均暴食指数', '${_dietStats['avgBingeScore'].toStringAsFixed(1)}', Icons.trending_up),
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
  
  Widget _buildDietTrendsChart() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('饮食趋势 (过去30天)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                          // Show dates on x-axis
                          final weekDay = DateFormat('E').format(
                            DateTime.fromMillisecondsSinceEpoch(
                              _dietTrends[value.toInt() % _dietTrends.length].date
                            )
                          );
                          return Text(weekDay, style: TextStyle(fontSize: 10));
                        },
                        interval: 5,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _dietTrends.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value.bingeScore.toDouble());
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
  
  Widget _buildMealTypeDistribution() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('餐次分布', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: _mealTypeStats.map((stat) {
                    return PieChartSectionData(
                      value: stat.count.toDouble(),
                      title: '${stat.mealType}\n${stat.count}',
                      radius: 100,
                      color: _getMealTypeColor(stat.mealType),
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
  
  Color _getMealTypeColor(String mealType) {
    switch (mealType) {
      case '早餐': return Colors.orange;
      case '午餐': return Colors.green;
      case '晚餐': return Colors.purple;
      case '加餐': return Colors.blue;
      default: return Colors.grey;
    }
  }
  
  Widget _buildInsightsSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('个性化洞察', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            _buildInsightItem(
              '规律进餐',
              _dietStats['regularityScore'] > 0.7 
                ? '您的进餐时间非常规律，这有助于稳定血糖和控制食欲。' 
                : '提高进餐规律性可能有助于控制您的食欲和暴食冲动。',
              Icons.schedule,
              _dietStats['regularityScore'] > 0.7 ? Colors.green : Colors.orange,
            ),
            SizedBox(height: 12),
            _buildInsightItem(
              '暴食行为',
              _dietStats['avgBingeScore'] < 3 
                ? '您很少出现暴食行为，请继续保持！' 
                : '您的暴食指数略高，尝试识别暴食的触发因素并制定应对策略。',
              Icons.psychology,
              _dietStats['avgBingeScore'] < 3 ? Colors.green : Colors.orange,
            ),
            SizedBox(height: 12),
            _buildInsightItem(
              '计划执行',
              _dietStats['planCompletionRate'] > 0.8 
                ? '您非常好地执行了饮食计划，这是成功的关键！' 
                : '提高饮食计划的执行率可能会帮助您更好地控制饮食行为。',
              Icons.assignment_turned_in,
              _dietStats['planCompletionRate'] > 0.8 ? Colors.green : Colors.orange,
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

class DietTrend {
  final int date;
  final double bingeScore;
  final int mealCount;
  
  DietTrend({required this.date, required this.bingeScore, required this.mealCount});
  
  factory DietTrend.fromJson(Map<String, dynamic> json) {
    return DietTrend(
      date: json['date'],
      bingeScore: json['bingeScore'].toDouble(),
      mealCount: json['mealCount'],
    );
  }
}

class MealTypeStats {
  final String mealType;
  final int count;
  
  MealTypeStats({required this.mealType, required this.count});
  
  factory MealTypeStats.fromJson(Map<String, dynamic> json) {
    return MealTypeStats(
      mealType: json['mealType'],
      count: json['count'],
    );
  }
} 