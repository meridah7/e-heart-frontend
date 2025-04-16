//这个文件是应用程序的入口文件，创建了一个具有底部导航栏的主界面。
//应用程序包括三个页面：今日列表页面（TodayListPage）、分析反思页面（ReviewAnalysisPage）和我的页面（MyPage）。
// basic
import 'package:flutter/material.dart';
// utils
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:namer_app/providers/page_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// pages
import 'pages/TodayList/today_list_page.dart';
import 'pages/AnalysisReview/review_analysis_page.dart';
import 'pages/MyPage/my_page.dart';
import 'pages/DietaryAnalysis/dietary_analysis_page.dart';
import 'pages/Login/login_page.dart';
import 'pages/Login/register_info_page.dart';
import 'widgets/debugButton.dart';
import 'pages/DailyDiet/event_log_page.dart';

// riverpod 状态管理
import 'package:flutter_riverpod/flutter_riverpod.dart';
// providers
import 'package:namer_app/providers/progress.dart';
import 'package:namer_app/providers/user_data.dart';

// 用于控制全局路由
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  // 初始化中文 Locale 数据
  initializeDateFormatting('zh_CN', null);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
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
    );
  }
}

class MainScreen extends ConsumerStatefulWidget {
  MainScreen({this.initialTabIndex = 0});

  final int initialTabIndex;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late final Progress progress;

  // ==== debugButton config
  // Variables for managing debug button display logic

  Offset _debugButtonOffset = Offset(0, 500);
  bool _showDebugButton = false;

  @override
  void initState() {
    super.initState();
  }

  void _updateDebugButtonPosition(Offset newOffset) {
    setState(() {
      _debugButtonOffset = newOffset;
    });
  }

  // ==== debugButton config

  @override
  Widget build(BuildContext context) {
    // 监听登录态，登录态失效返回登录页
    ref.listen(userDataProvider, (previous, next) {
      next.whenData((user) {
        if (user == null) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    });

    final navBarItems = ref.watch(bottomNavBarProvider);
    final pageWidgets = ref.watch(pageWidgetProvider);
    final pageIndex = ref.watch(pageIndexProvider);
    final pageIndexController = ref.read(pageIndexProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: pageWidgets.elementAt(pageIndex),
          ),
          DebugButton(
            offset: _debugButtonOffset,
            onDrag: _updateDebugButtonPosition,
            isVisible: _showDebugButton, // Control visibility
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: navBarItems,
        currentIndex: pageIndex,
        onTap: (index) {
          pageIndexController.setIndex(index);
        },
        type: BottomNavigationBarType.fixed, // 重要
      ),
    );
  }
}
