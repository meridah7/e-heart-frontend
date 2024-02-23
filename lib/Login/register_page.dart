import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(); // 假设注册需要电子邮件

  void _register() async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/register'), // 替换为你的API端点
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': _usernameController.text,
        'password': _passwordController.text,
        'email': _emailController.text, // 添加email字段
      }),
    );

    if (response.statusCode == 200) {
      // 注册成功，可能会跳转到登录页面或主页
      
      Navigator.pushReplacementNamed(context, '/login'); // 假设登录页面路由为/login
    } else {
      // 显示错误消息
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('注册失败')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('注册')),
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
              obscureText: true,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: '电子邮件'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _register,
              child: Text('注册'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('返回登录'),
            ),
          ],
        ),
      ),
    );
  }
}
