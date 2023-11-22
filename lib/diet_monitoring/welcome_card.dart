import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'monitoring_contents.dart';

class WelcomeRecordCard extends StatefulWidget {
  WelcomeRecordCard();

  @override
  _WelcomeRecordCardState createState() => _WelcomeRecordCardState();
}

class _WelcomeRecordCardState extends State<WelcomeRecordCard> {
  DateTime _selectedDateTime = DateTime.now(); // Static date that will be displayed

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('欢迎记录', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('你想要记录的时间是', style: TextStyle(fontSize: 14, color: Colors.grey)),
          SizedBox(height: 20),
          Text( // Display the static date here
            '${_selectedDateTime.year}年${_selectedDateTime.month}月${_selectedDateTime.day}日',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 50),
          Container(
            height: 216, // The height of the picker
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time, // Shows the hours and minutes wheels
              use24hFormat: true, // Change this based on your localization needs
              initialDateTime: _selectedDateTime,
              onDateTimeChanged: (DateTime newDateTime) {
                setState(() {
                  _selectedDateTime = newDateTime;
                });
              },
            ),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              //widget.onStartPressed(); // Trigger the provided onStartPressed callback
              // Navigate to the next page if necessary
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => MonitoringContentCard()));
            },
            child: Text('开始'),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF9D9BE9),
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
              textStyle: TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ... Rest of your code, including the MyApp and DietMonitoringPage classes ...

