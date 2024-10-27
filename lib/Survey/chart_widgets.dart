import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

enum ChartOrientation { horizontal, vertical, pie }

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
    final List<charts.Series<PieData, String>> series = [
      charts.Series<PieData, String>(
        id: 'PieChart',
        domainFn: (datum, _) => datum.category,
        measureFn: (datum, _) => datum.value,
        colorFn: (datum, _) => charts.ColorUtil.fromDartColor(datum.color),
        data: data, // 确保 data 是 List<PieData> 类型
        labelAccessorFn: (datum, _) => '${datum.category}: ${datum.value}',
      ),
    ];

    return SizedBox(
      height: 300,
      child: charts.PieChart<String>(
        series,
        animate: true,
        defaultRenderer: charts.ArcRendererConfig(
          arcRendererDecorators: [charts.ArcLabelDecorator()],
        ),
      ),
    );
  }
}

class BarData {
  final String label;
  final int value;
  final Color color;

  BarData(this.label, this.value, this.color);
}

// BarChartWidget：通用的条形图组件
class BarChartWidget extends StatelessWidget {
  final List<BarData> data;
  final bool isVertical = true;

  const BarChartWidget({Key? key, required this.data, isVertical = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<charts.Series<BarData, String>> series = [
      charts.Series<BarData, String>(
        id: 'BarChart',
        domainFn: (datum, _) => datum.label,
        measureFn: (datum, _) => datum.value,
        colorFn: (datum, _) => charts.ColorUtil.fromDartColor(datum.color),
        data: data,
        labelAccessorFn: (datum, _) => '${datum.value}',
      ),
    ];

    return SizedBox(
      height: 300,
      child: charts.BarChart(
        series,
        animate: true,
        vertical: isVertical,
        barRendererDecorator: charts.BarLabelDecorator<String>(),
        domainAxis: charts.OrdinalAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(labelRotation: 45),
        ),
      ),
    );
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
          entry.key == '暴食冲动' ? Colors.blue : Colors.red);
    }).toList();

    return PieChartWidget(data: pieData);
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

    return BarChartWidget(data: barData);
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

    return BarChartWidget(data: barData);
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
