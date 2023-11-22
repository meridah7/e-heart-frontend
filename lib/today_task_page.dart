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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/your_background_image.jpg'), // 替换为您的图片路径
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: TaskDay0.length,
          itemBuilder: (context, index) {
            final task = TaskDay0[index];
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
        ),
      ),
    );
  }
}
