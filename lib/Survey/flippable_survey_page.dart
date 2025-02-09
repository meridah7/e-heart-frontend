import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/providers/user_provider.dart';
import 'package:namer_app/user_preference.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/models/survey_models.dart';
import 'survey_question_factory.dart';
import 'survey_summary_page.dart';
import 'package:namer_app/services/dio_client.dart';
import 'package:namer_app/providers/progress_provider.dart';

/// @desc 可翻页的问券
///
/// @note 当前需求只要求给问题全部分页 / 全部不分页，所以这个组件粗暴的把全部问题分页了，后续如果有混合诉求的话，则考虑把这个跟 SurveyPage 一起重构了
class FlippableSurveyPage extends StatefulWidget {
  FlippableSurveyPage({required this.survey, required this.taskId});

  // final bool isLastTask;
  final Survey survey;
  final String taskId;

  @override
  _FlippableSurveyPageState createState() => _FlippableSurveyPageState();
}

class _FlippableSurveyPageState extends State<FlippableSurveyPage> {
  final DioClient dioClient = DioClient();
  late Preferences _userPref;

  int _curStep = 0;

  Future<void> _initializePreferences() async {
    if (mounted) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      _userPref = await Preferences.getInstance(namespace: userProvider.uuid);
    }
  }

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Map<String, dynamic> extractAnswer(Survey survey, int step,
      {bool showText = false}) {
    List<Question>? questions = [survey.questions[step]];
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
          } else if (showText && question is TextQuestion) {
            // 数组形式
            if (question.canAddMore) {
              answers[question.questionText] = question.answers;
            } else {
              answers[question.questionText] = question.answers[0];
            }
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

  Future<void> handleSaveSummary(List<String> summary) async {
    // 本地保存问卷记录
    await _userPref.updateSurveyData(widget.taskId, summary);
  }

  void handleFirstImpulseStrategies() {
    // 获取先前回答
    var answers = extractAnswer(widget.survey, _curStep);

    // 生成第二步内容
    if (_curStep == 0) {
      List<String> options = [];
      answers.forEach((key, value) {
        if (key != 'q3') {
          options.addAll(value);
        } else {
          options.add('听音乐');
        }
      });
      Map<String, List<Question>> subQuestions = {};
      for (var element in options) {
        subQuestions[element] = [TextQuestion('$element具体执行方法', false)];
      }
      widget.survey.questions[1] = SingleChoiceQuestion('第二步，计划具体执行方法', [
        '好的！'
      ], {
        '好的！': [
          MultipleChoiceQuestion(
              '比如：去看一本书。具体策略：“我可以在电子书中找到武侠小说来看，比如金庸的《射雕英雄传》”',
              options,
              subQuestions,
              description: '',
              alias: 'q4')
        ]
      });
    } else if (_curStep == 1) {
      List<String> options = [];
      answers.forEach((key, value) {
        if (key != 'q3') {
          options.addAll(value);
        } else {
          options.add('听音乐');
        }
      });
      widget.survey.questions[2] = SingleChoiceQuestion('第三步，策略排序', [
        '好的！'
      ], {
        '好的！': [
          PriorityQuestion('请将你认为应对暴食/清除食物冲动最有效的活动排在前面.', options,
              description: '', alias: 'q5'),
        ]
      });
    }

    print('prevAnswers $answers');
  }

  Future<void> handleSubmitImpulseStrategies() async {
    var answerOrders = extractAnswer(widget.survey, 2);
    List<String> orders = answerOrders['q5'];
    var answerStrategies = extractAnswer(widget.survey, 1, showText: true);
    var methods = {};
    answerStrategies.forEach((key, value) {
      if (key.contains('具体执行方法')) {
        var name = key.replaceAll('具体执行方法', '');
        methods[name] = value;
      }
    });
    print('method $methods');
    List<Map<String, String>> strategies = [];
    for (var element in orders) {
      strategies.add({
        'custom_activity': element,
        'details': methods[element] ?? '',
      });
    }
    try {
      Response response =
          await dioClient.postRequest('/impulse/develop-coping-strategies/', {
        'strategies': strategies,
      });
      if (response.statusCode == 200) {
        // 更新用户进度

        if (mounted) {
          var progressProvider =
              Provider.of<ProgressProvider>(context, listen: false);
          progressProvider.updateProgress(widget.taskId);
          Navigator.pushNamedAndRemoveUntil(
              context, '/home', (Route<dynamic> route) => false);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void nextStep() {
    setState(() {
      print('bbb i am here');
      if (_curStep < widget.survey.questions.length - 1) {
        print('aaa i am here');
        // 处理生成下一步的问卷问题
        if (widget.taskId == 'D1') {
          handleFirstImpulseStrategies();
        }
        _curStep = _curStep + 1;
      } else {
        // 获取问卷摘要
        List<String> summary = widget.survey.getSurveySummary();
// 打印问卷摘要到控制台
        for (String line in summary) {
          print(line);
        }
        handleSaveSummary(summary);
        // 冲动策略应对制定
        if (widget.taskId == 'D1') {
          handleSubmitImpulseStrategies();
        }

        // TODO 提交问卷添加进度接口
        // 更新用户进度
        var progressProvider =
            Provider.of<ProgressProvider>(context, listen: false);
        progressProvider.updateProgress(widget.taskId);
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
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, '/home', (Route<dynamic> route) => false);
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
