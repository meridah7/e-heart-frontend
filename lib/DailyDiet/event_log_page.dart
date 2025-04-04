import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/DailyDiet/diet_models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namer_app/Survey/survey_page.dart';
import 'package:namer_app/Tasks/Survey/tasks.dart';
import 'package:namer_app/models/task_models.dart';
import 'package:namer_app/providers/progress_provider.dart';
import 'package:namer_app/services/dio_client.dart';
import 'package:namer_app/utils/toast_util.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/utils/error_handler.dart';

class EventLogPage extends StatefulWidget {
  @override
  _EventLogPageState createState() => _EventLogPageState();
}

class _EventLogPageState extends State<EventLogPage>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _animationController;
  DioClient dioClient = DioClient();
  List<MealPlan> mealPlans = [];
  List<Diet> dietLogs = [];
  bool _isLoading = false;
  dynamic _error;

  Future<void> _loadDiet() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    try {
      final now = DateTime.now();
      int startTime = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
      int endTime = DateTime(now.year, now.month, now.day, 23, 59, 59, 999).millisecondsSinceEpoch;
      
      Response response = await dioClient.getRequest('/diet_logs/todayDiet/$startTime/$endTime');
      
      if (response.statusCode == 200) {
        setState(() {
          mealPlans = (response.data['mealPlans'] as List)
              .map((item) => MealPlan.fromJson(item))
              .toList();
          dietLogs = (response.data['dietLogs'] as List)
              .map((item) => Diet.fromJson(item))
              .toList();
          _isLoading = false;
        });
      }
    } catch (e, stackTrace) {
      ErrorHandler.logError(e, stackTrace: stackTrace);
      
      setState(() {
        _error = e;
        _isLoading = false;
      });
    }
  }

  Future<void> _updatePlanStatus(int id, bool status) async {
    try {
      Response response =
          await dioClient.putRequest('/meal_plans/$id', {'state': !status});
      if (response.statusCode == 200) {
        _handleGoSurvey(dietaryIntake);
        await _loadDiet();
      }
    } catch (e) {
      print('Error in setting plan status $e');
      throw Exception(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _loadDiet();
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

  Widget _buildMenuOption(String text, VoidCallback onPressed,
      {double width = 160.0, double height = 50, int showDay = 0}) {
    return Consumer<ProgressProvider>(
        builder: (context, progressProvider, child) {
      return InkWell(
          onTap: progressProvider.progress < showDay
              ? () => {ToastUtils.showToast('暂未开放')}
              : onPressed,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: progressProvider.progress < showDay
                  ? Colors.grey
                  : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // 阴影颜色和透明度
                  spreadRadius: 4, // 扩散范围
                  blurRadius: 7, // 模糊程度
                  offset: Offset(0, 3), // 阴影偏移 (水平, 垂直)
                ),
              ],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: progressProvider.progress < showDay
                      ? Colors.black54
                      : Colors.black,
                  fontSize: 16.0,
                ),
                // overflow: TextOverflow.ellipsis,
              ),
            ),
          ));
    });
  }

  void _showTipsDialog(BuildContext context, VoidCallback callback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 340,
            child: Text(
              '''   食物清除记录/冲动记录 的结果不会直接呈现在当前"今日饮食"的界面。\n\n    它将会被作为宝贵的数据用于之后的分析反思中！''',
              style: GoogleFonts.aBeeZee(fontSize: 20),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
                onPressed: () => {
                      Navigator.of(context).pop(),
                      callback(),
                    },
                child: Text('确定'))
          ],
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, MealPlan plan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('您有按照"${plan.type}"计划进食吗？', style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // 执行确认操作
                    print("操作已确认");
                    _loadDiet();
                    // 跳转到问卷，带上预设答案
                    Map<String, dynamic> presetAnswers = {
                      'attention': '好的！',
                      'time':
                          DateTime.fromMillisecondsSinceEpoch(plan.targetDate),
                      'foodList': plan.foodList,
                      'mealType': plan.mealType.displayName,
                    };
                    _handleGoSurvey(dietaryIntake,
                        presetAnswers: presetAnswers);
                  },
                  child: Text('有'),
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // if (!plan.state) {
                    _updatePlanStatus(plan.id, plan.state);
                    // }
                  },
                  child: Text('没有'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleGoSurvey(Task task,
      {Map<String, dynamic> presetAnswers = const {}}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SurveyPage(
          survey: task.survey!,
          taskId: task.id,
          presetAnswers: presetAnswers,
        ),
      ),
    );
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error != null
              ? ErrorHandler.buildErrorWidget(_error, _loadDiet)
              : Container(
        decoration: BoxDecoration(color: Color.fromRGBO(240, 229, 231, 1)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 待完成计划标题
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8, top: 12.0, bottom: 8.0),
                  child: Text(
                    '待完成计划',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildMealPlanListView(mealPlans),
                // 当日饮食标题
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 12.0, bottom: 8.0),
                  child: Text(
                    '当日饮食',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // 当日饮食列表
                _buildDietListView(dietLogs),
              ],
            ),
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
            SizedBox(height: 6),
            _buildMenuOption('食物清除记录', () {
              _showTipsDialog(context, () => _handleGoSurvey(vomitRecord));
            }),
            SizedBox(height: 6),
            _buildMenuOption('冲动记录', () {
              _showTipsDialog(context, () => _handleGoSurvey(impulseRecording));
            }, showDay: 2),
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

  Widget _buildDietListView(List<Diet> diets, {bool shrinkWrap = true}) {
    return ListView.builder(
        shrinkWrap: shrinkWrap, // 根据内容自适应高度
        physics: NeverScrollableScrollPhysics(), // 禁用列表自身的滚动
        // padding: EdgeInsets.only(bottom: 64),
        itemCount: diets.length,
        itemBuilder: (context, index) {
          final diet = diets[index];
          return _buildDietTail(diet);
        });
  }

  Widget _buildMealPlanListView(List<MealPlan> diets,
      {bool shrinkWrap = true}) {
    return ListView.builder(
        shrinkWrap: shrinkWrap, // 根据内容自适应高度
        physics: NeverScrollableScrollPhysics(), // 禁用列表自身的滚动
        itemCount: diets.length,
        itemBuilder: (context, index) {
          final diet = diets[index];
          return _buildMealPlanTail(diet);
        });
  }

  // 暴食指数
  Widget _buildLevelIndicator(Diet diet) {
    return Row(
      children: [
        Container(
          width: 24, // 圆圈的宽度
          height: 24, // 圆圈的高度
          decoration: BoxDecoration(
            color: Colors.transparent, // 圆圈背景色
            shape: BoxShape.circle,
            border: Border.all(
                color: getColorFromInt(diet.emotionIntensity),
                width: 1), // 圆圈边框
          ),
          alignment: Alignment.center,
          child: Text(
            '暴',
            style: TextStyle(
                color: getColorFromInt(diet.emotionIntensity), fontSize: 16),
          ),
        ),
        Text(
          ':${(diet.emotionIntensity).toString()}',
          style: GoogleFonts.aBeeZee(
              fontStyle: FontStyle.italic,
              color: getColorFromInt(diet.emotionIntensity)),
        )
      ],
    );
  }

  Widget _buildMealPlanTail(MealPlan plan) {
    return Card(
      margin: EdgeInsets.all(12),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: plan.state ? Colors.grey : Colors.white70,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                // color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // 用餐类型
                          Text(
                            plan.type,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // 第二栏：显示进食时间 内容 编辑按钮
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // 确保时间和按钮在两端
                    children: [
                      // 时间部分，靠左显示
                      Row(
                        children: [
                          Text(
                            "时间：",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            DateFormat('HH:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  plan.targetDate),
                            ),
                            style: GoogleFonts.aBeeZee(
                              fontSize: 16,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),

                      // 使用 Flexible 确保文本内容居中
                      Flexible(
                        child: Container(
                          alignment: Alignment.center, // 文本居中对齐
                          child: Text(
                            plan.foodDetails,
                            style: GoogleFonts.aBeeZee(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis, // 文本过长时省略
                            maxLines: 1,
                          ),
                        ),
                      ),

                      // 编辑按钮，靠右显示
                      // FIXME: 展示时机
                      // if (!plan.state)
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 16,
                          ),
                          onPressed: () {
                            _showConfirmationDialog(context, plan);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDietTail(
    Diet diet,
  ) {
    return Card(
      color: Colors.white70,
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            // diet.food,
                            // FIXME: 添加序列
                            diet.mealType?.displayName ?? '早餐',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          // 暴食指数
                          _buildLevelIndicator(diet),
                        ],
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
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                              Text(
                                DateFormat('HH:mm').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        diet.eatingTime)),
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
                            diet.foodDetails,
                            style: GoogleFonts.aBeeZee(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 4),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
