import 'package:flutter/material.dart';
import 'package:namer_app/DailyDiet/diet_models.dart';
import '../Chatbot/diet_contents.dart';
import '../DietMonitoring/binge_eating_record_page.dart';
import '../DietMonitoring/diet_monitoring_page.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('今日饮食', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromRGBO(240, 229, 231, 1),
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
              // Handle share option
            }),
            SizedBox(height: 10),
            _buildMenuOption('食物清除记录', () {
              // Handle edit option
            }),
            SizedBox(height: 10),
            _buildMenuOption('冲动记录', () {
              // Handle delete option
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

  Widget _buildDietListView(List<Diet> diets) {
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 64),
        itemCount: diets.length,
        itemBuilder: (context, index) {
          final diet = diets[index];
          final dietLog = diet.dietLog;
          return _buildDietTail(diet);
          //   return Container(
          //       decoration: BoxDecoration(
          //         color: Colors.white.withOpacity(0.7), // 半透明背景
          //         borderRadius: BorderRadius.circular(10), // 可选的圆角
          //       ),
          //       margin:
          //           EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // 添加一些边距
          //       child: Padding(
          //           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          //           child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [_buildDietTail(diet)],
          //                 ),
          //               ])));
        });
  }

  Widget _buildDietTail(Diet diet) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // 第一栏：显示餐次名称
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diet.food,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                      "时间：${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(diet.createTime))}",
                      style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                ],
              ),
            ),
            // 第二栏：显示食物名称
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diet.food,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            // 第三栏：显示分数
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor:
                        (diet.guzzleLevel ?? 0) > 0 ? Colors.red : Colors.green,
                    child: Text(
                      '${diet.guzzleLevel ?? 0}',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.grey[600]),
                    onPressed: () {
                      // 处理编辑操作
                    },
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
