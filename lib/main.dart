//这个文件是应用程序的入口文件，创建了一个具有底部导航栏的主界面。
//应用程序包括三个页面：今日列表页面（TodayListPage）、分析反思页面（ReviewAnalysisPage）和我的页面（MyPage）。
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'TodayList/today_list_page.dart';
import 'AnalysisReview/review_analysis_page.dart';
import 'Chatbot/chat_models.dart';
import 'MyPage/my_page.dart';
import 'DietaryAnalysis/dietary_analysis_page.dart';
//import 'DAO/database_helper.dart';
import 'Login/login_page.dart';
import 'Login/register_page.dart';
import 'Login/user_model.dart';
import 'Login/register_info_page.dart';
import 'package:provider/provider.dart';
import 'user_preference.dart';
import 'debugButton.dart';
import 'DailyDiet/daily_diet_page.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: replace anonymous to actual UserName
  final userPref = await Preferences.getInstance(namespace: 'anonymous');

  // 假设你保存用户信息为字符串
  final String? userId = userPref.getData('userId');
  final String? username = userPref.getData('username');
  final String? email = userPref.getData('email');

  // 检查是否存在保存的用户信息
  bool isLoggedIn = userId != null && username != null && email != null;

  runApp(MyApp(
      isLoggedIn: isLoggedIn,
      userId: userId,
      username: username,
      email: email));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn; // 添加一个字段来存储登录状态
  final String? userId;
  final String? username;
  final String? email;
  MyApp({required this.isLoggedIn, this.userId, this.username, this.email});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // 使用MultiProvider包裹MaterialApp
      providers: [
        ChangeNotifierProvider(
            create: (context) => UserProvider()), // 创建UserProvider实例
      ],

      child: MaterialApp(
        title: 'CBT-E App',
        // home: isLoggedIn ? MainScreen() : MainScreen(), // 初始路由为登录页面
        home: isLoggedIn ? LoginPage() : LoginPage(), // 初始路由为登录页面
        initialRoute: '/',
        routes: {
          '/login': (context) => LoginPage(), // 登录页面
          '/home': (context) => MainScreen(), // 主屏幕，登录成功后跳转的页面
          '/register': (context) => RegisterInfoPage(), // 添加注册页面的路由
        },
      ),
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
    DailyDietPage(),
    ReviewAnalysisPage(),
    MyPage(),
  ];

  // ==== debugButton config
  // Variables for managing debug button display logic
  int _clickCount = 0;
  DateTime? _firstClickTime;
  bool _showDebugButton = false;
  Offset _debugButtonOffset = Offset(0, 500);
  // ==== debugButton config

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          DebugButton(
            offset: _debugButtonOffset,
            onDrag: _updateDebugButtonPosition,
            isVisible: _showDebugButton, // Control visibility
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: ('每日任务'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ramen_dining_sharp),
            label: ('今日饮食'),
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
        type: BottomNavigationBarType.fixed, // 重要
      ),
    );
  }

  void _onItemTapped(int index) {
    // handle debug button
    if (index == 0) {
      DateTime now = DateTime.now();

      if (_firstClickTime == null ||
          now.difference(_firstClickTime!).inSeconds > 10) {
        _firstClickTime = now;
        _clickCount = 1;
      } else {
        _clickCount++;
      }

      if (_clickCount == 10) {
        setState(() {
          _showDebugButton = true;
        });
      }
    } else {
      // Reset the click count and time if another button is clicked
      _clickCount = 0;
      _firstClickTime = null;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateDebugButtonPosition(Offset newOffset) {
    setState(() {
      _debugButtonOffset = newOffset;
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
    _setUserIfLoggedIn();
  }

  void _setUserIfLoggedIn() async {
    // TODO: replace anonymous to actual UserName
    final userPref = await Preferences.getInstance(namespace: 'anonymous');
    final isLoggedIn = userPref.getData('userId') != null;

    if (isLoggedIn) {
      final userId = userPref.getData('userId')!;
      final username = userPref.getData('username')!;
      final email = userPref.getData('email')!;
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUserFromSavedData(userId, username, email);
    }
  }

  // void _createRootUserIfNeeded() async {
  //   print("debug!!");
  //   var dbHelper = await DatabaseHelper.createInstance();
  //   dbHelper.createUserTable();
  //   // final List<Map<String, Object?>> users = await getUsers(db); // 使用 await 等待 Future 完成
  //   // if (users.isEmpty) {
  //   //   print("创建root");
  //   //   // 如果没有用户，创建 root user
  //   //   insertUser(db, "root", 0); // 假设 root 用户的 age 是 0
  //   // }
  // }
}
