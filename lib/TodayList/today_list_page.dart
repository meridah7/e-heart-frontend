import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/providers/progress_provider.dart';
import '../Tasks/daily_tasks.dart';
import 'package:namer_app/models/task_models.dart';
import '../Chatbot/chatbot_page.dart';
import '../Survey/survey_page.dart';
import '../Survey/flippable_survey_page.dart';
import '../Survey/meal_planning_page.dart';
import '../DietMonitoring/binge_eating_record_page.dart';
import '../DietMonitoring/diet_monitoring_page.dart';
import 'package:intl/intl.dart';
import '../ResponseCard/response_card_page.dart';
import '../user_preference.dart';
import 'package:namer_app/services/dio_client.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/providers/user_provider.dart';

import 'package:namer_app/utils/helper.dart';
import 'package:namer_app/models/survey_models.dart';

class TodayListPage extends StatefulWidget {
  @override
  _TodayListPageState createState() => _TodayListPageState();
}

class _TodayListPageState extends State<TodayListPage> {
  // 用于HTTP 请求的Dio 实例
  final DioClient dioClient = DioClient();

  bool showTasks = true;

  // Fetch rules:
  // 1. check local storage, if has data, use the data
  // 2. check db's data, if has, use it
  // 3. start from day 0
  int? _currentDay;

  List<Task> _dailyTaskList = [];
  // List<String>? _finishedTaskIds = [];
  late Preferences _userPref;

  //初始化的状态
  @override
  void initState() {
    super.initState();
    _initWidget();
  }

  Future<List<Task>> fetchImpulseReflectionRecords() async {
    List<Task> impulseRecordTaskList = [];
    try {
      Response response =
          await dioClient.getRequest('/impulse/impulse-reflection-records/');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        impulseRecordTaskList = data.map((val) {
          DateTime dateTime = DateTime.parse(val['createdAt']).toUtc();
          return Task(
              title: '冲动记录回顾 ${DateFormat('MM月dd日HH时mm分').format(dateTime)}',
              id: 'S1',
              type: TaskType.SURVEY,
              isCompleted: false,
              day: 0,
              survey: Survey(
                  title: '${DateFormat('MM月dd日').format(dateTime)}冲动记录回顾',
                  extra: {
                    'impulse_record_id': Helper.safeParseInt(val['id']),
                  },
                  questions: [
                    TextQuestion('你感觉这次的应对策略怎么样？整个应对过程有什么可以改进的地方呢？', false,
                        alias: 'impulse_response_experience',
                        description:
                            '你的冲动记录时间是：${DateFormat('yyyy年MM月dd日 HH时mm分').format(dateTime)}\n'
                            '你记录的冲动种类是：${val['impulse_type']}\n'
                            '你记录的冲动强度是：${val['intensity']}\n'
                            '你记录的冲动诱因是：${val['trigger']}\n'
                            '针对这次冲动，你制定的应对策略是:${val['plan']}\n'
                            '针对这次冲动，你希望自己坚持冲动冲浪的时间：${val['impulse_duration_min'] ?? 0}分钟\n'),
                    TextQuestion('你这次冲动大约持续了多少分钟？', false,
                        alias: 'impulse_duration_min'),
                  ]));
        }).toList();
      }
    } catch (e) {
      throw Exception('Error in fetch impulse record list $e');
    }
    return impulseRecordTaskList;
  }

  Future<void> _initWidget() async {
    try {
      _dailyTaskList.clear();
      print('init');
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      var progressProvider =
          Provider.of<ProgressProvider>(context, listen: false);
      await progressProvider.fetchProgress();
      _userPref = await Preferences.getInstance(namespace: userProvider.uuid);
      print('TodayListPage init ${userProvider.uuid}');
      List<Task> impulseRecordTaskList = await fetchImpulseReflectionRecords();
      int userProgress = progressProvider.progress ?? 0;
      print('progress $userProgress');
      setState(() {
        _currentDay = userProgress;
      });
      // int userProgress =
      //     Helper.safeParseInt(_userPref.getData('progress')) ?? 0;
      // String lastUpdatedDate = _userPref.getData('progressLastUpdatedDate');
      // if (lastUpdatedDate != '') {
      //   String currentDate = DateFormat('yyyyMMdd').format(DateTime.now());

      //   setState(() {
      //     if (lastUpdatedDate == currentDate) {
      //       // if lastUpdatedDate is today, keep the task list for today
      //       _currentDay = userProgress - 1;
      //     } else {
      //       // if lastUpdatedDate is yesterday, update the task list
      //       _currentDay = userProgress;
      //     }
      //   });
      // } else {
      //   setState(() {
      //     _currentDay = 0;
      //   });
      // }
      // print('${_userPref.getData('finishedTaskIds')}');
      // List<String> taskIds =
      //     List<String>.from(_userPref.getData('finishedTaskIds'));
      // List<String> finishedTaskIds =
      //     progressProvider.userProgress!.data!.finishedTaskIds ?? [];
      // List<String> displayTaskId = [
      //   ...progressProvider.allRequiredTaskIds,
      //   ...progressProvider.allOptionalTaskIds,
      // ];
      // List<Task> finishedTaskList =
      //     getTasksByIds(progressProvider.finishedTaskIds)
      //         .map((e) => e.copyWith(isCompleted: true))
      //         .toList();
      List<Task> dailyTaskList = await progressProvider.fetchDisplayTaskList();
      // dailyTaskList.addAll(finishedTaskList);

      setState(() {
        // _finishedTaskIds = finishedTaskIds;
        if (_currentDay != null) {
          // 深拷贝
          // _dailyTaskList = List.from(DailyTask[_currentDay ?? 0]);
          _dailyTaskList = dailyTaskList;
          print('daily$_dailyTaskList');
          // 如果没有重复的记录，则添加 impulseRecordTaskList
          _dailyTaskList.addAll(impulseRecordTaskList);
          print('add daily$_dailyTaskList');
        }
      });
    } catch (e) {
      print('Error in _initWidget: $e');
    }
  }

  Widget _buildSegmentedControl() {
    ThemeData themeData = Theme.of(context);
    Color taskColor = Color(0xFF9D9BE9);
    Color dietColor = Color(0xFF6FCF97);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildButton(
            '今日任务',
            onPressed: () => _toggleView(true),
            color: showTasks ? taskColor : themeData.scaffoldBackgroundColor,
            textColor: showTasks ? Colors.white : Colors.black,
          ),
          SizedBox(width: 10),
          _buildRoundButton(
            '冲动应对卡',
            icon: Icons.card_travel,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    // builder: (context) => BingeEatingResponsePage())),
                    builder: (context) => BingeEatingResponseCard())),
            color: dietColor,
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text,
      {VoidCallback? onPressed, Color? color, Color? textColor}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 16),
          textStyle: TextStyle(fontSize: 16),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildFloatingActionButtons() {
    Color taskColor = Color(0xFF9D9BE9);
    Color dietColor = Color(0xFF6FCF97);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCircleButton(
          '饮食日志',
          icon: Icons.health_and_safety,
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => DietMonitoringPage())),
          color: taskColor,
        ),
        _buildCircleButton(
          '冲动记录',
          icon: Icons.record_voice_over,
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => BingeEatingRecordPage())),
          color: dietColor,
        ),
      ],
    );
  }

  Widget _buildCircleButton(String text,
      {VoidCallback? onPressed, IconData? icon, Color? color}) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: Text(text),
      icon: Icon(icon),
      backgroundColor: color,
    );
  }

  Widget _buildRoundButton(
    String text, {
    VoidCallback? onPressed,
    IconData? icon,
    Color? color,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.black), // 图标颜色与文字一致
      label: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.blue, // 按钮背景色
        // shape: const CircleBorder(), // 圆形按钮外观
        padding: const EdgeInsets.all(16), // 按钮内边距
      ),
    );
  }

  Widget _buildTaskListView(List<Task> tasks) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 64),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Container(
          key: ValueKey(task.title + task.id),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7), // 半透明背景
            borderRadius: BorderRadius.circular(10), // 可选的圆角
          ),
          margin:
              EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // 添加一些边距
          child: ListTile(
            title: Text(task.title),
            subtitle:
                Text(task.type == TaskType.CHATBOT ? 'Chatbot' : 'Survey'),
            trailing: Icon(task.isCompleted
                    ? Icons.check_box
                    : Icons.check_box_outline_blank
                // icon: ,
                // onPressed: () {
                //   setState(() {
                //     task.isCompleted = !task.isCompleted;
                //   });
                // },
                ),
            onTap: () {
              switch (task.type) {
                case TaskType.CHATBOT:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatbotPage(
                                contents: task.chatbotContent!,
                                taskId: task.id,
                              )));
                  break;
                case TaskType.SURVEY:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SurveyPage(
                                survey: task.survey!,
                                taskId: task.id,
                              )));
                  break;
                case TaskType.SURVEY_FLIPPABLE:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FlippableSurveyPage(
                                survey: task.survey!,
                                taskId: task.id,
                              )));
                  break;
                case TaskType.MEAL_PLANNING:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MealPlanningPage(taskId: task.id)));
                  break;
                default:
                  // do nothing
                  print('task type ERROR!');
              }
            },
          ),
        );
      },
    );
  }

  // Widget _buildDietListView(List<Diet> diets) {
  //   return ListView.builder(
  //     padding: EdgeInsets.only(bottom: 64),
  //     itemCount: diets.length,
  //     itemBuilder: (context, index) {
  //       final diet = diets[index];
  //       return Container(
  //           decoration: BoxDecoration(
  //             color: Colors.white.withOpacity(0.7), // 半透明背景
  //             borderRadius: BorderRadius.circular(10), // 可选的圆角
  //           ),
  //           margin:
  //               EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // 添加一些边距
  //           child: Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //               child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Text(diet.food, style: TextStyle(fontSize: 16.0)),
  //                         Text(diet.type),
  //                       ],
  //                     ),
  //                     Text(DateFormat('kk:mm').format(
  //                         DateTime.fromMillisecondsSinceEpoch(
  //                             diet.createTime))),
  //                   ])));
  //       // ListTile(
  //       //   title: Text(diet.food),
  //       //   subtitle: Text(diet.type),
  //       //   onTap: () {
  //       //     Navigator.push(
  //       //         context,
  //       //         MaterialPageRoute(
  //       //             builder: (context) =>
  //       //                 ChatbotPage(contents: diet.mealContent!)));
  //       //   },
  //     },
  //   );
  // }

  void _toggleView(bool showTaskView) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.fetchUser();
    setState(() {
      showTasks = showTaskView;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 使用context获取UserProvider实例
    final progressProvider = Provider.of<ProgressProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Day ${progressProvider.progress}',
            style: TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSegmentedControl(),
            Expanded(
                // child: _currentDay != null ?
                child: _buildTaskListView(_dailyTaskList)
                // : SizedBox.shrink(),
                ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: _buildFloatingActionButtons(),
    );
  }
}
