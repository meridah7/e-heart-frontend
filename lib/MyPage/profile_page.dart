import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/services/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:namer_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/Login/user_model.dart';
import 'package:namer_app/services/api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DioClient dioClient = DioClient();
  final ApiService apiService = ApiService();

  // 更新生日数据
  void _editBirthdayField(DateTime currentValue) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: currentValue,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() {
                    currentValue = newDateTime;
                  });
                },
              ),
            ),
            CupertinoButton(
              child: Text('保存'),
              onPressed: () {
                Navigator.pop(context); // Close picker
                _updateUser('birthday',
                    currentValue.toIso8601String()); // Update user birthday
              },
            )
          ],
        ),
      ),
    );
  }

  // 更新体重
  void _editWeightField(int currentValue) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: CupertinoPicker(
                itemExtent: 32.0,
                scrollController:
                    FixedExtentScrollController(initialItem: currentValue - 30),
                onSelectedItemChanged: (int value) {
                  setState(() {
                    currentValue = value + 30;
                  });
                },
                children: List<Widget>.generate(150, (int index) {
                  return Center(child: Text('${index + 30} kg'));
                }),
              ),
            ),
            CupertinoButton(
              child: Text('保存'),
              onPressed: () {
                Navigator.pop(context); // Close picker
                _updateUser('weight', currentValue); // Update user weight
              },
            )
          ],
        ),
      ),
    );
  }

  // 更新身高
  void _editHeightField(int currentValue) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: CupertinoPicker(
                itemExtent: 32.0,
                scrollController: FixedExtentScrollController(
                    initialItem: currentValue - 100),
                onSelectedItemChanged: (int value) {
                  setState(() {
                    currentValue = value + 100;
                  });
                },
                children: List<Widget>.generate(200, (int index) {
                  return Center(child: Text('${index + 100} cm'));
                }),
              ),
            ),
            CupertinoButton(
              child: Text('保存'),
              onPressed: () {
                Navigator.pop(context); // Close picker
                _updateUser('height', currentValue); // Update user height
              },
            )
          ],
        ),
      ),
    );
  }

  // 更新文本内容
  void _editTextField(String fieldName, dynamic currentValue) {
    TextEditingController controller =
        TextEditingController(text: currentValue.toString());

    print('Editing $fieldName');
    // TODO loading
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $fieldName'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Enter new $fieldName',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog without changes
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update user information with the new value
                _updateUser(fieldName, controller.text);
                Navigator.pop(context); // Close dialog after saving
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _logOut() async {
    try {
      Response response = await dioClient.postRequest('/auth/logout', {});
      if (response.statusCode == 200) {
        // 重置preference
        // 删除token
        await dioClient.clearTokens();
        if (mounted) {
          // var userProvider = Provider.of<UserProvider>(context, listen: false);
          // userProvider.logOut();
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   '/login',
          //   ModalRoute.withName('/login'), // 保留根页面
          // );
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          ModalRoute.withName('/login'), // 保留根页面
        );
      }
    }
  }

  void _updateUser(String property, dynamic target) async {
    try {
      Response response = await dioClient.putRequest('/users/current', {
        property: target,
      });
      if (response.statusCode == 200) {
        if (mounted) {
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          userProvider.fetchUser();
        }
      }
    } catch (err) {
      print('Error in update user info $err');
      throw Exception(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人基本信息'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<UserProvider>(
        builder: (context, user, child) {
          return ListView(
            children: <Widget>[
              // TODO 编辑手机号
              _buildListTile('手机号', '${user.phoneNumber}', () => {}),
              _buildListTile('名称', '${user.name}',
                  () => _editTextField('name', user.name ?? '')),
              _buildListTile('邮箱', '${user.email}',
                  () => _editTextField('email', user.email ?? '')),
              // TODO 编辑性别
              _buildListTile('性别', '男', () => {}),
              _buildListTile('生日', Helper.formatDateTime(user.birthday),
                  () => _editBirthdayField(user.birthday)),
              _buildListTile('身高', '${user.height.toInt()}cm',
                  () => _editHeightField(user.height.toInt())),
              _buildListTile('体重', '${user.weight.toInt()}kg',
                  () => _editWeightField(user.weight.toInt())),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 80,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => _logOut(),
                    style: ElevatedButton.styleFrom(maximumSize: Size(80, 40)),
                    child: Text(
                      '退出登录',
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }

  ListTile _buildListTile(String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(subtitle),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: onTap,
    );
  }
}
