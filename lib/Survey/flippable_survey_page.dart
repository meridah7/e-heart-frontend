import 'package:flutter/material.dart';
import 'survey_models.dart';
import 'package:namer_app/global_setting.dart';
import 'survey_question_factory.dart';
import 'SurveySummaryPage.dart';
import 'utils.dart';
import 'package:dio/dio.dart';

/// @desc 可翻页的问券
///
/// @note 当前需求只要求给问题全部分页 / 全部不分页，所以这个组件粗暴的把全部问题分页了，后续如果有混合诉求的话，则考虑把这个跟 SurveyPage 一起重构了
class FlippableSurveyPage extends StatefulWidget {
  final Survey survey;
  final String taskId;
  final bool isLastTask;

  FlippableSurveyPage(
      {required this.survey, required this.taskId, required this.isLastTask});

  @override
  _FlippableSurveyPageState createState() => _FlippableSurveyPageState();
}

class _FlippableSurveyPageState extends State<FlippableSurveyPage> {
  int _curStep = 0;

  void nextStep() {
    setState(() async {
      if (_curStep < widget.survey.questions.length - 1) {
        _curStep = _curStep + 1;
      } else {
        if (widget.survey.navigateToSummary) {
          // 获取问卷摘要
          List<String> summary = widget.survey.getSurveySummary();

// 打印问卷摘要到控制台
          for (String line in summary) {
            print(line);
          }

          // upload user input
          Response? res =
              await uploadSurveyData(widget.taskId, summary).catchError((e) {
            print('[uploadSurveyData] error $e');
          });

// 导航到问卷摘要页面
          if (widget.survey.navigateToSummary) {
// 导航到问卷摘要页面
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurveySummaryPage(
                  taskId: widget.taskId,
                  summary: summary,
                ),
              ),
            );
          }
        }
      }
    });
  }

  void prevStep() {
    setState(() {
      if (_curStep > 0) {
        _curStep = _curStep - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.survey.title),
          backgroundColor: themeColor,
        ),
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              final question = widget.survey.questions[_curStep];
              Widget questionWidget =
                  questionWidgetFactory(context, question, setState);

              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 16.0,
                ),
                child: questionWidget,
              );
            }),
        floatingActionButton: Container(
            margin: EdgeInsets.only(left: 35.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _curStep == 0
                      ? SizedBox()
                      : FloatingActionButton(
                          child: Icon(Icons.arrow_back),
                          onPressed: () {
                            // TODO: handle the prev function
                            prevStep();
                          }),
                  FloatingActionButton(
                      child: _curStep == widget.survey.questions.length - 1
                          ? Icon(Icons.check)
                          : Icon(Icons.arrow_forward),
                      onPressed: () {
                        // TODO: handle the next function
                        nextStep();
                      }),
                ])));
  }
}
