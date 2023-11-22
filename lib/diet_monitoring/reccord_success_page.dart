import 'package:flutter/material.dart';
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
            SizedBox(height: 20), // 为了增加一些空间
            ElevatedButton(
              onPressed: () {
                // 使用 Navigator 返回主页，这里假设主页是 "/" 路由
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text('返回主页'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // 白色背景
                onPrimary: Colors.black, // 黑色文字
                elevation: 0, // 无阴影效果
              ),
            ),
          ],
        ),
      ),
    );
  }
}
