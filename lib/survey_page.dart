// 定义了survey界面，和创建不同类型问题的功能

import 'package:flutter/material.dart';
import 'survey_models.dart';


class SurveyPage extends StatefulWidget {
  final Survey survey;

  SurveyPage({required this.survey});

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.survey.title),
      ),
      body: ListView.builder(
        itemCount: widget.survey.questions.length,
        itemBuilder: (context, index) {
          final question = widget.survey.questions[index];

          if (question is SingleChoiceQuestion) {
            return buildSingleChoiceQuestion(question);
          } else if (question is MultipleChoiceQuestion) {
            return buildMultipleChoiceQuestion(question);
          } else if (question is TextQuestion) {
            return buildTextQuestion(question);
          }

          return SizedBox.shrink();  // 未知问题类型的默认处理
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          // Handle submission of the survey
          widget.survey.getSurveySummary();
        },
      ),
    );
  }

  //单选
  Widget buildSingleChoiceQuestion(SingleChoiceQuestion question) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(question.questionText, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ...question.options.map((option) => ListTile(
            title: Text(option),
            leading: Radio(
              value: option,
              groupValue: question.selectedOption,
              onChanged: (String? value) {
                setState(() {
                  question.answer(value!);
                });
              },
            ),
          )).toList()
        ],
      ),
    );
  }

  //多选
  Widget buildMultipleChoiceQuestion(MultipleChoiceQuestion question) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(question.questionText, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ...question.options.map((option) => CheckboxListTile(
            title: Text(option),
            value: question.selectedOptions.contains(option),
            onChanged: (bool? value) {
              setState(() {
                if (value!) {
                  question.selectedOptions.add(option);
                } else {
                  question.selectedOptions.remove(option);
                }
              });
            },
          )).toList()
        ],
      ),
    );
  }

  //文本
  Widget buildTextQuestion(TextQuestion question) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question.questionText, style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              onChanged: (value) {
                question.setAnswer(value);
              },
              decoration: InputDecoration(
                hintText: 'Enter your answer here',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
