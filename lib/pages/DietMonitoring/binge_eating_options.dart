import 'package:flutter/material.dart';
import 'package:namer_app/pages/DietMonitoring/binge_eating_card.dart';
import 'package:namer_app/pages/DietMonitoring/binge_eating_record_page.dart';

class BingeEatingOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('冲动记录', style: TextStyle(color: Colors.black)),
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
                        builder: (context) => BingeEatingRecordPage()));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 174, 86, 165), // 按钮文字颜色
                padding: EdgeInsets.symmetric(
                    horizontal: 32, vertical: 16), // 增加按钮的padding来增大按钮
              ),
              child: Text('冲动记录', style: TextStyle(fontSize: 20)), // 增加字体大小
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 导航到食物清除页面
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BingeEatingCard())); // 假设FoodPurgePage是食物清除页面的Widget
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 217, 156, 211), // 按钮文字颜色
                padding: EdgeInsets.symmetric(
                    horizontal: 32, vertical: 16), // 增加按钮的padding来增大按钮
              ),
              child: Text('冲动应对卡片', style: TextStyle(fontSize: 20)), // 增加字体大小
            ),
          ],
        ),
      ),
    );
  }
}
