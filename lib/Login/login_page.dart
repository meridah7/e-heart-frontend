import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/Login/user_model.dart';
import 'package:namer_app/utils/dio_client.dart';
import 'package:provider/provider.dart';

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

  // 登录步骤
  var _loginStep = 1;

  // TODO 验证码重发功能
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

  // 更新UserPreference
  Future<void> _updateUserInfo() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.fetchUser();
    } catch (err) {
      print('Error in update preference $err');
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
      // TODO 完善新用户
      if (response.data['is_new_user'] ?? false) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Hello 新用户')));
        // Navigator.pushReplacementNamed(context, '/register');
      } else {
        // 更新用户信息接口
        await _updateUserInfo();
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('欢迎回来')));
          Navigator.pushReplacementNamed(context, '/home');
        }
      }
    } catch (err) {
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
                      SizedBox(
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
            SizedBox(height: 18.0),
            Visibility(
              visible: _loginStep == 1,
              child: ElevatedButton(
                onPressed: _sendSMS,
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    minimumSize: Size(284, 48)),
                child: Text('发送验证码'),
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
          ],
        ),
      ),
    );
  }
}
