import 'package:flutter/material.dart';
import 'package:namer_app/pages/DietaryAnalysis/daily.dart';
import 'package:fl_chart/fl_chart.dart';
import 'models.dart';

class DietaryAnalysisPage extends StatefulWidget {
  @override
  _DietaryAnalysisPageState createState() => _DietaryAnalysisPageState();
}

class _DietaryAnalysisPageState extends State<DietaryAnalysisPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet Analysis ', style: TextStyle(color: Colors.black)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white, // 选中的标签字体颜色
          unselectedLabelColor: Colors.grey, // 未选中的标签字体颜色
          indicator: BoxDecoration(
            color: const Color.fromARGB(255, 130, 108, 169), // 选中的标签背景颜色
            borderRadius: BorderRadius.circular(10), // 标签圆角
          ),
          tabs: [
            Tab(text: 'Weeks'),
            Tab(text: 'Months'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          WeeklyView(),
          MonthlyView(),
        ],
      ),
    );
  }
}

// 你的每日视图和每周视图的实现
class MonthlyView extends StatefulWidget {
  @override
  _MonthlyViewState createState() => _MonthlyViewState();
}

class _MonthlyViewState extends State<MonthlyView> {
  String selectedChart = 'Binge Eating';

  @override
  Widget build(BuildContext context) {
    List<BingeEatingEvent> bingeEatingEvents = [
      BingeEatingEvent('08:00 AM', '早餐后感到不舒服'),
      BingeEatingEvent('12:30 PM', '午餐后因为作业压力暴食'),
      BingeEatingEvent('07:00 PM', '晚饭后暴食'),
    ];

    // List<EatingEmotionData> eatingEmotions = [
    //   EatingEmotionData(DateTime(2024, 1, 1, 8, 0), 3), // 早餐后情绪
    //   EatingEmotionData(DateTime(2024, 1, 1, 12, 30), 5), // 午餐后情绪
    //   EatingEmotionData(DateTime(2024, 1, 1, 19, 0), 2), // 晚饭后情绪
    //   // ... 更多数据
    // ];

    List<BingeEatingEmotionData> bingeEatingEmotions = [
      BingeEatingEmotionData("08:00 AM", "焦虑"),
      BingeEatingEmotionData("01:00 PM", "难过"),
      BingeEatingEmotionData("09:00 PM", "开心"),
      // ... 其他数据
    ];

    return Column(
      children: [
        DropdownButton<String>(
          value: selectedChart,
          onChanged: (String? newValue) {
            setState(() {
              selectedChart = newValue!;
            });
          },
          items: <String>['暴食次数', '暴食心情', '暴食情绪']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        Expanded(child: BingeEatingList(bingeEatingEvents)
            // 需要实现
            ),
      ],
    );
  }
}

class WeeklyView extends StatefulWidget {
  @override
  _WeeklyViewState createState() => _WeeklyViewState();
}

class _WeeklyViewState extends State<WeeklyView> {
  String selectedChart = 'Binge Eating'; // 默认选项

  @override
  Widget build(BuildContext context) {
    List<BingeEatingWeeklyData> bingeData = [
      BingeEatingWeeklyData("Monday", 3),
      BingeEatingWeeklyData("周二", 2),
      BingeEatingWeeklyData("周三", 5),
      BingeEatingWeeklyData("周四", 1),
      BingeEatingWeeklyData("周五", 4),
      BingeEatingWeeklyData("周六", 2),
      BingeEatingWeeklyData("周日", 3),
    ];

    List<WeeklyData> clearanceData = [
      WeeklyData("周一", 1),
      WeeklyData("周二", 3),
      WeeklyData("周三", 0),
      WeeklyData("周四", 2),
      WeeklyData("周五", 1),
      WeeklyData("周六", 4),
      WeeklyData("周日", 2),
    ];

    List<EatingEmotionData> eatingEmotionsData = [
      EatingEmotionData("周一", {"开心": 3, "伤心": 1, "难过": 2}),
      EatingEmotionData("周二", {"开心": 2, "伤心": 2, "难过": 1}),
      EatingEmotionData("周三", {"开心": 1, "伤心": 3, "难过": 1}),
    ];

    return Column(
      children: <Widget>[
        DropdownButton<String>(
          value: selectedChart,
          onChanged: (String? newValue) {
            setState(() {
              selectedChart = newValue!;
            });
          },
          items: <String>[
            'Binge Eating',
            'Food Clearance',
            // ... 更多选项
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        Expanded(
          child: _buildChart(selectedChart, bingeData, clearanceData),
        ),
      ],
    );
  }

  Widget _buildChart(String chartType, List<BingeEatingWeeklyData> bingeData,
      List<WeeklyData> clearanceData) {
    switch (chartType) {
      case 'Binge Eating':
        return WeeklyBingeEatingChart(data: bingeData);
      case 'Food Clearance':
        return WeeklyFoodClearanceChart(data: clearanceData); // 需要实现
      case 'Binge Emotion':
        return WeeklyFoodClearanceChart(data: clearanceData);
      // // 添加更多的图表类型...
      default:
        return Container(); // 默认空视图
    }
  }
}

class BingeEatingEventList extends StatelessWidget {
  final List<BingeEatingEvent> events;

  BingeEatingEventList(this.events);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: events
          .map((event) => ListTile(
                title: Text(event.time), // 暴食的时间
                subtitle: Text(event.description), // 描述
              ))
          .toList(),
    );
  }
}

class WeeklyBingeEatingChart extends StatelessWidget {
  final List<BingeEatingWeeklyData> data;

  WeeklyBingeEatingChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _getMaxValue() * 1.2,
          barGroups: _getBarGroups(),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value < 0 || value >= data.length) return const Text('');
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      data[value.toInt()].dayOfWeek,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
                reservedSize: 30,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  );
                },
                reservedSize: 30,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
        ),
      ),
    );
  }

  double _getMaxValue() {
    return data.map((e) => e.count.toDouble()).reduce((a, b) => a > b ? a : b);
  }

  List<BarChartGroupData> _getBarGroups() {
    return data.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: item.count.toDouble(),
            color: Colors.purple, // Changed to match app theme
            width: 20,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }
}

class BingeEatingWeeklyData {
  final String dayOfWeek;
  final int count;

  BingeEatingWeeklyData(this.dayOfWeek, this.count);
}

class WeeklyFoodClearanceChart extends StatelessWidget {
  final List<WeeklyData> data;

  WeeklyFoodClearanceChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _getMaxValue() * 1.2,
          barGroups: _getBarGroups(),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value < 0 || value >= data.length) return const Text('');
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      data[value.toInt()].dayOfWeek,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
                reservedSize: 30,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  );
                },
                reservedSize: 30,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
        ),
      ),
    );
  }

  double _getMaxValue() {
    return data.map((e) => e.count.toDouble()).reduce((a, b) => a > b ? a : b);
  }

  List<BarChartGroupData> _getBarGroups() {
    return data.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: item.count.toDouble(),
            color: Colors.blue,
            width: 20,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }
}

class EatingEmotionChart extends StatelessWidget {
  final List<EatingEmotionData> data;
  final List<Color> emotionColors = [
    Colors.green, // 开心
    Colors.red, // 伤心
    Colors.blue, // 难过
  ];

  EatingEmotionChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _getMaxValue() * 1.2,
          barGroups: _getBarGroups(),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value < 0 || value >= data.length) return const Text('');
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      data[value.toInt()].dayOfWeek,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
                reservedSize: 30,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  );
                },
                reservedSize: 30,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
        ),
      ),
    );
  }

  double _getMaxValue() {
    double maxValue = 0;
    for (var item in data) {
      final sum = item.emotions.values.reduce((a, b) => a + b);
      if (sum > maxValue) maxValue = sum.toDouble();
    }
    return maxValue;
  }

  List<BarChartGroupData> _getBarGroups() {
    final emotions = ["开心", "伤心", "难过"];

    return data.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      List<BarChartRodData> bars = [];
      for (int i = 0; i < emotions.length; i++) {
        final emotion = emotions[i];
        final value = item.emotions[emotion] ?? 0;

        bars.add(
          BarChartRodData(
            toY: value.toDouble(),
            color: emotionColors[i],
            width: 15,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }

      return BarChartGroupData(
        x: index,
        barRods: bars,
        barsSpace: 4,
      );
    }).toList();
  }
}
