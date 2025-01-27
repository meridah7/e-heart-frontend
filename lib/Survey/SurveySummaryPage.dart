import 'package:flutter/material.dart';
import 'package:namer_app/user_preference.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/providers/user_provider.dart';

class SurveySummaryPage extends StatefulWidget {
  final List<String> summary;
  final String taskId;

  const SurveySummaryPage(
      {Key? key, required this.summary, required this.taskId})
      : super(key: key);

  @override
  _SurveySummaryPageState createState() => _SurveySummaryPageState();
}

class _SurveySummaryPageState extends State<SurveySummaryPage> {
  late Preferences _userPref;

  @override
  void initState() {
    super.initState();
    _initWidget();
  }

  Future<void> _initWidget() async {
    await _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    _userPref = await Preferences.getInstance(namespace: userProvider.uuid);
  }

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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[100]!, Colors.grey[300]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  Map answers = _userPref.getData('completedTaskAnswers');
                  answers.remove(widget.taskId);
                  await _userPref.setData('completedTaskAnswers', answers);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[300],
                ),
                child: Text('Restart',
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
