 // 定义了用于创建survey的class和相关功能。

 abstract class Question {
  final String questionText;

  Question(this.questionText);
}

class SingleChoiceQuestion extends Question {
  final List<String> options;
  String? selectedOption;

  SingleChoiceQuestion(String questionText, this.options) : super(questionText);
}

class MultipleChoiceQuestion extends Question {
  final List<String> options;
  List<String> selectedOptions = [];

  MultipleChoiceQuestion(String questionText, this.options) : super(questionText);
}

class TextQuestion extends Question {
  String? answer;

  TextQuestion(String questionText) : super(questionText);
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
  void setAnswer(String textAnswer) {
    this.answer = textAnswer;
  }
}


extension SurveyExtension on Survey {
  bool isSurveyComplete() {
    for (var question in questions) {
      if (question is SingleChoiceQuestion && question.selectedOption == null) {
        return false;
      } else if (question is MultipleChoiceQuestion && question.selectedOptions.isEmpty) {
        return false;
      } else if (question is TextQuestion && question.answer == null) {
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
        print('Answer: ${question.answer}');
      }
    }
  }
}

