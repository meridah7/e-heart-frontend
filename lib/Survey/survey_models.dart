 // 定义了用于创建survey的class和相关功能。

 abstract class Question {
  final String questionText;
  final String? description; 

  Question(this.questionText, {this.description});

}

class SingleChoiceQuestion extends Question {
  final List<String> options;
  String? selectedOption;
  Map<String, List<Question>> subQuestions; // Change to a map of lists

  SingleChoiceQuestion(String questionText, this.options, this.subQuestions, {String? description})
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
  Map<String, List<Question>> subQuestions; // Map each option to a list of Questions
  Map<String, bool>? additionalOptions; // Optional additional options

  MultipleChoiceQuestion(String questionText, this.options, this.subQuestions, {this.additionalOptions, String? description})
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
  bool canAddMore;

  TextQuestion(String questionText, this.canAddMore, {String? description})
      : answers = [''], // Initialize with an empty string
        super(questionText, description: description);
  
  void addAnswer(String answer) {
    if (canAddMore) {
      answers.add(answer);
    }
  }

  void removeAnswer(int index) {
    if (index >= 0 && index < answers.length) {
      answers.removeAt(index);
    }
  }
}



class Survey {
  final String title;
  final List<Question> questions;

  Survey(this.title, this.questions);
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
    this.answers = textAnswers;
  }
}


extension SurveyExtension on Survey {
  bool isSurveyComplete() {
    for (var question in questions) {
      if (question is SingleChoiceQuestion && question.selectedOption == null) {
        return false;
      } else if (question is MultipleChoiceQuestion && question.selectedOptions.isEmpty) {
        return false;
      } else if (question is TextQuestion && question.answers.length == 0) {
        return false;
      }
    }
    return true;
  }

  void getSurveySummary() {
    for (var question in questions) {
      print(question.questionText);
      if (question is SingleChoiceQuestion) {
        print('Answer: ${question.selectedOption}');
      } else if (question is MultipleChoiceQuestion) {
        print('Answers: ${question.selectedOptions.join(", ")}');
      } else if (question is TextQuestion) {
        print('Answer: ${question.answers}');
      }
    }
  }
}


class TimeQuestion extends Question {
  DateTime selectedTime;


  TimeQuestion(String questionText, {DateTime? initialTime})
      : selectedTime = initialTime ?? DateTime.now(),
        super(questionText);

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

  SliderQuestion(String questionText, {
    this.sliderValue = 1.0,
    this.min = 1.0,
    this.max = 7.0,
    this.divisions = 6,
    required this.labelBuilder,
    String? description,
  }) : super(questionText, description: description);
}



class ChartData {
  final String category;
  final int value;

  ChartData(this.category, this.value);
}

enum QuestionType { SingleChoice, MultipleChoice, Text, None }

class ChartQuestion extends Question {
  final List<ChartData> chartData;
  final QuestionType questionType;
  final List<String> options;
  String? selectedOption;
  List<String> selectedOptions = [];
  String? answerText;

  ChartQuestion(String questionText, this.chartData, this.questionType, this.options, {String? description})
      : super(questionText, description: description);

  void answer(String option) {
    if (questionType == QuestionType.SingleChoice && options.contains(option)) {
      selectedOption = option;
    } else if (questionType == QuestionType.MultipleChoice && options.contains(option)) {
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

