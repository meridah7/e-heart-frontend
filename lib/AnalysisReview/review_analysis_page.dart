// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import '../DietReview/review_page.dart';
import './practice_list_page.dart';

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

class _ReviewAnalysisPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('巩固提升',
            style:
                TextStyle(color: Colors.black)), // Text color changed to black
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                '反思分析记录',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            _buildReflectionSection(),
            SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                '选修练习',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            _buildPracticeOptions(),
          ],
        ),
      ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildIconSection(
              Icons.restaurant_menu, '饮食日志', _navigateToDietMonitoring),
          _buildIconSection(
              Icons.access_time, '饮食计划', _navigateToDietPlanReview),
          _buildIconSection(Icons.update, '暴食替代', _navigateToImpulseReview),
        ],
      ),
    );
  }

  Widget _buildPracticeOptions() {
    return Column(
      children: [
        _buildPracticeCard('冲动诱因教学', false),
        _buildPracticeCard('为什么我无法停止暴食？', false),
        _buildViewAllPracticeCard(),
      ],
    );
  }

  Widget _buildPracticeCard(String title, bool completed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: completed ? Colors.grey : Colors.black,
              fontSize: 16.0,
            ),
          ),
          trailing: Icon(
            completed ? Icons.check_box : Icons.check_box_outline_blank,
            color: completed ? Colors.grey : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildViewAllPracticeCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            '查看全部练习',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PracticeListPage()),
            );
          },
        ),
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

  void _navigateToDietMonitoring() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewPage(
          surveyKey: DIET_REVIEW_KEY,
          reviewTitle: '饮食日志反思',
        ),
      ),
    );
  }

  void _navigateToDietPlanReview() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewPage(
          surveyKey: DIET_PLAN_REVIEW_KEY,
          reviewTitle: '饮食计划反思',
        ),
      ),
    );
  }

  void _navigateToImpulseReview() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewPage(
          surveyKey: IMPULSE_REVIEW_KEY,
          reviewTitle: '冲动记录反思',
        ),
      ),
    );
  }
}
