// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import '../DietaryAnalysis/dietary_analysis_page.dart';
import '../DietReview/review_page.dart';

// 饮食日志反思
const String DIET_REVIEW_KEY = 'S2';
// 饮食计划反思
const String DIET_PLAN_REVIEW_KEY = 'S4';
// 冲动记录反思
const String IMPULSE_REVIEW_KEY = 'S5';

class ReviewAnalysisPage extends StatefulWidget {
  @override
  _ReviewAnalysisPageState createState() => _ReviewAnalysisPageState();
}

class _ReviewAnalysisPageState extends State<ReviewAnalysisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分析反思',
            style:
                TextStyle(color: Colors.black)), // Text color changed to black
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.0),
            _buildCustomButton(
              title: '饮食日志',
              subtitle: '查看饮食分析去了解自己的饮食模式哦！',
              iconData: Icons.analytics,
              onTap: _navigateToDietaryAnalysisPage,
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 25.0), // 根据需要调整左边距
              child: Text(
                '饮食反思',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            _buildReflectionSection(),
            SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 25.0), // 根据需要调整左边距
              child: Text(
                '暴食应对',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            _buildBingeResponseSection(),
            // ... Add other buttons if needed ...
          ],
        ),
      ),
    );
  }

  Widget _buildCustomButton({
    required String title,
    required String subtitle,
    required IconData iconData,
    required VoidCallback onTap,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        // Increase the width slightly by reducing horizontal margin
        margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04, vertical: 10.0),
        padding: EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Color(0xFF9D9BE9),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
        ),
        // Inside the _buildCustomButton method
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(width: 10.0),
                        Icon(iconData, color: Colors.white, size: 24.0),
                      ],
                    ),
                    SizedBox(
                        height:
                            5.0), // Add space between the title/icon row and the subtitle
                    Text(
                      subtitle,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.9), fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDietaryAnalysisPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DietaryAnalysisPage()),
    );
  }

  Widget _buildReflectionSection() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 10.0),
      padding: EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 89, 87, 87).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Inside your _buildReflectionSection method
              _buildIconSection(
                  Icons.restaurant_menu, '饮食日志', _navigateToDietMonitoring),
              _buildIconSection(
                  Icons.access_time, '饮食计划', _navigateToDietPlanReview),
              _buildIconSection(Icons.update, '暴食替代', _navigateToImpulseReview),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconSection(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.purple),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Add this method to your _ReviewAnalysisPageState class

  Widget _buildBingeResponseSection() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04, vertical: 10.0),
      padding: EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 89, 87, 87).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconSection(Icons.lightbulb_outline, '我的暴食应对策略',
                  _navigateToMyBingeEatingStrategy),
              _buildIconSection(Icons.self_improvement, '正念饮食训练',
                  _navigateToMindfulEatingTraining),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToDietMonitoring() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReviewPage(
                  surveyKey: DIET_REVIEW_KEY,
                  reviewTitle: '饮食日志反思',
                )));
  }

  void _navigateToDietPlanReview() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReviewPage(
                  surveyKey: DIET_PLAN_REVIEW_KEY,
                  reviewTitle: '饮食计划反思',
                )));
  }

  void _navigateToImpulseReview() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReviewPage(
                  surveyKey: IMPULSE_REVIEW_KEY,
                  reviewTitle: '冲动记录反思',
                )));
  }

  void _navigateToMyBingeEatingStrategy() {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => MyBingeEatingStrategyPage()));
  }

  void _navigateToMindfulEatingTraining() {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => MindfulEatingTrainingPage()));
  }

// Rest of your _ReviewAnalysisPageState class...
}
