import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/providers/progress.dart';
import 'package:namer_app/widgets/task_list_widget.dart';

class PracticeListPage extends ConsumerStatefulWidget {
  @override
  _PracticeListPageState createState() => _PracticeListPageState();
}

class _PracticeListPageState extends ConsumerState<PracticeListPage> {
  @override
  Widget build(BuildContext context) {
    final optionalTasks = ref.watch(optionalTasksProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '选修练习',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme:
              IconThemeData(color: Colors.black), // Change back button color
        ),
        body: taskListWidget(optionalTasks.value ?? []));
  }
}
