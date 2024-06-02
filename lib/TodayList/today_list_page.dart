import 'package:flutter/material.dart';
import 'package:namer_app/DailyDiet/diet_models.dart';
import 'package:namer_app/DietMonitoring/binge_eating_options.dart';
import '../Survey/task_contents.dart';
import 'task_models.dart';
import '../Chatbot/diet_contents.dart';
import '../DailyDiet/diet_models.dart';
import '../Chatbot/chatbot_page.dart';
import '../Survey/survey_page.dart';
import '../Survey/flippable_survey_page.dart';
import '../DietMonitoring/binge_eating_record_page.dart';
import '../DietMonitoring/diet_monitoring_page.dart';

class TodayListPage extends StatefulWidget {
  @override
  _TodayListPageState createState() => _TodayListPageState();
}

class _TodayListPageState extends State<TodayListPage> {
  bool showTasks = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day0', style: TextStyle(color: Colors.black)),
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
                child: showTasks
                    ? _buildTaskListView(TaskDay0)
                    : _buildDietListView(DietDay0),
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
          _buildButton(
            '今日饮食',
            onPressed: () => _toggleView(false),
            color: showTasks ? themeData.scaffoldBackgroundColor : dietColor,
            textColor: showTasks ? Colors.black : Colors.white,
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
              if (task.type == TaskType.CHATBOT) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChatbotPage(contents: task.chatbotContent!)));
              } else if (task.type == TaskType.SURVEY) {
                // TODO: determine which surver will be flipabble
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             SurveyPage(survey: task.survey!)));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FlippableSurveyPage(survey: task.survey!)));
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildDietListView(List<Diet> diets) {
    return ListView.builder(
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
          child: ListTile(
            title: Text(diet.food),
            subtitle: Text(diet.type),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChatbotPage(contents: diet.mealContent!)));
            },
          ),
        );
      },
    );
  }

  void _toggleView(bool showTaskView) {
    setState(() {
      showTasks = showTaskView;
    });
  }
}
