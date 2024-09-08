import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:namer_app/Login/user_model.dart';
import 'package:namer_app/user_preference.dart';
import 'package:namer_app/utils/dio_client.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _verifyCodeController = TextEditingController();
  // 用于HTTP 请求的Dio 实例
  final DioClient dioClient = DioClient();
  // 存储用户信息
  late Preferences _userPref;

  // 登录步骤
  var _loginStep = 1;

  void _sendSMS() async {
    try {
      await dioClient.postRequest(
          '/auth/sendCode', {'phone_number': _phoneNumberController.text});
      setState(() {
        _loginStep = 2;
      });
    } catch (err) {
      print('err in sending sms ${err.toString()}');
      throw Exception(err);
    }
  }

  void _loginOrRegister() async {
    try {
      Response response = await dioClient.postRequest('/auth/verifyCode', {
        'phone_number': _phoneNumberController.text,
        'code': _verifyCodeController.text,
      });
      if (!mounted) return;
      // 如果是新用户 跳转注册页面 补充状态信息
      // ?? 表示response 里没有is_new_user 字段是为false
      if (response.data['is_new_user'] ?? false) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Hello 新用户')));
        // Navigator.pushReplacementNamed(context, '/register');
      } else {
        // 获取用户信息接口
        Response userResponse = await dioClient.getRequest('/users/current');
        var userData = userResponse.data['data'];
        print('user resp ${userResponse.data}');
        // // 创建User对象
        User user = User(
          userId: userData['id'].toString(), // 将int转换为String
          username: userData['name'],
          email: userData['email'],
        );
        // // 获取SharedPreferences实例
        _userPref = await Preferences.getInstance(namespace: user.username);

        // 保存用户信息
        await _userPref.setData('userId', user.userId); // 将int转换为String
        await _userPref.setData('username', user.username);
        await _userPref.setData('email', user.email);
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('欢迎回来')));
          Navigator.pushReplacementNamed(context, '/home');
        }
      }
    } catch (err) {
      print('err in verify $err');
      // 捕获可能的异常并处理
      print('Error while logging in: $err');
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('登录失败，请重试')));
      }
      throw Exception(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('登录'),
        backgroundColor: Color.fromRGBO(160, 158, 235, 1),
      ),
      backgroundColor: Color.fromRGBO(160, 158, 235, 1),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              '手机号注册/登录',
              style: TextStyle(color: Colors.white, fontSize: 28.0),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 水平居中
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.29),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('+86'),
                      SizedBox(width: 8),
                      Container(
                        width: 228,
                        child: TextField(
                          controller: _phoneNumberController,
                          decoration: InputDecoration(
                            hintText: '请输入手机号',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

            // TextField(
            //   controller: _usernameController,
            //   // decoration: InputDecoration(labelText: '用户名'),
            //   decoration:
            //       InputDecoration(prefixText: '+86', hintText: '请输入手机号'),
            // ),
            // TextField(
            //   controller: _passwordController,
            //   // decoration: InputDecoration(labelText: '密码'),
            //   obscureText: true, // 隐藏输入内容
            // ),
            SizedBox(height: 10.0),
            Visibility(
              visible: _loginStep == 1,
              child: ElevatedButton(
                onPressed: _sendSMS,
                child: Text('发送验证码'),
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    minimumSize: Size(284, 48)),
              ),
            ),
            Visibility(
              visible: _loginStep == 2,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.29),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    width: 284,
                    child: TextField(
                      controller: _verifyCodeController,
                      decoration: InputDecoration(
                        hintText: '请输入验证码',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: _loginOrRegister,
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        minimumSize: Size(284, 48)),
                    child: Text('登录/注册'),
                  ),
                ],
              ),
            ),
            // TextButton(
            //   onPressed: () {
            //     // 导航到注册页面
            //     Navigator.pushNamed(context, '/register');
            //   },
            //   child: Text('没有账号？注册'),
            // )
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
