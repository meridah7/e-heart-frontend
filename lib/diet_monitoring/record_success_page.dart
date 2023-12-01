import 'package:flutter/material.dart';
import 'package:namer_app/diet_monitoring/record_report.dart';
import 'package:namer_app/global_setting.dart';

class RecordSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('记录成功'),
        backgroundColor: themeColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '记录成功！',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 使用 Navigator 返回主页，这里假设主页是 "/" 路由
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text('返回主页'),
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
              child: Text('查看本次饮食监控报告'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF9D9BE9), // 使用应用的主题色
                onPrimary: Colors.white, // 白色文字
              ),
            ),
          ],
        ),
      ),
    );
  }
}
