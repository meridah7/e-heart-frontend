// 定义了survey界面，和创建不同类型问题的功能

import 'package:flutter/material.dart';
import 'package:namer_app/Login/user_model.dart';
import 'package:namer_app/global_setting.dart';
import 'survey_models.dart';
import 'SurveySummaryPage.dart';
import 'survey_question_factory.dart';
import 'impulsive_record_and_reflection_summary.dart';
import 'package:namer_app/user_preference.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'utils.dart';
import 'package:dio/dio.dart';

class SurveyPage extends StatefulWidget {
  final Survey survey;
  final String taskId;
  final bool isLastTask;
  final Function? handleSubmit;

  SurveyPage(
      {required this.survey,
      required this.taskId,
      required this.isLastTask,
      this.handleSubmit});

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
      if (mounted) {
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
  }

  @override
  void initState() {
    super.initState();
    _initWidget();
  }

  Future<void> _initializePreferences() async {
    if (mounted) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      _userPref = await Preferences.getInstance(namespace: userProvider.uuid);
    }
  }

  Map<String, dynamic> extractAnswer(Survey survey) {
    List<Question>? questions = survey.questions;
    Map<String, dynamic> answers = survey.extra != null ? survey.extra! : {};
    // 递归获取问题和回答
    void extractAnswerRecursive(List<Question>? questions) {
      if (questions == null || questions.isEmpty) {
        return;
      }
      for (var question in questions) {
        try {
          if (question.alias != null) {
            answers[question.alias!] = question.getAnswer();
          }
          if (question is SingleChoiceQuestion) {
            if (question.selectedOption != null &&
                question.subQuestions.isNotEmpty &&
                question.selectedOption!.isNotEmpty &&
                question.subQuestions[question.selectedOption] != null) {
              extractAnswerRecursive(
                  question.subQuestions[question.selectedOption]!);
            }
          } else if (question is MultipleChoiceQuestion) {
            // 如果问题有子问题，递归调用
            for (var subQuestion in question.selectedOptions) {
              if (question.subQuestions.isNotEmpty &&
                  question.subQuestions[subQuestion] is List<Question>) {
                extractAnswerRecursive(question.subQuestions[subQuestion]!);
              }
            }
          } else if (question is TextQuestion) {
            // 数组形式
            // if (question.canAddMore) {
            //   summary.add('Answer: ${question.answers}');
            // } else {
            //   summary.add('Answer: ${question.answers[0]}');
            // }
          } else if (question is TimeQuestion) {
          } else if (question is SliderQuestion) {
            var subQuestions = question.subQuestions;
            var value = question.sliderValue.toString();
            if (subQuestions != null && question.sliderValue > 0) {
              if (subQuestions[value] != null) {
                extractAnswerRecursive(question.subQuestions?[value]);
              } else if (subQuestions['default'] != null) {
                extractAnswerRecursive(subQuestions['default']);
              }
            }
          } else if (question is MealQuestion) {
            // summary.add('Answer: ${question.meals}');
            for (var subQuestion in question.meals) {
              if (question.subQuestions.isNotEmpty &&
                  question.subQuestions[subQuestion] is List<Question>) {
                extractAnswerRecursive(question.subQuestions[subQuestion]!);
              }
            }
          } else if (question is PriorityQuestion) {
            // summary.add('Answer: ${question.selectedOptions}');
          }
        } catch (e) {
          print('Error in summarize question ${question.questionText} $e');
          throw Exception(e);
        }
      }
    }

    extractAnswerRecursive(questions);
    return answers;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Column(
            children: [
              // 根据条件显示顶部区域
              isNeedTopArea
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: ImpulsiveRecordAndReflectionSummary(),
                    )
                  : Container(),

              // 渲染问卷的列表
              Column(
                children:
                    List.generate(widget.survey.questions.length, (index) {
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
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () async {
          if (!widget.survey.isSurveyComplete()) {
            print('问卷未完成');
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('问卷未完成')));
            return;
          }

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

          var answer = extractAnswer(widget.survey);

          // upload user input
          Response? res =
              await handleSubmitData(widget.taskId, answer, summary: summary)
                  .catchError((e) {
            print('[uploadSurveyData] error $e');
          });

          // 导航到问卷摘要页面
          if (widget.survey.navigateToSummary) {
            if (mounted) {
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
          } else {
            if (mounted) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (Route<dynamic> route) => false);
            }
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
