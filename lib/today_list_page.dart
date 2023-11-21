import 'package:flutter/material.dart';
import 'package:namer_app/diet_models.dart';
import 'task_contents.dart';
import 'task_models.dart';
import 'diet_contents.dart';
import 'diet_models.dart';
import 'chatbot_page.dart';
import 'survey_page.dart';

class TodayListPage extends StatefulWidget {
  @override
  _TodayListPageState createState() => _TodayListPageState();
}

class _TodayListPageState extends State<TodayListPage> {
  bool showTasks = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            Container(
              width: 250.0,
              height: 600.0,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(11, 0, 0, 0)),
                color: showTasks
                    ? const Color.fromARGB(185, 221, 209, 224)
                    : const Color.fromARGB(185, 156, 208, 185),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      children: [
                        _buildButton('今日任务', onPressed: () => _toggleView(true), color: const Color.fromARGB(255, 221, 209, 224)),
                        SizedBox(width: 0),
                        _buildButton('今日饮食', onPressed: () => _toggleView(false), color: const Color.fromARGB(255, 156, 208, 185)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: showTasks
                        ? _buildTaskListView(TaskDay0)
                        : _buildDietListView(DietDay0),
                  ),
                ],
              ),
            ),
            // 左下方圆形按钮
            Positioned(
              left: 20.0,
              bottom: 20.0,
              child: _buildCircleButton('饮食监控', onPressed: () {
                // 处理饮食监控按钮点击事件
              }),
            ),
            
            // 右下方圆形按钮
            Positioned(
              right: 20.0,
              bottom: 20.0,
              child: _buildCircleButton('记录暴食冲动', onPressed: () {
                // 处理记录暴食冲动按钮点击事件
              }),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, {VoidCallback? onPressed, Color? color}) {
    return Container(
      width: 124.0,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: ElevatedButton.styleFrom(
          primary: color,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
        ),
      ),
    );
  }
Widget _buildCircleButton(String text, {VoidCallback? onPressed}) {
    return Container(
      width: 90.0,
      height: 80.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 146, 159, 255),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    );
  }
  Widget _buildTaskListView(List<Task> tasks) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text('任务 ${index + 1}'),
          subtitle: Text(task.type == TaskType.CHATBOT ? '聊天机器人' : '问卷调查'),
          trailing: IconButton(
            icon: Icon(task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank),
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
                  builder: (context) => ChatbotPage(contents: task.chatbotContent!),
                ),
              );
            } else if (task.type == TaskType.SURVEY) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SurveyPage(survey: task.survey!),
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildDietListView(List<Diet> diets) {
    return ListView.builder(
      itemCount: diets.length,
      itemBuilder: (context, index) {
        final diet = diets[index];
        return ListTile(
          title: Text('饮食任务 ${index + 1}'),
          subtitle: Text(diet.type == DietType.FormalMeal ? '正餐' : '非正餐（小食）'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatbotPage(contents: diet.mealContent!),
              ),
            );
          },
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
