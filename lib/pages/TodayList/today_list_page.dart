import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namer_app/providers/progress.dart';
import 'package:namer_app/utils/index.dart';
import '../Chatbot/chatbot_page.dart';
import '../Survey/survey_page.dart';
import '../Survey/flippable_survey_page.dart';
import '../Survey/meal_planning_page.dart';
import 'package:namer_app/models/task_models.dart';
import 'package:namer_app/pages/ResponseCard/index.dart';

class TodayListPage extends ConsumerStatefulWidget {
  @override
  _TodayListPageState createState() => _TodayListPageState();
}

class _TodayListPageState extends ConsumerState<TodayListPage> {
  // 用于HTTP 请求的Dio 实例

  bool showTasks = true;

  late Progress _progressProvider;

  //初始化的状态
  @override
  void initState() {
    super.initState();
    _progressProvider = ref.read(progressProvider.notifier);
    _initWidget();
  }

  Future<void> _initWidget() async {
    try {
      await _progressProvider.fetchProgress();
    } catch (e) {
      print('Error in _initWidget: $e');
    }
  }

  Widget _buildSegmentedControl() {
    ThemeData themeData = Theme.of(context);
    Color taskColor = Color(0xFF9D9BE9);
    Color dietColor = Color(0xFF6FCF97);

    final progress = ref.watch(progressProvider);

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
          if (progress.value?.progress != null &&
              progress.value!.progress > 1) ...[
            SizedBox(width: 10),
            _buildRoundButton(
              '冲动应对卡',
              icon: Icons.card_travel,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      // builder: (context) => BingeEatingResponsePage())),
                      // builder: (context) => BingeEatingResponseCard())),
                      builder: (context) => ResponseCardPage())),
              color: dietColor,
            ),
          ]
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

  // Widget _buildFloatingActionButtons() {
  //   Color taskColor = Color(0xFF9D9BE9);
  //   Color dietColor = Color(0xFF6FCF97);

  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //       _buildCircleButton(
  //         '饮食日志',
  //         icon: Icons.health_and_safety,
  //         onPressed: () => Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => DietMonitoringPage())),
  //         color: taskColor,
  //       ),
  //       _buildCircleButton(
  //         '冲动记录',
  //         icon: Icons.record_voice_over,
  //         onPressed: () => Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => BingeEatingRecordPage())),
  //         color: dietColor,
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildCircleButton(String text,
  //     {VoidCallback? onPressed, IconData? icon, Color? color}) {
  //   return FloatingActionButton.extended(
  //     onPressed: onPressed,
  //     label: Text(text),
  //     icon: Icon(icon),
  //     backgroundColor: color,
  //   );
  // }

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

  void _toggleView(bool showTaskView) async {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // await userProvider.fetchUser();
    try {
      await _progressProvider.fetchProgress();
    } catch (e) {
      print('Error in _toggleView: $e');
    }

    // setState(() {
    //   showTasks = showTaskView;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(progressProvider);
    final dailyTask = ref.watch(dailyTasksProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Day ${progress.value?.progress ?? 0}',
            style: TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSegmentedControl(),
            Expanded(
              child: (dailyTask.value != null && dailyTask.value!.isNotEmpty)
                  ? _buildTaskListView(dailyTask.value ?? [])
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('今天没有必做任务呢！',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 18,
                              )),
                          SizedBox(height: 10),
                          Text('去下面的巩固提升看看新的内容吧',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 18,
                              )),
                          SizedBox(
                            height: 80,
                          )
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
