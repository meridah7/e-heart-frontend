import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart' as charts;

enum ChartOrientation { horizontal, vertical, pie }

class LegendWidget extends StatelessWidget {
  const LegendWidget({
    super.key,
    required this.name,
    required this.color,
  });
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          name,
          style: const TextStyle(
            color: Color(0xff757391),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class LegendsListWidget extends StatelessWidget {
  const LegendsListWidget({
    super.key,
    required this.legends,
  });
  final List<Legend> legends;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: legends
          .map(
            (e) => LegendWidget(
              name: e.name,
              color: e.color,
            ),
          )
          .toList(),
    );
  }
}

class Legend {
  Legend(this.name, this.color);
  final String name;
  final Color color;
}

class PieData {
  final String category;
  final double value;
  final Color color;

  PieData(this.category, this.value, this.color);
}

// PieChartWidget：通用的扇形图组件
class PieChartWidget extends StatelessWidget {
  final List<PieData> data;

  const PieChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double total = data.fold(0, (sum, item) => sum + item.value);

    return SizedBox(
      height: 260,
      child: AspectRatio(
        aspectRatio: 1,
        child: charts.PieChart(
          charts.PieChartData(
            sections: _getSections(total),
            sectionsSpace: 2,
            centerSpaceRadius: 40,
            startDegreeOffset: -90,
          ),
        ),
      ),
    );
  }

  List<charts.PieChartSectionData> _getSections(double total) {
    return data.map((item) {
      final percentage = (item.value / total * 100).toStringAsFixed(1);
      return charts.PieChartSectionData(
        value: item.value,
        title: '${item.category}\n$percentage%',
        titleStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        radius: 100,
        color: item.color,
      );
    }).toList();
  }
}

class BarData {
  final String label;
  final int value;
  final Color color;

  BarData(this.label, this.value, this.color);
}

class BarChartWidget extends StatelessWidget {
  final List<BarData> data;
  final bool isVertical;

  const BarChartWidget({
    Key? key,
    required this.data,
    this.isVertical = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.8,
            child: charts.BarChart(
              charts.BarChartData(
                alignment: charts.BarChartAlignment.spaceAround,
                titlesData: _getTitlesData(),
                borderData: charts.FlBorderData(show: true),
                barGroups: _getBarGroups(),
                gridData: charts.FlGridData(show: true),
              ),
            ),
          ),
        ],
      ),
    );
  }

  charts.FlTitlesData _getTitlesData() {
    return charts.FlTitlesData(
      show: true,
      bottomTitles: charts.AxisTitles(
        sideTitles: charts.SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Transform.rotate(
                // angle: pi / 4, // 45度角旋转
                angle: 0,
                child: Text(
                  data[value.toInt()].label,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            );
          },
          reservedSize: 42,
        ),
      ),
      leftTitles: charts.AxisTitles(
          sideTitles: charts.SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: TextStyle(fontSize: 12),
              );
            },
          ),
          axisNameSize: 22),
      rightTitles: charts.AxisTitles(
        sideTitles: charts.SideTitles(showTitles: false),
      ),
      topTitles: charts.AxisTitles(
        sideTitles: charts.SideTitles(showTitles: false),
      ),
    );
  }

  List<charts.BarChartGroupData> _getBarGroups() {
    return data.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return charts.BarChartGroupData(
        x: index,
        barRods: [
          charts.BarChartRodData(
            toY: item.value.toDouble(),
            color: item.color,
            width: 24,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }
}

// ImpulseTypePieChart：冲动种类分布（扇形图）
class ImpulseTypePieChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  ImpulseTypePieChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> typeCounts = {};

    for (var item in data) {
      final type = item['category'];
      typeCounts[type] = (typeCounts[type] ?? 0) + 1;
    }

    print('typeCounts $typeCounts');

    final List<PieData> pieData = typeCounts.entries.map((entry) {
      return PieData(entry.key, entry.value,
          entry.key.contains('暴食冲动') ? Colors.blue : Colors.red);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LegendsListWidget(
              legends: [Legend('暴食冲动', Colors.blue), Legend('其他', Colors.red)]),
          PieChartWidget(data: pieData)
        ],
      ),
    );
  }
}

// DayOfWeekBarChart：冲动时间——星期分布（条形图）
class DayOfWeekBarChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  DayOfWeekBarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final Map<String, int> dayCounts = {};

    for (var item in data) {
      final day = item['label'];
      dayCounts[day] = (item['value'] ?? 0);
    }

    final barData = dayCounts.entries.map((entry) {
      return BarData(entry.key, entry.value, Colors.blue);
    }).toList();

    return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LegendsListWidget(legends: [Legend('冲动时间——星期分布', Colors.blue)]),
            BarChartWidget(data: barData),
          ],
        ));
  }
}

// TimeOfDayBarChart：冲动时间——一天内的时间段分布（条形图）
class TimeOfDayBarChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  TimeOfDayBarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final Map<String, int> timeCounts = {};

    for (var item in data) {
      final time = item['label'];
      timeCounts[time] = (item['value'] ?? 0);
    }

    final barData = timeCounts.entries.map((entry) {
      return BarData(entry.key, entry.value, Colors.green);
    }).toList();

    return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LegendsListWidget(
                legends: [Legend('冲动时间——一天内时间段分布', Colors.green)]),
            BarChartWidget(data: barData),
          ],
        ));
  }
}

// IntensityBarChart：冲动强烈程度分布（条形图）
class IntensityBarChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  IntensityBarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final Map<int, int> intensityCounts = {};

    for (var item in data) {
      final intensity = item['intensity'];
      intensityCounts[intensity] = (intensityCounts[intensity] ?? 0) + 1;
    }

    final barData = intensityCounts.entries.map((entry) {
      return BarData('Intensity ${entry.key}', entry.value, Colors.orange);

      // return {
      //   'label': 'Intensity ${entry.key}',
      //   'value': entry.value,
      //   'color': Colors.orange,
      // };
    }).toList();

    return BarChartWidget(data: barData);
  }
}
