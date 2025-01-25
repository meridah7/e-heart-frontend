//这个文件是应用程序的入口文件，创建了一个具有底部导航栏的主界面。
//应用程序包括三个页面：今日列表页面（TodayListPage）、分析反思页面（ReviewAnalysisPage）和我的页面（MyPage）。
import 'package:flutter/material.dart';
import 'TodayList/today_list_page.dart';
import 'AnalysisReview/review_analysis_page.dart';
import 'MyPage/my_page.dart';
import 'DietaryAnalysis/dietary_analysis_page.dart';
//import 'DAO/database_helper.dart';
import 'Login/login_page.dart';
import 'Login/user_model.dart';
import 'package:namer_app/ResponseCard/response_card_model.dart';
import 'Login/register_info_page.dart';
import 'package:provider/provider.dart';
import 'debugButton.dart';
import 'DailyDiet/event_log_page.dart';
import 'package:namer_app/services/api_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // 初始化中文 Locale 数据
  initializeDateFormatting('zh_CN', null);
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // 使用MultiProvider包裹MaterialApp
      providers: [
        ChangeNotifierProvider(
            create: (context) => UserProvider()), // 创建UserProvider实例
        ChangeNotifierProvider(
            create: (context) => ResponseCardModelProvider()),
      ],

      child: MaterialApp(
          title: 'CBT-E App',
          // 配置本地化
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate, // Material 组件本地化
            GlobalCupertinoLocalizations.delegate, // Cupertino 组件本地化
            GlobalWidgetsLocalizations.delegate, // 基本小部件本地化
          ],
          supportedLocales: [
            Locale('zh', ''), // 中文
            Locale('en', ''), // 英文
            Locale('es', ''), // 西班牙语（可根据需要添加更多语言）
          ],

          // 设置默认语言（可根据用户设备的语言设置）
          locale: Locale('zh', ''), // 默认中文
          home: MainScreen(),
          theme: ThemeData(
            dialogTheme: DialogTheme(
              backgroundColor: Colors.white, // 设置弹窗的全局背景色为白色
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // 可选：为弹窗添加圆角
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD98E8E), // 设置按钮背景色
                foregroundColor: Colors.white, // 设置按钮文字颜色
                shadowColor: Colors.grey, // 设置阴影颜色
                elevation: 5, // 设置阴影高度
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24), // 设置按钮的圆角
                ),
              ),
            ),
            appBarTheme: AppBarTheme(backgroundColor: Color(0xFFF0E5E7)),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color(0xFFD98E8E), // 设置全局的主颜色
              primary: Color(0xFFD98E8E), // 主要按钮颜色
              onPrimary: Color(0xFFFFFFFF), // 主按钮下的字色
              secondary: Color(0xFFFFFFFF), // 次要按钮颜色
              onSecondary: Color(0xFF505050), // 普通按钮字色
            ),
            scaffoldBackgroundColor: Color(0xFFF0E5E7), // 设置整体背景色
          ),
          initialRoute: '/',
          routes: {
            '/login': (context) => LoginPage(), // 登录页面
            '/home': (context) => MainScreen(), // 主屏幕，登录成功后跳转的页面
            '/register': (context) => RegisterInfoPage(), // 添加注册页面的路由
          },
          navigatorKey: navigatorKey),
    );
  }
}

class MainScreen extends StatefulWidget {
  final int initialTabIndex;

  MainScreen({this.initialTabIndex = 0});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final ApiService apiService = ApiService();
  static List<Widget> _widgetOptions = <Widget>[
    TodayListPage(),
    EventLogPage(),
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
            icon: Icon(Icons.event_note),
            label: ('行为记录'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket_launch_outlined),
            label: ('巩固提升'),
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
    _selectedIndex = widget.initialTabIndex;
    _checkLoggedIn();
  }

  void _checkLoggedIn() async {
    try {
      if (mounted) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.fetchUser();
      }
    } catch (e) {
      print('请求用户信息出错: $e');
    }
  }
}
