import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/providers/user_preference.dart';
import 'package:namer_app/main.dart';

class SurveySummaryPage extends ConsumerStatefulWidget {
  final List<String> summary;
  final String taskId;

  const SurveySummaryPage(
      {Key? key, required this.summary, required this.taskId})
      : super(key: key);

  @override
  _SurveySummaryPageState createState() => _SurveySummaryPageState();
}

class _SurveySummaryPageState extends ConsumerState<SurveySummaryPage> {
  late PreferencesData _userPref;
  bool showRestart = true;

  @override
  void initState() async {
    super.initState();
    // _initWidget();
    _userPref = await ref.read(preferencesDataProvider.notifier);
  }

  // Future<void> _initWidget() async {
  // if (NotRestartTaskIds.contains(widget.taskId)) {
  //   setState(() {
  //     showRestart = false;
  //   });
  // }
  // await _initializePreferences();
  // }

  // Future<void> _initializePreferences() async {
  //   var userProvider = Provider.of<UserProvider>(context, listen: false);
  //   _userPref = await Preferences.getInstance(namespace: userProvider.uuid);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey Summary'),
      ),
      body: ListView.builder(
        itemCount: widget.summary.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.summary[index]),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Colors.grey[100]!, Colors.grey[300]!],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
        // ),
        child: Row(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  Map answers = await _userPref.getData('completedTaskAnswers');
                  answers.remove(widget.taskId);
                  await _userPref.setData('completedTaskAnswers', answers);
                  navigatorKey.currentState
                      ?.pushNamedAndRemoveUntil('/home', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[300],
                ),
                child: Text('返回主页',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
