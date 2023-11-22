import 'package:flutter/material.dart';
import 'task_contents.dart'; 
import 'task_models.dart';
import 'diet_contents.dart'; 
import 'diet_models.dart';
import 'chatbot_page.dart';
import 'survey_page.dart'; 

class DietaryAnalysisPage extends StatefulWidget {
  @override
  _DietaryAnalysisPageState createState() => _DietaryAnalysisPageState();
}

class _DietaryAnalysisPageState extends State<DietaryAnalysisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('饮食分析页面'),
         backgroundColor: Color(0xFF9D9BE9)
         
      ),
      body: Center(
        child: Text('这是饮食分析页面的内容'),
      ),
    );
  }
}
