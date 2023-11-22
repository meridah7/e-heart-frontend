import 'package:flutter/material.dart';
import '../global_setting.dart';
import 'welcome_card.dart';


class DietMonitoringPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('饮食监控',style:TextStyle(color: Colors.black)), // Text color changed to black
        backgroundColor: themeColor, 
        
      ),
      body: WelcomeRecordCard(),
    );
  }
}

