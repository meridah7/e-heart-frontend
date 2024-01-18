// 定义了survey界面，和创建不同类型问题的功能

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/Survey/survey_widgets.dart';
import 'package:namer_app/global_setting.dart';
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
        backgroundColor: themeColor,
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
          } else if (question is TimeQuestion) {
            return buildTimeQuestion(question);
          }else if (question is SliderQuestion) {
            return buildSliderQuestion(question); // 使用同一个方法
          }

          return SizedBox.shrink(); // 未知问题类型的默认处理
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

  Map<String, String> _customAnswers = {};
  void _updateCustomAnswer(String questionKey, String answer) {
    setState(() {
      _customAnswers[questionKey] = answer;
    });
  }

  //单选
  Widget buildSingleChoiceQuestion(SingleChoiceQuestion question) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TitleText(question.questionText),
          ),
          if (question.description != null)
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: DescriptionText(question.description!),
            ),
          ...question.options
              .map((option) => ListTile(
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
                  ))
              .toList(),
          if (question.selectedOption != null &&
              question.subQuestions.containsKey(question.selectedOption))
            buildSubQuestion(
                question.subQuestions[question.selectedOption!]!) // 显示二级问题
        ],
      ),
    );
  }

  //多选
  // 多选问题的Widget，其中包含二级问题的逻辑
  Widget buildMultipleChoiceQuestion(MultipleChoiceQuestion question) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TitleText(question.questionText),
          ),
          if (question.description != null)
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: DescriptionText(question.description!),
            ),
          ...question.options.map((option) {
            return Column(
              children: [
                CheckboxListTile(
                  title: Text(option),
                  value: question.isSelected(option),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value ?? false) {
                        question.selectedOptions.add(option);
                      } else {
                        question.selectedOptions.remove(option);
                      }
                    });
                  },
                ),
                if (question.isSelected(option) &&
                    question.subQuestions.containsKey(option))
                  buildSubQuestion(question.subQuestions[option]!),
              ],
            );
          }).toList(),
          if (question.additionalOptions != null &&
              question.additionalOptions!.isNotEmpty)
             CustomElevatedButton(
                text: '选择更多',
                onPressed: () => _showMoreChoices(question.additionalOptions!),
              ),
          SizedBox(height: 10),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: '自定义',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _updateCustomAnswer(question.questionText, value);
            },
          ),
        ),
        SizedBox(height: 10),
        ],
      ),
    );
  }

// 构建二级问题的Widget
  Widget buildSubQuestion(Question subQuestion) {
    if (subQuestion is TextQuestion) {
      return buildTextQuestion(subQuestion); // 已定义的方法
    } else if (subQuestion is SingleChoiceQuestion) {
      return buildSingleChoiceQuestion(subQuestion); // 使用同一个方法
    } else if (subQuestion is MultipleChoiceQuestion) {
      return buildMultipleChoiceQuestion(subQuestion); // 使用同一个方法
    } 
    return SizedBox.shrink();
  }

  //文本
  Widget buildTextQuestion(TextQuestion question) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // 确保列内的子组件靠左对齐
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TitleText(question.questionText),
            ),
            if (question.description != null)
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: DescriptionText(question.description!),
              ),
            ...List.generate(question.answers.length, (index) {
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller:
                          TextEditingController(text: question.answers[index]),
                      onChanged: (value) {
                        setState(() {
                          question.answers[index] = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your answer here',
                      ),
                    ),
                  ),
                  if (index > 0) // 如果不是第一个TextField，显示一个删除按钮
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          question.removeAnswer(index);
                        });
                      },
                    ),
                ],
              );
            }),
            if (question.canAddMore) // 如果允许添加更多答案
              TextButton(
                child: Text('Add another answer'),
                onPressed: () {
                  setState(() {
                    question.addAnswer('');
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget buildTimeQuestion(TimeQuestion question) {
    // 用于显示时间选择器的方法
    void _showTimePicker() async {
      await showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time, // 只显示小时和分钟
              use24hFormat: true, // 使用24小时制
              initialDateTime: question.selectedTime,
              onDateTimeChanged: (DateTime newDateTime) {
                setState(() {
                  question.setTime(newDateTime);
                });
              },
            ),
          );
        },
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              question.questionText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text( // Display the static date here
            '${question.selectedTime.year}年${question.selectedTime.month}月${question.selectedTime.day}日',
            style: TextStyle(fontSize: 20),
          ),
            Text(
              '时间: ${question.selectedTime.hour}:${question.selectedTime.minute}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            CustomElevatedButton(
              text: 'Change Time',
              onPressed: _showTimePicker,
            )
          ],
        ),
      ),
    );
  }

  void _showMoreChoices(Map<String, bool> moreChoices) {
    showDialog<Map<String, bool>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // 使用StatefulBuilder来更新对话框内的状态
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('选择更多'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: moreChoices.keys.map((String key) {
                    return CheckboxListTile(
                      title: Text(key),
                      value: moreChoices[key],
                      onChanged: (bool? value) {
                        setState(() {
                          moreChoices[key] = value!;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('关闭'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('提交'),
                  onPressed: () {
                    Navigator.of(context).pop(moreChoices); // 返回更新后的moreChoices
                  },
                ),
              ],
            );
          },
        );
      },
    ).then((returnedChoices) {
      // 处理对话框返回的数据
      if (returnedChoices != null) {
        setState(() {
          // 更新原始State对象的moreChoices
        });
      }
    });
  }

  Widget buildSliderQuestion(SliderQuestion question) {
  return Card(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TitleText(question.questionText),
        ),
        if (question.description != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: DescriptionText(question.description!),
          ),
        Slider(
          value: question.sliderValue,
          min: question.min,
          max: question.max,
          divisions: question.divisions,
          label: question.labelBuilder(question.sliderValue),
          onChanged: (newValue) {
            setState(() {
              question.sliderValue = newValue;
            });
          },
        ),
      ],
    ),
  );
}

}


