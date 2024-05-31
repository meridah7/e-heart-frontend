import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SurveySummaryPage extends StatelessWidget {
  final List<String> summary;

  const SurveySummaryPage({Key? key, required this.summary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey Summary'),
      ),
      body: ListView.builder(
        itemCount: summary.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(summary[index]),
          );
        },
      ),
    );
  }
}