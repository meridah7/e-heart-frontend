import 'package:flutter/material.dart';
import 'package:namer_app/providers/progress_provider.dart';
import 'package:namer_app/widgets/task_list_widget.dart';
import 'package:provider/provider.dart';

class PracticeListPage extends StatefulWidget {
  @override
  State<PracticeListPage> createState() => _PracticeListPageState();
}

class _PracticeListPageState extends State<PracticeListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProgressProvider>(
        builder: (context, progressProvider, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              '选修练习',
              style: TextStyle(color: Colors.black),
            ),
            iconTheme:
                IconThemeData(color: Colors.black), // Change back button color
          ),
          body: taskListWidget(progressProvider.optionalTaskList));
    });
  }
}
