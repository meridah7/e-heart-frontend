import 'package:flutter/material.dart';
import 'package:namer_app/pages/Chatbot/chatbot_page.dart';
import 'package:namer_app/pages/Survey/flippable_survey_page.dart';
import 'package:namer_app/pages/Survey/survey_page.dart';
import 'package:namer_app/models/task_models.dart';
import 'package:namer_app/utils/index.dart';

StatelessWidget taskListWidget(List<Task> tasks) {
  return ListView.builder(
    shrinkWrap: true,
    padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
    itemCount: tasks.length,
    itemBuilder: (context, index) {
      final task = tasks[index];
      return Container(
        key: ValueKey(task.title + task.id),
        decoration: BoxDecoration(
          // color: Colors.white.withOpacity(0.7), // 半透明背景
          color: Colors.white,
          borderRadius: BorderRadius.circular(8), // 可选的圆角
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: 10.0), // 添加一些边距
        child: ListTile(
          title: Text(
            task.title,
            style: TextStyle(
              color: task.isCompleted ? Colors.grey : Colors.black,
              fontSize: 16.0,
            ),
          ),
          subtitle: Text(task.type == TaskType.CHATBOT ? 'Chatbot' : 'Survey'),
          trailing: Icon(task.isCompleted
              ? Icons.check_box
              : Icons.check_box_outline_blank),
          onTap: () {
            switch (task.type) {
              case TaskType.CHATBOT:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatbotPage(
                              contents: task.chatbotContent!,
                              taskId: task.id,
                              taskTitle: task.title,
                            )));
                break;
              case TaskType.SURVEY:
                if (task.isCompleted) {
                  print('${task.title} is already completed');
                  ToastUtils.showToast('${task.title}问卷已完成');
                  break;
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SurveyPage(
                              survey: task.survey!,
                              taskId: task.id,
                            )));
                break;
              case TaskType.SURVEY_FLIPPABLE:
                if (task.isCompleted) {
                  print('${task.title} is already completed');
                  ToastUtils.showToast('${task.title}问卷已完成');
                  break;
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FlippableSurveyPage(
                              survey: task.survey!,
                              taskId: task.id,
                            )));
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
