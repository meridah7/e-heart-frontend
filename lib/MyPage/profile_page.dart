import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/providers/user_data.dart';
import 'package:namer_app/utils/helper.dart';
import 'package:namer_app/models/user.dart';
import 'package:namer_app/utils/index.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  // final DioClient dioClient = DioClient();

  // 更新生日数据
  void _editBirthdayField(DateTime? currentValue) {
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
                onDateTimeChanged: (DateTime? newDateTime) {
                  setState(() {
                    currentValue = newDateTime ?? DateTime.now();
                  });
                },
              ),
            ),
            CupertinoButton(
              child: Text('保存'),
              onPressed: () {
                Navigator.pop(context); // Close picker
                _updateUser(
                    'birthday',
                    (currentValue ?? DateTime.now())
                        .toIso8601String()); // Update user birthday
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
    final userController = ref.read(userDataProvider.notifier);
    userController.logOut();
  }

  void _updateUser(String property, dynamic target) async {
    try {
      final userController = ref.read(userDataProvider.notifier);
      userController.updateUser({property: target});
    } catch (err) {
      print('Error in update user info $err');
      throw Exception(err);
    }
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

  Widget _buildUserInfo(AsyncValue<User?> user) {
    return user.when(data: (user) {
      return user != null
          ? ListView(
              children: <Widget>[
                // TODO 编辑手机号
                _buildListTile('手机号', '${user.phoneNumber}', () => {}),
                _buildListTile('名称', '${user.name}',
                    () => _editTextField('name', user.name ?? '')),
                _buildListTile('邮箱', '${user.email}',
                    () => _editTextField('email', user.email ?? '')),
                // TODO 编辑性别
                _buildListTile('性别', '男', () => {}),
                _buildListTile(
                    '生日',
                    Helper.formatDateTime(user.birthday?.toLocal()),
                    () => _editBirthdayField(user.birthday?.toLocal())),
                _buildListTile('身高', '${user.height?.toInt()}cm',
                    () => _editHeightField((user.height ?? 0).toInt())),
                _buildListTile('体重', '${user.weight?.toInt()}kg',
                    () => _editWeightField((user.weight ?? 0).toInt())),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 80,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () => _logOut(),
                      style:
                          ElevatedButton.styleFrom(maximumSize: Size(80, 40)),
                      child: Text(
                        '退出登录',
                      ),
                    ))
              ],
            )
          : customLoading();
    }, error: (error, StackTrace trace) {
      return customLoading();
    }, loading: () {
      return customLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataProvider);
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
        body: _buildUserInfo(user));
  }
}
