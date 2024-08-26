import 'package:flutter/material.dart';
import 'package:namer_app/DailyDiet/diet_models.dart';
import '../Chatbot/diet_contents.dart';
import '../DietMonitoring/binge_eating_record_page.dart';
import '../DietMonitoring/diet_monitoring_page.dart';
import 'package:intl/intl.dart';

class DailyDietPage extends StatefulWidget {
  @override
  _DailyDietPageState createState() => _DailyDietPageState();
}

class _DailyDietPageState extends State<DailyDietPage> {
  int currentDate = 0;

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
              Expanded(
                child: _buildDietListView(DietDay0),
              ),
            ],
          ),
        ),
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
}
