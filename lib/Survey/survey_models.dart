import 'package:flutter/material.dart';
import 'package:namer_app/ResponseCard/response_card_model.dart';
import 'dart:math';

// 定义了用于创建survey的class和相关功能。

abstract class Question {
  final String questionText;
  final String? description;
  final String? imageUrl;
  final List<String>? imageUrls;

  Question(
    this.questionText, {
    this.description,
    this.imageUrl,
    this.imageUrls,
  });
}

class SingleChoiceQuestion extends Question {
  final List<String> options;
  String? selectedOption;
  Map<String, List<Question>> subQuestions; // Change to a map of lists

  SingleChoiceQuestion(String questionText, this.options, this.subQuestions,
      {String? description})
      : super(questionText, description: description);

  void answer(String option) {
    if (options.contains(option)) {
      selectedOption = option;
    } else {
      print('Invalid option selected.');
    }
  }

  List<Question>? getSubQuestions() {
    if (selectedOption != null) {
      return subQuestions[selectedOption!];
    }
    return null;
  }
}

class MultipleChoiceQuestion extends Question {
  final List<String> options;
  List<String> selectedOptions = [];
  Map<String, List<Question>>
      subQuestions; // Map each option to a list of Questions
  Map<String, bool>? additionalOptions; // Optional additional options

  MultipleChoiceQuestion(String questionText, this.options, this.subQuestions,
      {this.additionalOptions, String? description})
      : super(questionText, description: description);

  bool isSelected(String option) => selectedOptions.contains(option);

  void selectAdditionalOption(String option, bool isSelected) {
    if (additionalOptions != null) {
      additionalOptions![option] = isSelected;
    }
  }

  List<Question>? getSubQuestionsForOption(String option) {
    return subQuestions[option];
  }

  // Other necessary methods...
}

class TextQuestion extends Question {
  List<String> answers; // Assuming a list of answers
  List<TextEditingController> controllers; // 这里新增一个控制器列表
  bool canAddMore;
  @override
  List<String> imageUrls; // 新增的图片 URL 列表

  TextQuestion(String questionText, this.canAddMore,
      {String? description, List<String>? imageUrls})
      : answers = [''], // Initialize with an empty string
        controllers = [TextEditingController()], // 初始化控制器列表
        imageUrls = imageUrls ?? [], // 初始化图片 URL 列表
        super(questionText, description: description, imageUrls: imageUrls);

  void addAnswer(String answer) {
    if (!canAddMore) return; // 如果 canAddMore 为 false,直接返回
    answers.add(answer);
    controllers.add(TextEditingController()); // 为新答案添加一个新控制器
  }

  void removeAnswer(int index) {
    if (index >= 0 && index < answers.length) {
      answers.removeAt(index);
      controllers[index].dispose(); // 释放被移除答案的控制器资源
      controllers.removeAt(index); // 从列表中移除控制器
    }
  }
}

class Survey {
  final String title;
  final List<Question> questions;
  final bool navigateToSummary;
  final bool isNeedTopArea;

  Survey(
      {required this.title,
      required this.questions,
      this.navigateToSummary = false,
      this.isNeedTopArea = false});
}

extension SingleChoiceQuestionExtension on SingleChoiceQuestion {
  void answer(String option) {
    if (options.contains(option)) {
      selectedOption = option;
    } else {
      print('Invalid option selected.');
    }
  }
}

extension MultipleChoiceQuestionExtension on MultipleChoiceQuestion {
  void answer(List<String> choices) {
    if (choices.every((choice) => options.contains(choice))) {
      selectedOptions = choices;
    } else {
      print('Invalid options selected.');
    }
  }
}

extension TextQuestionExtension on TextQuestion {
  void setAnswer(List<String> textAnswers) {
    answers = textAnswers;
  }
}

extension SurveyExtension on Survey {
  bool isSurveyComplete() {
    for (var question in questions) {
      if (question is SingleChoiceQuestion && question.selectedOption == null) {
        return false;
      } else if (question is MultipleChoiceQuestion &&
          question.selectedOptions.isEmpty) {
        return false;
      } else if (question is TextQuestion && question.answers.isEmpty) {
        return false;
      }
    }
    return true;
  }

  // TODO:JSON Format
  void toJson() {}

  // TODO:JSON Format
  List<Question> fromJson() {
    return [];
  }

  List<String> getSurveySummary() {
    List<String> summary = [];
    // 递归获取问题和回答
    void summarizeQuestions(List<Question> questions) {
      if (questions.isEmpty) {
        return;
      }
      for (var question in questions) {
        try {
          summary.add(question.questionText);
          if (question is SingleChoiceQuestion) {
            summary.add('Answer: ${question.selectedOption}');
            if (question.selectedOption != null &&
                question.subQuestions.isNotEmpty &&
                question.selectedOption!.isNotEmpty &&
                question.subQuestions[question.selectedOption] != null) {
              summarizeQuestions(
                  question.subQuestions[question.selectedOption]!);
            }
          } else if (question is MultipleChoiceQuestion) {
            summary.add('Answers: ${question.selectedOptions.join(", ")}');
            // 如果问题有子问题，递归调用
            for (var subQuestion in question.selectedOptions) {
              if (question.subQuestions.isNotEmpty &&
                  question.subQuestions[subQuestion] is List<Question>) {
                summarizeQuestions(question.subQuestions[subQuestion]!);
              }
            }
          } else if (question is TextQuestion) {
            summary.add('Answer: ${question.answers[0]}');
          } else if (question is TimeQuestion) {
            summary.add('Answer: ${question.selectedTime}');
          } else if (question is SliderQuestion) {
            summary.add('Answer: ${question.sliderValue}');
          } else if (question is MealQuestion) {
            summary.add('Answer: ${question.meals}');
            for (var subQuestion in question.meals) {
              if (question.subQuestions.isNotEmpty &&
                  question.subQuestions[subQuestion] is List<Question>) {
                summarizeQuestions(question.subQuestions[subQuestion]!);
              }
            }
          } else if (question is PriorityQuestion) {
            summary.add('Answer: ${question.selectedOptions}');
          }
        } catch (e) {
          print('Error in summarize question ${question.questionText} $e');
          throw Exception(e);
        }
      }
    }

    summarizeQuestions(questions);
    return summary;
  }
}
//   List<String> getSurveySummary() {
//     List<String> summary = [];
//     for (var question in questions) {
//       print(question.questionText);
//       summary.add(question.questionText);

//       if (question is SingleChoiceQuestion) {
//         print('Answer: ${question.selectedOption}');
//         summary.add('Answer: ${question.selectedOption}');
//       } else if (question is MultipleChoiceQuestion) {
//         print('Answers: ${question.selectedOptions.join(", ")}');
//         summary.add('Answers: ${question.selectedOptions.join(", ")}');
//       } else if (question is TextQuestion) {
//         print('Answer: ${question.answers}');
//         summary.add('Answer: ${question.answers}');
//       }
//     }
//     return summary;
//   }
// }

class TimeQuestion extends Question {
  DateTime selectedTime;

  TimeQuestion(String questionText,
      {DateTime? initialTime, String? description})
      : selectedTime = initialTime ?? DateTime.now(),
        super(questionText, description: description);

  void setTime(DateTime newTime) {
    selectedTime = newTime;
  }
}

class SliderQuestion extends Question {
  double sliderValue;
  final double min;
  final double max;
  final int divisions;
  final String Function(double) labelBuilder;
  Map<String, List<Question>>? subQuestions;

  SliderQuestion(
    String questionText,
    this.subQuestions, {
    this.sliderValue = 1.0,
    this.min = 1.0,
    this.max = 7.0,
    this.divisions = 6,
    required this.labelBuilder,
    String? description,
  }) : super(questionText, description: description) {
    subQuestions ??= {};
  }

  List<Question>? getSubQuestions(bool Function(double value)? condition) {
    bool isNeedSubQuestion = true;
    if (condition != null) {
      isNeedSubQuestion = condition(sliderValue);
    }
    // note: For some reasons, flutter can only assert types for local variable within if condition exp
    Map<String, List<Question>>? subQuestions = this.subQuestions;
    if (subQuestions != null && isNeedSubQuestion) {
      return subQuestions[sliderValue.toString()] ?? subQuestions['default'];
    }
    return null;
  }
}

class ChartData {
  final String category;
  final int value;

  ChartData(this.category, this.value);
}

enum QuestionType { SingleChoice, MultipleChoice, Text, None }

enum ChartOrientation { horizontal, vertical, pie }

class ChartQuestion extends Question {
  final List<ChartData> chartData;
  final QuestionType questionType;
  final List<String> options;
  final ChartOrientation orientation; // 添加这个属性
  String? selectedOption;
  List<String> selectedOptions = [];
  String? answerText;
  final ChartType chartType; // 添加一个用于存储图表类型的属性

  ChartQuestion(
    String questionText,
    this.chartData,
    this.questionType,
    this.options,
    this.chartType, // 在构造函数中添加一个参数来接收图表类型
    {
    String? description,
    this.orientation = ChartOrientation.vertical, // 默认为竖直方向
  }) : super(questionText, description: description);

  void answer(String option) {
    if (questionType == QuestionType.SingleChoice && options.contains(option)) {
      selectedOption = option;
    } else if (questionType == QuestionType.MultipleChoice &&
        options.contains(option)) {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    } else if (questionType == QuestionType.Text) {
      answerText = option;
    }
    // 对于 QuestionType.None，不需要执行任何操作
  }
}

enum ChartType { Bar, Pie, None, Bulleted, Line }

class ResponseCardQuestion extends Question {
  final List<ResponseCardModel> listData;
  final QuestionType questionType = QuestionType.None;
  String? selectedOption;
  List<String> selectedOptions = [];
  String? answerText;

  ResponseCardQuestion(
    String questionText,
    this.listData,
  ) : super(questionText);
}

class PriorityQuestion extends Question {
  final List<String> options;
  List<String> selectedOptions = []; // 用户选中的选项，按点击顺序排序

  PriorityQuestion(String questionText, this.options, {String? description})
      : super(questionText, description: description);

  void selectOption(String option) {
    if (!selectedOptions.contains(option)) {
      selectedOptions.add(option); // 添加新选中的选项
    } else {
      selectedOptions.remove(option); // 如果已选中，则取消选中
    }
  }

  // 获取用户选中的选项，按点击顺序
  List<String> getSelectedOptions() => selectedOptions;
}

class MealQuestion extends Question {
  List<String> meals;
  Map<String, List<Question>> subQuestions;

  MealQuestion(
    String questionText,
    this.subQuestions, {
    String? description,
  })  : meals = [],
        super(questionText, description: description);

  void addMeal(String meal) {
    meals.add(meal);
    subQuestions[meal] = []; // 为新餐食初始化子问题列表
  }

  void removeMeal(String meal) {
    meals.remove(meal);
    subQuestions.remove(meal); // 移除对应餐食的子问题
  }

  void addSubQuestion(String meal, Question question) {
    subQuestions[meal]?.add(question);
  }
}
