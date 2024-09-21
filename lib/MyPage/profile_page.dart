import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/user_preference.dart';
import 'package:namer_app/utils/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/Login/user_model.dart';
import 'package:namer_app/utils/api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DioClient dioClient = DioClient();
  final ApiService apiService = ApiService();

  void _editTextField(String fieldName, dynamic currentValue) {
    TextEditingController _controller =
        TextEditingController(text: currentValue.toString());

    print('Editing $fieldName');
    // TODO loading
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $fieldName'),
          content: TextField(
            controller: _controller,
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
                _updateUser(fieldName, _controller.text);
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
        await dioClient.deleteAllTokens();
        if (mounted) {
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.logOut();
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            ModalRoute.withName('/login'), // 保留根页面
          );
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
              _buildListTile('手机号', '${user.phoneNumber}', () => {}),
              _buildListTile('名称', '${user.name}',
                  () => _editTextField('name', user.name ?? '')),
              _buildListTile('邮箱', '${user.email}',
                  () => _editTextField('email', user.email ?? '')),
              _buildListTile('性别', '男', () => _editTextField('性别', '')),
              _buildListTile(
                  '生日', '2003-09-07', () => _editTextField('生日', '')),
              _buildListTile('身高', '${user.height}cm',
                  () => _editTextField('height', user.height ?? 0)),
              _buildListTile('体重', '${user.weight ?? 0}kg',
                  () => _editTextField('weight', user.weight ?? 0)),
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
