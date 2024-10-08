import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:namer_app/DailyDiet/diet_models.dart';
import 'package:namer_app/DietMonitoring/binge_eating_options.dart';
import '../Tasks/daily_tasks.dart';
import 'task_models.dart';
import '../Chatbot/diet_contents.dart';
import '../Chatbot/chatbot_page.dart';
import '../Survey/survey_page.dart';
import '../Survey/flippable_survey_page.dart';
import '../DietMonitoring/binge_eating_record_page.dart';
import '../DietMonitoring/diet_monitoring_page.dart';
import 'package:intl/intl.dart';
import '../ResponseCard/response_card_page.dart';
import '../user_preference.dart';
import 'package:namer_app/utils/dio_client.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/Login/user_model.dart';

class TodayListPage extends StatefulWidget {
  @override
  _TodayListPageState createState() => _TodayListPageState();
}

class _TodayListPageState extends State<TodayListPage> {
  late Preferences _userPref;
  // 用于HTTP 请求的Dio 实例
  final DioClient dioClient = DioClient();
  bool showTasks = true;
  // Fetch rules:
  // 1. check local storage, if has data, use the data
  // 2. check db's data, if has, use it
  // 3. start from day 0
  int? _currentDay;
  List<String>? _finishedTaskIds = [];

  //初始化的状态
  @override
  void initState() {
    super.initState();
    _initWidget();
  }

  Future<void> _initWidget() async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      print('TodayListPage init ${userProvider.uuid}');
      _userPref = await Preferences.getInstance(namespace: userProvider.uuid);
      int userProgress = int.tryParse(_userPref.getData('progress')) ?? 0;
      String lastUpdatedDate = _userPref.getData('progressLastUpdatedDate');
      if (lastUpdatedDate != '') {
        String currentDate = DateFormat('yyyyMMdd').format(DateTime.now());

        setState(() {
          if (lastUpdatedDate == currentDate) {
            // if lastUpdatedDate is today, keep the task list for today
            _currentDay = userProgress - 1;
          } else {
            // if lastUpdatedDate is yesterday, update the task list
            _currentDay = userProgress;
          }
        });
      } else {
        setState(() {
          _currentDay = 0;
        });
      }
      print('${_userPref.getData('finishedTaskIds')}');
      List<String> taskIds = _userPref.getData('finishedTaskIds');

      setState(() {
        _finishedTaskIds = taskIds;
      });
    } catch (e) {
      // FIXME: Sting 和int问题
      print('Error in _initWidget: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day $_currentDay', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 223, 221, 240),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background1.jpg'), // 替换为您的图片路径
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildSegmentedControl(),
              Expanded(
                child: _currentDay != null
                    ? (showTasks
                        ? _buildTaskListView(DailyTask[_currentDay!])
                        : _buildDietListView(DietDay0))
                    : SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingActionButtons(),
    );
  }

  Widget _buildSegmentedControl() {
    ThemeData themeData = Theme.of(context);
    Color taskColor = Color(0xFF9D9BE9);
    Color dietColor = Color(0xFF6FCF97);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildButton(
            '今日任务',
            onPressed: () => _toggleView(true),
            color: showTasks ? taskColor : themeData.scaffoldBackgroundColor,
            textColor: showTasks ? Colors.white : Colors.black,
          ),
          SizedBox(width: 10),
          _buildCircleButton(
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
          padding: EdgeInsets.symmetric(vertical: 12),
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

  Widget _buildTaskListView(List<Task> tasks) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 64),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Container(
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
            trailing: IconButton(
              icon: Icon(task.isCompleted
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              onPressed: () {
                setState(() {
                  task.isCompleted = !task.isCompleted;
                });
              },
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
                                isLastTask: DailyTask[_currentDay!].length ==
                                    _finishedTaskIds!.length + 1,
                              )));
                  break;
                case TaskType.SURVEY:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SurveyPage(
                              survey: task.survey!,
                              taskId: task.id,
                              isLastTask: DailyTask[_currentDay!].length ==
                                  _finishedTaskIds!.length + 1)));
                  break;
                case TaskType.SURVEY_FLIPPABLE:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FlippableSurveyPage(
                              survey: task.survey!,
                              taskId: task.id,
                              isLastTask: DailyTask[_currentDay!].length ==
                                  _finishedTaskIds!.length + 1)));
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

  Widget _buildDietListView(List<Diet> diets) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 64),
      itemCount: diets.length,
      itemBuilder: (context, index) {
        final diet = diets[index];
        return Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7), // 半透明背景
              borderRadius: BorderRadius.circular(10), // 可选的圆角
            ),
            margin:
                EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // 添加一些边距
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(diet.food, style: TextStyle(fontSize: 16.0)),
                          Text(diet.type),
                        ],
                      ),
                      Text(DateFormat('kk:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              diet.createTime))),
                    ])));
        // ListTile(
        //   title: Text(diet.food),
        //   subtitle: Text(diet.type),
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) =>
        //                 ChatbotPage(contents: diet.mealContent!)));
        //   },
      },
    );
  }

  void _toggleView(bool showTaskView) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.fetchUser();
    setState(() {
      showTasks = showTaskView;
    });
  }
}
