import 'package:flutter/material.dart';
import 'package:namer_app/pages/DietMonitoring/diet_monitoring_page.dart';
import 'package:namer_app/pages/DietMonitoring/food_purge.dart';

class MonitoringOptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('监控记录', style: TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                // 导航到饮食监控页面
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DietMonitoringPage()));
              }, // 增加字体大小
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 174, 86, 165), // 按钮文字颜色
                padding: EdgeInsets.symmetric(
                    horizontal: 32, vertical: 16), // 增加按钮的padding来增大按钮
              ),
              child: Text('监控记录', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 导航到食物清除页面
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FoodPurgePage())); // 假设FoodPurgePage是食物清除页面的Widget
              }, // 增加字体大小
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 217, 156, 211), // 按钮文字颜色
                padding: EdgeInsets.symmetric(
                    horizontal: 32, vertical: 16), // 增加按钮的padding来增大按钮
              ),
              child: Text('食物清除', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
