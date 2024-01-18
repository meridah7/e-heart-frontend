 // 定义了用于创建survey的class和相关功能。

 abstract class Question {
  final String questionText;
  final String? description; 

  Question(this.questionText, {this.description});

  
}

class SingleChoiceQuestion extends Question {
  final List<String> options;
  String? selectedOption;
  Map<String, Question> subQuestions; // 新增属性：存储二级问题的映射

  SingleChoiceQuestion(String questionText, this.options, this.subQuestions, {String? description}) :  super(questionText, description: description);

  void answer(String option) {
    if (options.contains(option)) {
      selectedOption = option;
    } else {
      print('Invalid option selected.');
    }
  }

  Question? getSubQuestion() {
    if (selectedOption != null) {
      return subQuestions[selectedOption!];
    }
    return null;
  }
}



class MultipleChoiceQuestion extends Question {
  final List<String> options;
  List<String> selectedOptions = [];
  Map<String, Question> subQuestions; // 存储二级问题的映射
  Map<String, bool>? additionalOptions; // 将additionalOptions设置为可空类型

 MultipleChoiceQuestion(String questionText, this.options, this.subQuestions, {Map<String, bool>? additionalOptions, String? description})
    : additionalOptions = additionalOptions ?? {}, // 设置默认值
      super(questionText, description: description);


  bool isSelected(String option) => selectedOptions.contains(option);

  // 新增方法，用于处理额外选项的选择状态
  void selectAdditionalOption(String option, bool isSelected) {
     additionalOptions?[option] = isSelected;
  }

  // 其他必要的方法...
}


class TextQuestion extends Question {
  List<String> answers; // 存储多个答案的列表
  bool canAddMore; // 判断是否可以增加更多选项的布尔值

  TextQuestion(String questionText, this.canAddMore, {String? description})
      : answers = [''],
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
