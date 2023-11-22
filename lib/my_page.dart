import 'package:flutter/material.dart';
import 'package:namer_app/global_setting.dart';
import 'main.dart'; 

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的页面', style: TextStyle(color: Colors.black)), // Text color changed to black
        backgroundColor: themeColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // 个人信息部分
            _buildUserInfo(),

            // 分隔线
            Divider(height: 15, thickness: 1),

            // 设置选项
            _buildOption('设置', Icons.settings),

            // 分隔线
            Divider(height: 15, thickness: 1),

            // 饮食监控补录选项
            _buildOption('饮食监控补录', Icons.local_dining),

            // 分隔线
            Divider(height: 15, thickness: 1),

            // 占卜回顾选项
            _buildOption('占卜回顾', Icons.star),

            // 分隔线
            Divider(height: 15, thickness: 1),

            // 我应对复发策略选项
            _buildOption('我应对复发策略', Icons.security),

            // 分隔线
            Divider(height: 15, thickness: 1),

            // 当我不在暴食后选项
            _buildOption('当我不在暴食后', Icons.healing),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/image2.png'), 
        ),
        SizedBox(height: 10),
        Text(
          '用户昵称', // 用户昵称
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          '用户ID: 110110110', // 用户ID
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {

        // 暂时留空

        
        // 处理选项点击事件
      },
    );
  }
}
