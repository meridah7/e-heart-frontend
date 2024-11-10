import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/DailyDiet/diet_models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namer_app/Survey/survey_page.dart';
import 'package:namer_app/Tasks/Survey/tasks.dart';
import 'package:namer_app/TodayList/task_models.dart';
import '../Chatbot/diet_contents.dart';

class EventLogPage extends StatefulWidget {
  @override
  _EventLogPageState createState() => _EventLogPageState();
}

class _EventLogPageState extends State<EventLogPage>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _showTipsDialog(BuildContext context, VoidCallback callback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('确认操作'),
          content: SizedBox(
            width: 340,
            child: Text(
              '''   食物清除记录/冲动记录 的结果不会直接呈现在当前“今日饮食“的界面。\n\n    它将会被作为宝贵的数据用于之后的分析反思中！''',
              style: GoogleFonts.aBeeZee(fontSize: 20),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
                onPressed: () => {Navigator.of(context).pop()},
                child: Text('确定'))
          ],
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, Diet diet) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('确认操作'),
          content: Text('您有按照${diet.food}计划进食吗'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // 取消操作
                Navigator.of(context).pop();
              },
              child: Text('是'),
            ),
            TextButton(
              onPressed: () {
                // 确认操作
                Navigator.of(context).pop();
                // 执行确认操作
                print("操作已确认");
              },
              child: Text('否'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMenuOption(String text, VoidCallback onPressed,
      {double width = 160.0, double height = 50}) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
              // overflow: TextOverflow.ellipsis,
            ),
          ),
        ));
  }

  void _handleGoSurvey(Task task) {
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SurveyPage(
            survey: task.survey!,
            taskId: task.id,
            isLastTask: false,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('今日饮食', style: TextStyle(color: Colors.black)),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline), // 问号图标
            onPressed: () {
              // 点击按钮后的操作，例如显示提示对话框
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('帮助'),
                  content: Text('这是一些帮助信息。'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('关闭'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(240, 229, 231, 1)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: _buildDietListView(DietDay0),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isExpanded) ...[
            _buildMenuOption('饮食记录', () {
              _handleGoSurvey(dietaryIntake);
            }),
            SizedBox(height: 10),
            _buildMenuOption('食物清除记录', () {
              _showTipsDialog(context, () => _handleGoSurvey(vomitRecord));
            }),
            SizedBox(height: 10),
            _buildMenuOption('冲动记录', () {
              _showTipsDialog(context, () => _handleGoSurvey(impulseRecording));
            }),
            SizedBox(height: 10),
          ],
          SizedBox(
            width: 100,
            child: FloatingActionButton(
              onPressed: _toggleMenu,
              child: AnimatedIcon(
                icon: AnimatedIcons.add_event,
                progress: _animationController,
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // 暴食字体颜色
  Color getColorFromInt(int value) {
    // 确保 value 在 1 到 9 之间
    value = value.clamp(1, 10);

    // 起始和终止颜色的 RGBA 值
    int startR = 0, startG = 132, startB = 11;
    int endR = 132, endG = 0, endB = 0;

    // 计算插值因子 (0 到 1 之间)
    double t = (value - 1) / (9 - 1);

    // 计算每个通道的线性插值值
    int r = ((1 - t) * startR + t * endR).round();
    int g = ((1 - t) * startG + t * endG).round();
    int b = ((1 - t) * startB + t * endB).round();

    return Color.fromRGBO(r, g, b, 1);
  }

  Widget _buildDietListView(List<Diet> diets) {
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 64),
        itemCount: diets.length,
        itemBuilder: (context, index) {
          final diet = diets[index];
          return _buildDietTail(diet);
        });
  }

  Widget _buildLevelIndicator(Diet diet) {
    if (diet.status == DietStatus.checked) {
      return Row(
        children: [
          Container(
            width: 24, // 圆圈的宽度
            height: 24, // 圆圈的高度
            decoration: BoxDecoration(
              color: Colors.transparent, // 圆圈背景色
              shape: BoxShape.circle,
              border: Border.all(
                  color: getColorFromInt(diet.guzzleLevel ?? 1),
                  width: 1), // 圆圈边框
            ),
            alignment: Alignment.center,
            child: Text(
              '暴',
              style: TextStyle(
                  color: getColorFromInt(diet.guzzleLevel ?? 1), fontSize: 16),
            ),
          ),
          Text(
            ':${(diet.guzzleLevel ?? 1).toString()}',
            style: GoogleFonts.aBeeZee(
                fontStyle: FontStyle.italic,
                color: getColorFromInt(diet.guzzleLevel ?? 1)),
          )
        ],
      );
    }
    return Container();
  }

  Widget _buildDietItem(Diet? diet, {bool isMutated = false}) {
    if (diet == null) {
      return Container();
    }
    return Container(
      width: 360,
      height: 120,
      transform: Matrix4.translationValues(
          0, isMutated ? 0 : (diet.planedDiet != null ? -24 : 0), 0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: isMutated ? Color.fromARGB(120, 255, 255, 255) : Colors.white,
        margin: EdgeInsets.symmetric(vertical: diet.planedDiet != null ? 0 : 8),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        // diet.food,
                        '第一餐',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      // 暴食指数
                      isMutated ? Container() : _buildLevelIndicator(diet)
                    ],
                  ),
                  isMutated
                      ? Container()
                      : Container(
                          width: 48,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Center(
                            child: Text(diet.getStatusText(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              // 第二栏：显示进食时间 内容 编辑按钮
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text("时间：",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                          Text(
                            DateFormat('HH:mm').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    diet.createTime)),
                            style: GoogleFonts.aBeeZee(
                                fontSize: 16,
                                color: Colors.black,
                                fontStyle: FontStyle.italic),
                          )
                        ],
                      ),

                      SizedBox(
                        width: 32,
                      ),
                      //  暴食指数
                      Text(
                        diet.food,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 4),
                    ],
                  ),
                  isMutated
                      ? Container()
                      : SizedBox(
                          width: 32,
                          height: 32,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 16,
                            ),
                            onPressed: () {
                              // 处理编辑操作
                              _showConfirmationDialog(context, diet);
                            },
                          ),
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDietTail(Diet diet) {
    return Column(
      children: [
        _buildDietItem(diet.planedDiet, isMutated: true),
        _buildDietItem(diet),
      ],
    );
  }
}
