import 'package:flutter/material.dart';
import 'package:namer_app/services/dio_client.dart';
import 'package:provider/provider.dart';
import '../Login/user_model.dart';
import './profile_page.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的页面',
            style:
                TextStyle(color: Colors.black)), // Text color changed to black
      ),
      body: Consumer<UserProvider>(builder: (context, user, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildUserInfo(context, user),

              // 分隔线
              Divider(height: 15, thickness: 1),

              // 设置选项
              _buildOption('设置', Icons.settings, context),

              // 分隔线
              Divider(height: 15, thickness: 1),

              // FIXME: 调试Token

              // 饮食日志补录选项
              // _buildOption('饮食日志补录', Icons.local_dining, context),
              _buildOption('清除accessToken', Icons.local_dining, context),

              // 分隔线
              Divider(height: 15, thickness: 1),

              // 占卜回顾选项
              _buildOption('清除所有Token', Icons.star, context),

              // 分隔线
              Divider(height: 15, thickness: 1),

              // 我应对复发策略选项
              _buildOption('我应对复发策略', Icons.security, context),

              // 分隔线
              Divider(height: 15, thickness: 1),

              // 当我不在暴食后选项
              _buildOption('当我不在暴食后', Icons.healing, context),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildUserInfo(BuildContext context, UserProvider user) {
    if (user.uuid == '') {
      print('My Page not login: ${user.name}');
      return Text(
        '未登录',
        style:
            TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // 增加字体大小并加粗
        textAlign: TextAlign.center, // 文本对齐方式
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '昵称: ${user.name}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8), // 用于添加空间
          Text(
            '用户ID: ${user.id}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      );
    }
  }

  // FIXME: 调试Token
  Widget _buildOption(String title, IconData icon, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        // 使用context获取UserProvider实例
        final userProvider = Provider.of<UserProvider>(context, listen: false);

        switch (title) {
          case '设置':
            if (userProvider.user != null) {
              // 如果用户已登录，导航到设置页面
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage()));
            } else {
              // 如果用户未登录，显示登录提示
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('请先登录')));

              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                ModalRoute.withName('/login'), // 保留根页面
              );
            }
            break;
          case '清除accessToken':
            DioClient().setAccessToken('');
            // 导航到饮食日志补录页面
            // Navigator.pushNamed(context, '/diet_review');
            break;
          case '清除所有Token':
            DioClient().clearTokens();
            break;
          default:
        }
      },
    );
  }
}
