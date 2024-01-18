//这个文件是应用程序的入口文件，创建了一个具有底部导航栏的主界面。
//应用程序包括三个页面：今日列表页面（TodayListPage）、分析反思页面（ReviewAnalysisPage）和我的页面（MyPage）。
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'today_list_page.dart';
import 'review_analysis_page.dart';
import 'chat_models.dart';
import 'MyPage/my_page.dart';
import 'DietaryAnalysis/dietary_analysis_page.dart'; 
import 'DAO/database_helper.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '主界面',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    TodayListPage(),
    ReviewAnalysisPage(),
    MyPage(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: ('今日列表'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: ('分析反思'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: ('我的'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 新增的函数，处理按钮点击事件
  void _navigateToDietaryAnalysisPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DietaryAnalysisPage(),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    // sqfliteFfiInit();
    // _createRootUserIfNeeded();
  }

  void _createRootUserIfNeeded() async {
    print("debug!!");
    var dbHelper = await DatabaseHelper.createInstance();
    dbHelper.createUserTable();
    // final List<Map<String, Object?>> users = await getUsers(db); // 使用 await 等待 Future 完成
    // if (users.isEmpty) {
    //   print("创建root");
    //   // 如果没有用户，创建 root user
    //   insertUser(db, "root", 0); // 假设 root 用户的 age 是 0
    // }
  }
  

  
}
