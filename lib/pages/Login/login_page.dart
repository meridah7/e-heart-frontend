import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/providers/user_data.dart';
import 'package:namer_app/services/dio_client.dart';
import 'package:namer_app/services/api_endpoints.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namer_app/utils/index.dart';
import 'dart:async';

class LoginPage extends ConsumerStatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  // 用于HTTP 请求的Dio 实例
  final DioClient dioClient = DioClient();

  int _countdown = 60; // 倒计时秒数
  bool _isEnabled = true; // 按钮是否可点击
  // 是否阅读免责声明
  var _isReadTermOfUse = false;

  // 存储用户信息

  // 登录步骤
  var _loginStep = 1;

  final TextEditingController _phoneNumberController = TextEditingController();
  // 定时器
  Timer? _timer; // 定时器对象

  final TextEditingController _verifyCodeController = TextEditingController();

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    _timer?.cancel();
    super.dispose();
  }

  // 手机号合法性
  static bool isChinaPhoneLegal(String str) {
    return RegExp(
            r'^1(3\d|4[5-9]|5[0-35-9]|6[2567]|7[0-8]|8\d|9[0-35-9])\d{8}$')
        .hasMatch(str);
  }

  // 免责声明弹窗
  void showDisclaimerDialog(BuildContext context) async {
    final bool? result = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // 禁止点击遮罩关闭
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: const Text('产品免责声明',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          scrollable: true, // 支持长文本滚动
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          backgroundColor: Color(0xffFAEEF0),
          content: Container(
            constraints: BoxConstraints(maxHeight: 380),
            child: const SingleChildScrollView(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '欢迎使用本应用，请仔细阅读以下条款：\n\n'),
                    TextSpan(
                        text: '1. 本应用提供的信息仅供参考，不构成任何专业建议。\n',
                        style: TextStyle(color: Colors.grey)),
                    TextSpan(
                        text: '2. 使用过程中产生的任何风险需由用户自行承担。\n',
                        style: TextStyle(color: Colors.grey)),
                    TextSpan(text: '\n请确认您已阅读并同意上述条款。'),
                  ],
                ),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 同意按钮
                ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  child: const Text('同意并继续',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () => Navigator.pop(context, true),
                ),
                // 不同意按钮
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xff353448),
                  ),
                  child: const Text('不同意'),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ),
          ],
        );
      },
    );

    // 处理用户选择
    if (result == true) {
      print('用户已同意条款');
      setState(() {
        _isReadTermOfUse = true;
      });
      // 执行同意后的操作（如进入主界面）
    } else {
      print('用户未同意条款');
      setState(() {
        _isReadTermOfUse = false;
      });
      // 执行不同意操作（如关闭应用或限制功能）
      // SystemNavigator.pop(); // 关闭应用（安卓/iOS均支持）
    }
  }

  // 启动倒计时
  void _startCountdown() {
    setState(() {
      _isEnabled = false;
      _countdown = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _isEnabled = true;
          _timer?.cancel(); // 倒计时结束，取消定时器
        }
      });
    });
  }

  void _sendSMS() async {
    if (!_isReadTermOfUse) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('请先阅读并同意免责声明')));
      showDisclaimerDialog(context);
      return;
    }
    if (isChinaPhoneLegal(_phoneNumberController.text) == false) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('请输入正确的手机号码')));
      return;
    }
    try {
      // FIXME: 暂时跳过验证码发送
      // var response = await dioClient.postRequest(ApiEndpoints.SEND_CODE,
      //     {'phone_number': _phoneNumberController.text});
      // if (response.statusCode == 200) {
      //   ToastUtils.showToast('验证码已发送');
      //   _startCountdown();
      // }
      setState(() {
        _loginStep = 2;
      });
    } catch (err) {
      print('Error in sending sms ${err.toString()}');
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('短信发送失败 ${err.toString()}')));
      }
      throw Exception(err);
    }
  }

  // 更新UserPreference
  Future<void> _updateUserInfo() async {
    try {
      final user = ref.read(userDataProvider.notifier);
      await user.fetchUser();
    } catch (err) {
      print('Error in update preference $err');
      throw Exception(err);
    }
  }

  void _loginOrRegister() async {
    try {
      var phoneNumber = _phoneNumberController.text;
      var verifyCode = _verifyCodeController.text;
      if (phoneNumber.isEmpty || verifyCode.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('请输入手机号和验证码')));
        return;
      }
      Response response = await dioClient.postRequest('/auth/verifyCode', {
        'phone_number': phoneNumber,
        'code': verifyCode,
      });
      if (response.data['code'].toString().contains('80008')) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('验证码错误')));
        }
        return;
      } else if (response.data['code'].toString().contains('80003')) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('请稍后再试')));
        }
        return;
      }
      // 如果是新用户 跳转注册页面 补充状态信息
      // ?? 表示response 里没有is_new_user 字段是为false
      // TODO 完善新用户
      if (response.data['is_new_user'] ?? false) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Hello 新用户')));
          // Navigator.pushReplacementNamed(context, '/register');
        }
        await _updateUserInfo();
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

  Widget _resendButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _isEnabled ? _sendSMS : null,
      style: ElevatedButton.styleFrom(
        // padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        minimumSize: Size(284, 55),
        maximumSize: Size(284, 55),
        backgroundColor: Color(0xffD98E8E),
        disabledBackgroundColor: Color(0xffe7a6a6).withOpacity(0.52),
        disabledForegroundColor: Colors.white,
        textStyle: GoogleFonts.aBeeZee(
          color: Color(0xff323e4c),
          fontSize: 16,
        ),
      ),
      child: Center(
        child: Text(
          _isEnabled ? '获取验证码' : '重发验证码(${_countdown}s)',
        ),
      ),
    );
  }

  Widget _termOfUse(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 4),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isReadTermOfUse = !_isReadTermOfUse;
                  });
                },
                child: _isReadTermOfUse
                    ? Icon(
                        Icons.check_circle_outline,
                        color: Color(0xff323e4c),
                      )
                    : Icon(
                        Icons.circle_outlined,
                        color: Color(0xff323e4c),
                      ),
              )),
          Text(
            '我已阅读并同意暮心',
            style: GoogleFonts.aBeeZee(
              color: Color(0xff323e4c),
              shadows: [
                Shadow(
                  color: Color(0xff000000).withOpacity(0.5), // 阴影颜色及透明度
                  offset: Offset(2, 2), // 阴影偏移方向（X,Y）
                  blurRadius: 5, // 模糊半径
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              showDisclaimerDialog(context);
            },
            child: Text(
              '用户协议',
              style: GoogleFonts.aBeeZee(
                color: Color(0xff323e4c),
                decoration: TextDecoration.underline,
                shadows: [
                  Shadow(
                    color: Color(0xff000000).withOpacity(0.3), // 阴影颜色及透明度
                    offset: Offset(2, 2), // 阴影偏移方向（X,Y）
                    blurRadius: 2, // 模糊半径
                  ),
                ],
              ),
            ),
          ),
          Text(
            '和',
            style: GoogleFonts.aBeeZee(
              color: Color(0xff323e4c),
              shadows: [
                Shadow(
                  color: Color(0xff000000).withOpacity(0.3), // 阴影颜色及透明度
                  offset: Offset(2, 2), // 阴影偏移方向（X,Y）
                  blurRadius: 2, // 模糊半径
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              showDisclaimerDialog(context);
            },
            child: Text(
              '隐私政策',
              style: GoogleFonts.aBeeZee(
                color: Color(0xff323e4c),
                decoration: TextDecoration.underline,
                shadows: [
                  Shadow(
                    color: Color(0xff000000).withOpacity(0.3), // 阴影颜色及透明度
                    offset: Offset(2, 2), // 阴影偏移方向（X,Y）
                    blurRadius: 2, // 模糊半径
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userPhoneInput(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // 水平居中
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // color: Color.fromRGBO(255, 255, 255, 0.29),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '+86',
                style: GoogleFonts.aBeeZee(
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
                child: SizedBox(
                  width: 228,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      style: GoogleFonts.aBeeZee(color: Color(0xff323e4c)),
                      decoration: InputDecoration(
                        hintText: '请输入手机号码',
                        hintStyle: GoogleFonts.aBeeZee(
                          color: Color(0xff323e4c),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('登录'),
          ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  '手机号注册/登录',
                  style: TextStyle(color: Colors.black, fontSize: 28.0),
                ),
                SizedBox(
                  height: 16,
                ),
                _userPhoneInput(context),
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
                          keyboardType: TextInputType.number,
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              minimumSize: Size(284, 55),
                              maximumSize: Size(284, 55)),
                          child: Center(
                            child: Text(
                              '登录/注册',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 16,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Visibility(
                    visible: _loginStep == 2, child: _resendButton(context)),
              ],
            ),
            _termOfUse(context)
          ],
        ),
      ),
    );
  }
}
