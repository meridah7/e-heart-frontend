// 定义了survey界面，和创建不同类型问题的功能

import 'package:flutter/material.dart';
import 'package:namer_app/global_setting.dart';
import 'survey_models.dart';
import 'SurveySummaryPage.dart';
import 'survey_question_factory.dart';
import 'impulsive_record_and_reflection_summary.dart';
import 'package:namer_app/user_preference.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class SurveyPage extends StatefulWidget {
  final Survey survey;
  final String taskId;
  final bool isLastTask;

  SurveyPage(
      {required this.survey, required this.taskId, required this.isLastTask});

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  late Preferences _userPref;

  // init State for some survey task
  Future<void> _initWidget() async {
    await _initializePreferences();
    Map answers = _userPref.getData('completedTaskAnswers');
    if (answers.containsKey(widget.taskId)) {
      List<String> summary = answers[widget.taskId]!.cast<String>();
      // 导航到问卷摘要页面
      Navigator.pushReplacement(
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

  @override
  void initState() {
    super.initState();
    _initWidget();
  }

  Future<void> _initializePreferences() async {
    // TODO: replace anonymous to actual UserName
    _userPref = await Preferences.getInstance(namespace: 'anonymous');
  }

  @override
  Widget build(BuildContext context) {
    // NOTE: this is currently only available for 冲动记录反思, please refactor it if other questionnaires are needed
    bool isNeedTopArea = widget.survey.isNeedTopArea;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.survey.title),
        backgroundColor: themeColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Column(children: [
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () async {
          // 获取问卷摘要
          List<String> summary = widget.survey.getSurveySummary();

          // 打印问卷摘要到控制台
          for (String line in summary) {
            print(line);
          }

          // 本地保存问卷结果
          Map answers = _userPref.getData('completedTaskAnswers');
          answers[widget.taskId] = summary;
          await _userPref.setData('completedTaskAnswers', answers);

          if (widget.isLastTask) {
            int? userProgress = _userPref.getData('progress');
            await _userPref.setData(
                'progress', userProgress == null ? 1 : userProgress + 1);
            await _userPref.setData('progressLastUpdatedDate',
                DateFormat('yyyyMMdd').format(DateTime.now()));
          }

          if (_userPref.hasKey('finishedTaskIds')) {
            List taskIds = _userPref.getData('finishedTaskIds');
            taskIds.add(widget.taskId);

            await _userPref.setData('finishedTaskIds', taskIds);
          }

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
