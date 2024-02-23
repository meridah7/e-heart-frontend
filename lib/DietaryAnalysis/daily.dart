import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'models.dart';

class BingeEatingList extends StatelessWidget {
  final List<BingeEatingEvent> events;

  BingeEatingList(this.events);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.fastfood), // 或者其他代表暴食的图标
          title: Text(events[index].time),
          subtitle: Text(events[index].description),
        );
      },
    );
  }
}




class FoodClearanceEmotionTable extends StatelessWidget {
  late final List<FoodClearanceEmotionData> data;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(label: Text('时间')),
        DataColumn(label: Text('情绪指数')),
      ],
      rows: data.map<DataRow>((item) => DataRow(
        cells: <DataCell>[
          DataCell(Text(item.time)),
          DataCell(Text(item.emotionLevel.toString())),
        ],
      )).toList(),
    );
  }
}

