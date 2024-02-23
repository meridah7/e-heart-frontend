import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:namer_app/Login/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  void _login() async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:3000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': _usernameController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      // 解析响应体
      final responseData = jsonDecode(response.body);
      // 创建User对象
      User user = User(
        userId: responseData['userId'].toString(), // 将int转换为String
        username: responseData['username'],
        email: responseData['email'],
      );
      // 获取SharedPreferences实例
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // 保存用户信息
      await prefs.setString('userId', responseData['userId'].toString()); // 将int转换为String
      await prefs.setString('username', user.username);
      await prefs.setString('email', user.email);
      // 将用户信息存储到Provider中
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      // 导航到主页
      print("successfully login!!");
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // 登录失败，显示错误消息
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('登录失败')));
    }
  } catch (e) {
    // 捕获可能的异常并处理
    print('Error while logging in: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('登录失败，请重试')));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('登录')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: '用户名'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: '密码'),
              obscureText: true, // 隐藏输入内容
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('登录'),
            ),
            TextButton(
              onPressed: () {
                // 导航到注册页面
                Navigator.pushNamed(context, '/register');
              },
              child: Text('没有账号？注册'),
            )
          ],
        ),
      ),
    );
  }


Future<User> fetchUserFromServer(String username, String password) async {
  final url = Uri.parse('http://localhost:3000/login');

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // 解析响应体
      final responseData = jsonDecode(response.body);
      // 创建User对象并返回
      return User(
        userId: responseData['userId'],
        username: responseData['username'],
        email: responseData['email'],
      );
    } else {
      // 如果请求不成功，则抛出异常
      throw Exception('Failed to fetch user from server');
    }
  } catch (e) {
    // 捕获可能的异常并抛出
    throw Exception('Error fetching user from server: $e');
  }
}
}
