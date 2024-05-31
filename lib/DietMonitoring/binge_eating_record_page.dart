import 'package:flutter/material.dart';
import 'package:namer_app/Survey/survey_models.dart'; // Adjust import path as necessary
import 'package:namer_app/Survey/survey_page.dart'; // Assuming SurveyPage can be reused or adapted

class BingeEatingRecordPage extends StatefulWidget {
  @override
  _BingeEatingRecordPageState createState() => _BingeEatingRecordPageState();
}

class _BingeEatingRecordPageState extends State<BingeEatingRecordPage> {
  // Assume we have a survey object for binge eating records
  var impulseRecordingSurvey = Survey(
  title: '冲动记录',
  questions: [
     SingleChoiceQuestion(
      '你这次冲动属于',
      ['A. 暴食冲动', 'B. 清除食物的冲动'],
      {
        'A. 暴食冲动': [], // Optionally, add sub-questions for 'A. 暴食冲动' if needed
        'B. 清除食物的冲动': [],
      },
    ),
    MultipleChoiceQuestion(
      '请选择你的暴食应对策略：',
      ['散步', '玩游戏', '听音乐', '找朋友'],
      {}, // No sub-questions for these options
    ),
    TimeQuestion('刚刚识别到此冲动的具体时间', initialTime: DateTime.now()),
    SliderQuestion('此冲动的强烈程度',{}, min: 1, max: 10, divisions: 9, labelBuilder: (value) {
      if (value == 1) return '轻度';
      else if (value == 5) return '中度';
      else if (value == 10) return '重度';
      return value.toInt().toString();
    }),
    TextQuestion('此冲动的诱因是什么？', false),
    TextQuestion('结合你的替代策略，制定你对这次冲动的应对方案', false),
    // More questions can be added here
  ]
);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use the SurveyPage widget if it's designed to be directly reusable
      body: SurveyPage(survey: impulseRecordingSurvey),
      // If you need to adapt the survey logic specifically for this page,
      // you might integrate it directly here instead of using SurveyPage.
    );
  }
}

