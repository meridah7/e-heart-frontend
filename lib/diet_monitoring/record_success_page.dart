import 'package:flutter/material.dart';
import 'package:namer_app/diet_monitoring/record_report.dart';
import 'package:namer_app/global_setting.dart';

class RecordSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record Successful'),
        backgroundColor: themeColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Record Successful!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Use Navigator to return to the home page, assuming the home page is "/" route
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text('Return to Home'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                elevation: 0,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RecordReportPage()),
                );
              },
              child: Text('View Diet Monitoring Report'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF9D9BE9), // Use the app's theme color
                onPrimary: Colors.white, // White text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
