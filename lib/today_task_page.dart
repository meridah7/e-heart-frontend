//用于生成每日任务的界面和任务列表
//任务列表可能包含不同种类的任务
import 'package:flutter/material.dart';
import 'task_contents.dart'; 
import 'task_models.dart';
import 'chatbot_page.dart';
import 'survey_page.dart'; 


class TodayTaskPage extends StatefulWidget {
  @override
  _TodayTaskPageState createState() => _TodayTaskPageState();
}

class _TodayTaskPageState extends State<TodayTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('今日任务'),
      ),
      body: ListView.builder(
        itemCount: Day0.length,
        itemBuilder: (context, index) {
          final task = Day0[index];
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
                // 你可以跳转到聊天机器人页面，并将chatbotContent作为参数传递
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatbotPage(contents: task.chatbotContent!),
                  ),
                );
              } else if (task.type == TaskType.SURVEY){
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
      ),
    );
  }
}