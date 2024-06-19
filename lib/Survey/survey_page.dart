// 定义了survey界面，和创建不同类型问题的功能
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/global_setting.dart';
import 'survey_models.dart';
import 'SurveySummaryPage.dart';
import 'survey_question_factory.dart';
import 'impulsive_record_and_reflection_summary.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SurveyPage extends StatefulWidget {
  final Survey survey;

  SurveyPage({required this.survey});

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  @override
  Widget build(BuildContext context) {
    // NOTE: this is currently only available for 冲动记录反思, please refactor it if other questionnaires are needed
    bool isNeedTopArea = widget.survey.isNeedTopArea;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.survey.title),
        backgroundColor: themeColor,
      ),
      body: Column(children: [
        isNeedTopArea
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: ImpulsiveRecordAndReflectionSummary(),
              )
            : Container(),
        Expanded(
            child: ListView.builder(
          itemCount: widget.survey.questions.length,
          itemBuilder: (context, index) {
            final question = widget.survey.questions[index];
            Widget questionWidget =
                questionWidgetFactory(context, question, setState);

            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 16.0,
              ),
              child: questionWidget,
            );
          },
        ))
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
// 获取问卷摘要
          List<String> summary = widget.survey.getSurveySummary();

// 打印问卷摘要到控制台
          for (String line in summary) {
            print(line);
          }

// 导航到问卷摘要页面
          if (widget.survey.navigateToSummary) {
// 导航到问卷摘要页面
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurveySummaryPage(summary: summary),
              ),
            );
          }
        },
      ),
    );
  }

  Map<String, String> _customAnswers = {};
  void _updateCustomAnswer(String questionKey, String answer) {
    setState(() {
      _customAnswers[questionKey] = answer;
    });
  }
}
