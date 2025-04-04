// 定义了survey界面，和创建不同类型问题的功能

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/main.dart';
import 'package:namer_app/models/survey_models.dart';
import 'package:namer_app/providers/progress.dart';
// import 'package:namer_app/providers/survey_data.dart';
import 'package:namer_app/services/survey_service.dart';
import 'package:namer_app/utils/index.dart';
import 'survey_summary_page.dart';
import 'survey_question_factory.dart';
import 'impulsive_record_and_reflection_summary.dart';
import 'package:namer_app/providers/user_preference.dart';
import 'utils.dart';
import 'package:dio/dio.dart';

class SurveyPage extends ConsumerStatefulWidget {
  SurveyPage({
    required this.survey,
    required this.taskId,
    this.handleSubmit,
    this.presetAnswers,
  });

  // final bool isLastTask;
  final Function? handleSubmit;

  Map<String, dynamic>? presetAnswers = {};
  final Survey survey;
  final String taskId;

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends ConsumerState<SurveyPage> {
  // Map<String, String> _customAnswers = {};
  late final PreferencesData _userPrefController;
  late final Preferences _userPref;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
    _initWidget();
    isLoading = true;
    _initializeQuestions();
  }

  Future<void> _initializePreferences() async {
    _userPrefController = await ref.read(preferencesDataProvider.notifier);
    _userPref = await ref.watch(preferencesDataProvider.future);
  }

  // 递归填入预设回答
  List<Question> fillSurveyWithPresetAnswer(
      List<Question> questions, Map<String, dynamic>? presetAnswers) {
    if (questions.isEmpty || presetAnswers == null || presetAnswers.isEmpty) {
      return questions;
    }
    for (var question in questions) {
      try {
        if (question.alias != null &&
            presetAnswers.keys.contains(question.alias)) {
          question.setAnswer(presetAnswers[question.alias]);
          presetAnswers.remove(question.alias);
        }
        if (question is SingleChoiceQuestion) {
          if (question.selectedOption != null &&
              question.subQuestions.isNotEmpty &&
              question.selectedOption!.isNotEmpty &&
              question.subQuestions[question.selectedOption] != null) {
            extractAnswerRecursive(
                question.subQuestions[question.selectedOption]!, presetAnswers);
          }
        } else if (question is MultipleChoiceQuestion) {
          // 如果问题有子问题，递归调用
          for (var subQuestion in question.selectedOptions) {
            if (question.subQuestions.isNotEmpty &&
                question.subQuestions[subQuestion] is List<Question>) {
              extractAnswerRecursive(
                  question.subQuestions[subQuestion]!, presetAnswers);
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
              extractAnswerRecursive(
                  question.subQuestions?[value], presetAnswers);
            } else if (subQuestions['default'] != null) {
              extractAnswerRecursive(subQuestions['default'], presetAnswers);
            }
          }
        } else if (question is MealQuestion) {
          // summary.add('Answer: ${question.meals}');
          for (var subQuestion in question.meals) {
            if (question.subQuestions.isNotEmpty &&
                question.subQuestions[subQuestion] is List<Question>) {
              extractAnswerRecursive(
                  question.subQuestions[subQuestion]!, presetAnswers);
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

    return questions;
  }

  // 递归获取问题和回答
  void extractAnswerRecursive(
      List<Question>? questions, Map<String, dynamic> answers) {
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
                question.subQuestions[question.selectedOption]!, answers);
          }
        } else if (question is MultipleChoiceQuestion) {
          // 如果问题有子问题，递归调用
          for (var subQuestion in question.selectedOptions) {
            if (question.subQuestions.isNotEmpty &&
                question.subQuestions[subQuestion] is List<Question>) {
              extractAnswerRecursive(
                  question.subQuestions[subQuestion]!, answers);
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
              extractAnswerRecursive(question.subQuestions?[value], answers);
            } else if (subQuestions['default'] != null) {
              extractAnswerRecursive(subQuestions['default'], answers);
            }
          }
        } else if (question is MealQuestion) {
          // summary.add('Answer: ${question.meals}');
          for (var subQuestion in question.meals) {
            if (question.subQuestions.isNotEmpty &&
                question.subQuestions[subQuestion] is List<Question>) {
              extractAnswerRecursive(
                  question.subQuestions[subQuestion]!, answers);
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

  Map<String, dynamic> extractAnswer(Survey survey) {
    List<Question>? questions = survey.questions;
    Map<String, dynamic> answers = survey.extra != null ? survey.extra! : {};

    extractAnswerRecursive(questions, answers);
    return answers;
  }

  // init State for some survey task
  Future<void> _initWidget() async {
    await _initializePreferences();
    Map answers = _userPref.getData('completedTaskAnswers');
    if (SummaryTaskIds.contains(widget.taskId) &&
        answers.containsKey(widget.taskId)) {
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

  Future<void> _initializeQuestions() async {
    // 如果有预设回答
    List<Question>? questions =
        await SurveyService.generateSurveyQuestions(widget.taskId);
    setState(() {
      if (questions != null) {
        widget.survey.questions = questions;
      }
      if (widget.presetAnswers != null && widget.presetAnswers!.isNotEmpty) {
        widget.survey.questions = fillSurveyWithPresetAnswer(
            widget.survey.questions, widget.presetAnswers);
      }
      isLoading = false;
    });

    // setState(() async {
    //   widget.survey.questions = await SurveyService.generateSurveyQuestions(widget.taskId) ?? [];
    // });

    // if (widget.taskId == 'S4') {
    //   setState(() async {
    //     widget.survey.questions = await generateDietPlanReview();
    //   });
    // } else if (widget.taskId == 'S5') {
    //   setState(() async {
    //     widget.survey.questions = await generateImpulseReview();
    //   });
    // }
  }

  // void _updateCustomAnswer(String questionKey, String answer) {
  //   setState(() {
  //     _customAnswers[questionKey] = answer;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // NOTE: this is currently only available for 冲动记录反思, please refactor it if other questionnaires are needed
    bool isNeedTopArea = widget.survey.isNeedTopArea;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.survey.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: isLoading
              ? customLoading()
              : Column(
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
                      children: List.generate(widget.survey.questions.length,
                          (index) {
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
          // 本地保存问卷记录
          await _userPref.updateSurveyData(widget.taskId, summary);

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

          if (res?.statusCode == 200 || res?.statusCode == 201) {
            if (mounted) {
              ref.read(progressProvider.notifier).updateProgress(widget.taskId);
              if (['task11', 'dietaryIntake'].contains(widget.taskId)) {
                answers[widget.taskId] = [];
                await _userPref.setData('completedTaskAnswers', answers);
              }
            }
          }

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
          } else if (widget.taskId == 'dietaryIntake') {
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MainScreen(initialTabIndex: 1), // 切换到 EventLog Tab
                ),
                (Route<dynamic> route) => false,
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
}
