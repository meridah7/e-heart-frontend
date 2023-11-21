import 'package:flutter/material.dart';
import 'task_contents.dart'; 
import 'task_models.dart';
import 'diet_contents.dart'; 
import 'diet_models.dart';
import 'chatbot_page.dart';
import 'survey_page.dart'; 
import 'main.dart'; 
import 'dietary_analysis_page.dart'; 


class ReviewAnalysisPage extends StatefulWidget {
  @override
  _ReviewAnalysisPageState createState() => _ReviewAnalysisPageState();
}


class _ReviewAnalysisPageState extends State<ReviewAnalysisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('饮食分析'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 25.0), // 在这里添加一个高度为25像素的间距
          Center(
            child: InkWell(
              onTap: () {
                // 处理按钮点击事件
                // 可以在这里添加打开饮食分析页面的逻辑
                _navigateToDietaryAnalysisPage();
              },
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 255, 159, 146),
                ),
                child: Center(
                  child: Text(
                    '饮食分析',
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
            ),
          ),
          
          SizedBox(height: 20.0), // 添加一个垂直方向的间距
          Center(
            child: InkWell(
              onTap: () {
                // 处理按钮点击事件
                // 可以在这里添加打开饮食监控反思页面的逻辑

                //下面的页面还没创建
                //_navigateToDietaryReflectionPage();
              },
              child: Container(
                width: 120.0,
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color.fromARGB(217, 217, 217,217), // 可以根据需要修改颜色
                ),
                child: Center(
                  child: Text(
                    '饮食监控反思',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.0), // 添加一个垂直方向的间距
          Center(
            child: InkWell(
              onTap: () {
                // 处理按钮点击事件
                // 可以在这里添加打开饮食监控反思页面的逻辑

                //下面的页面还没创建
                //_navigateToRegularReflectionPage();
              },
              child: Container(
                width: 120.0,
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color.fromARGB(217, 217, 217,217), // 可以根据需要修改颜色
                ),
                child: Center(
                  child: Text(
                    '规律饮食反思',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.0), // 添加一个垂直方向的间距
          Center(
            child: InkWell(
              onTap: () {
                // 处理按钮点击事件
                // 可以在这里添加打开饮食监控反思页面的逻辑

                //下面的页面还没创建
                //_navigateToBingeReflectionPage();
              },
              child: Container(
                width: 120.0,
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color.fromARGB(217, 217, 217,217), // 可以根据需要修改颜色
                ),
                child: Center(
                  child: Text(
                    '暴食替代反思',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 40.0), // 添加一个垂直方向的间距
          Center(
            child: InkWell(
              onTap: () {
                // 处理按钮点击事件
                // 可以在这里添加打开饮食监控反思页面的逻辑

                //下面的页面还没创建
                //_navigateToBingeEatingStrategyPage();
              },
              child: Container(
                width: 200.0,
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color.fromARGB(255, 188, 219, 255), // 可以根据需要修改颜色
                ),
                child: Center(
                  child: Text(
                    '我的暴食应对策略',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0), // 添加一个垂直方向的间距
          Center(
            child: InkWell(
              onTap: () {
                // 处理按钮点击事件
                // 可以在这里添加打开饮食监控反思页面的逻辑

                //下面的页面还没创建
                //_navigateToPositiveDietTrainingPage();
              },
              child: Container(
                width: 200.0,
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color.fromARGB(255, 188, 219, 255), // 可以根据需要修改颜色
                ),
                child: Center(
                  child: Text(
                    '正念饮食训练',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
   void _navigateToDietaryAnalysisPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DietaryAnalysisPage(),  
      ),
    );
  }

  //待创建页面
  // void _navigateToDietaryReflectionPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => DietaryReflectionPage(),  
  //     ),
  //   );
  // }
  // void _navigateToRegularReflectionPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => RegularReflectionPage(),  
  //     ),
  //   );
  // }
  // void _navigateToBingeReflectionPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => BingeReflectionPage(),  
  //     ),
  //   );
  // }
  // void _navigateToBingeEatingStrategyPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => BingeEatingStrategyPage(),  
  //     ),
  //   );
  // }
  // void _navigateToPositiveDietTrainingPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => PositiveDietTrainingPage(),  
  //     ),
  //   );
  // }
  
}
