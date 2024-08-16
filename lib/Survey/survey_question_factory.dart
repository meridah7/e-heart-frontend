import 'survey_models.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:namer_app/Survey/survey_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:namer_app/ResponseCard/swipeable_response_card.dart';

Widget questionWidgetFactory(BuildContext context, Question question,
    void Function(void Function()) setState) {
  Widget questionWidget;

  if (question is SingleChoiceQuestion) {
    questionWidget = buildSingleChoiceQuestion(context, question, setState);
  } else if (question is MultipleChoiceQuestion) {
    questionWidget = buildMultipleChoiceQuestion(context, question, setState);
  } else if (question is TextQuestion) {
    questionWidget = buildTextQuestion(question, setState);
  } else if (question is TimeQuestion) {
    questionWidget = buildTimeQuestion(context, question, setState);
  } else if (question is ChartQuestion) {
    // 添加这个条件
    questionWidget = buildChartQuestion(question, setState); // 调用构建柱状图问题的方法
  } else if (question is PriorityQuestion) {
    questionWidget = buildPriorityQuestion(question, setState);
  } else if (question is MealQuestion) {
    questionWidget = buildMealQuestion(context, question, setState);
  } else if (question is SliderQuestion) {
    questionWidget = buildSliderQuestion(context, question, setState);
  } else if (question is ResponseCardQuestion) {
    questionWidget = buildResponseCardQuestion(context, question, setState);
  } else {
    questionWidget = SizedBox.shrink(); // Handle unknown question type
  }

  return questionWidget;
}

//单选
Widget buildSingleChoiceQuestion(BuildContext context,
    SingleChoiceQuestion question, void Function(void Function()) setState) {
  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align to the start (left)
      children: [
        if (question.imageUrls != null &&
            question.imageUrls!.isNotEmpty) // 如果有图片 URLs，则显示图片轮播图
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              viewportFraction: 0.8,
            ),
            items: question.imageUrls!.map((url) {
              return Image.network(url);
            }).toList(),
          ),
        if (question.imageUrl != null) // 如果有图片 URL，则显示图片
          Image.network(question.imageUrl!),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TitleText(question.questionText),
        ),
        if (question.description != null) // 检查是否有描述（副标题）
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: DescriptionText(question.description!), // 显示描述（副标题）
          ),
        ...question.options.map((option) {
          return InkWell(
            onTap: () {
              setState(() {
                question.answer(option);
// Trigger a state update to show/hide sub-questions
              });
            },
            hoverColor: Colors.grey[200], // 鼠标悬停时的颜色
            child: Container(
              color: Colors.transparent, // 设置为透明以显示ink效果
              child: ListTile(
                title: Text(option),
                leading: Radio<String>(
                  value: option,
                  groupValue: question.selectedOption,
                  onChanged: (String? value) {
                    setState(() {
                      question.answer(value!);
// Trigger a state update to show/hide sub-questions
                    });
                  },
                ),
              ),
            ),
          );
        }).toList(),
        if (question.selectedOption != null &&
            question.subQuestions.containsKey(question.selectedOption))
          ...buildSubQuestions(context,
              question.subQuestions[question.selectedOption!]!, setState),
      ],
    ),
  );
}

//多选
// 多选问题的Widget，其中包含二级问题的逻辑
Widget buildMultipleChoiceQuestion(BuildContext context,
    MultipleChoiceQuestion question, void Function(void Function()) setState) {
  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (question.imageUrl != null) // 如果有图片 URL，则显示图片
          Image.network(question.imageUrl!),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TitleText(question.questionText),
        ),
        if (question.description != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
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
                      if (!question.selectedOptions.contains(option)) {
                        question.selectedOptions.add(option);
                      }
                    } else {
                      question.selectedOptions.remove(option);
                    }
                  });
                },
              ),
              if (question.isSelected(option) &&
                  question.subQuestions.containsKey(option))
                Column(
                  children: question.subQuestions[option]!
                      .map((subQuestion) =>
                          buildSubQuestion(context, subQuestion, setState))
                      .toList(),
                ),
            ],
          );
        }).toList(),
        if (question.additionalOptions != null &&
            question.additionalOptions!.isNotEmpty)
          CustomElevatedButton(
            text: '选择更多',
            onPressed: () => _showMoreChoices(
                context, question.additionalOptions!, setState),
          ),
        SizedBox(height: 10),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //   child: TextField(
        //     decoration: InputDecoration(
        //       hintText: '自定义',
        //       border: OutlineInputBorder(),
        //     ),
        //     onChanged: (value) {
        //       _updateCustomAnswer(question.questionText, value);
        //     },
        //   ),
        // ),
        SizedBox(height: 10),
      ],
    ),
  );
}

void _showMoreChoices(BuildContext context, Map<String, bool> moreChoices,
    void Function(void Function()) setState) {
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

//文本
Widget buildTextQuestion(
    TextQuestion question, void Function(void Function()) setState) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 确保列内的子组件靠左对齐
        children: [
          // 显示所有的图片
          for (final imageUrl in question.imageUrls)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(imageUrl),
            ),
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
                    controller: question.controllers[index], // 使用对应的控制器
// TextEditingController(text: question.answers[index]),
                    onChanged: (value) {
                      setState(() {
                        question.answers[index] = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: '填写答案',
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

Widget buildTimeQuestion(BuildContext context, TimeQuestion question,
    void Function(void Function()) setState) {
// Method to show the time picker
  void showTimePicker() async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: CupertinoDatePicker(
            mode:
                CupertinoDatePickerMode.time, // Display only hours and minutes
            use24hFormat: true, // Use 24-hour format
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
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align content to the left
        children: [
          TitleText(question.questionText),
          SizedBox(height: 10),
          if (question.description != null)
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: DescriptionText(question.description!),
            ),
          Text(
// Display the selected date and time
            '${question.selectedTime.year}年${question.selectedTime.month}月${question.selectedTime.day}日 时间: ${question.selectedTime.hour}:${question.selectedTime.minute.toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          CustomElevatedButton(
            text: 'Change Time',
            onPressed: showTimePicker,
          ),
        ],
      ),
    ),
  );
}

Widget buildChartQuestion(
    ChartQuestion question, void Function(void Function()) setState) {
  List<Widget> children = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TitleText(question.questionText),
    ),
  ];

  if (question.chartType == ChartType.Bar) {
    List<charts.Series<ChartData, String>> seriesList = [
      charts.Series<ChartData, String>(
        id: 'ChartData',
        domainFn: (ChartData data, _) => data.category,
        measureFn: (ChartData data, _) => data.value,
        data: question.chartData,
        labelAccessorFn: (ChartData data, _) =>
            '${data.category}: ${data.value}',
      ),
    ];

    children.add(
      SizedBox(
        height: 200.0,
        child: question.orientation == ChartOrientation.vertical
            ? charts.BarChart(seriesList, animate: true)
            : charts.BarChart(
                seriesList,
                animate: true,
                vertical: false,
              ),
      ),
    );
  } else if (question.chartType == ChartType.Bulleted) {
    children.add(
      SizedBox(
        height: 120.0,
        child: ListView.builder(
          itemCount: question.chartData.length,
          itemBuilder: (context, index) {
            final data = question.chartData[index];
            return Text(
              ' - ${data.category}',
              style: TextStyle(
                fontSize: 18, // 设置字体大小
                fontWeight: FontWeight.bold, // 设置字体加粗
              ),
            );
          },
        ),
      ),
    );
  } else if (question.chartType == ChartType.Line) {
    // List<charts.Series<ChartData, num>> seriesList = [
    //   charts.Series<ChartData, num>(
    //     id: 'ChartData',
    //     domainFn: (ChartData data, _) => data.category,
    //     measureFn: (ChartData data, _) => data.value,
    //     data: question.chartData,
    //     labelAccessorFn: (ChartData data, _) =>
    //         '${data.category}: ${data.value}',
    //   ),
    // ];

    // children.add(
    //   SizedBox(
    //     height: 200.0,
    //     child: question.orientation == ChartOrientation.horizontal
    //         ? charts.LineChart(seriesList, animate: true)
    //         : charts.LineChart(
    //             seriesList as dynamic,
    //             animate: true,
    //             flipVerticalAxis: true,
    //           ),
    //   ),
    // );
  }

  children.addAll([
    if (question.questionType != QuestionType.None)
      if (question.questionType == QuestionType.SingleChoice ||
          question.questionType == QuestionType.MultipleChoice)
        ...buildChoiceOptions(question, setState),
    if (question.questionType == QuestionType.Text)
      buildTextOption(question, setState),
  ]);

  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );
}

Widget buildResponseCardQuestion(BuildContext context,
    ResponseCardQuestion question, void Function(void Function()) setState) {
  return SizedBox(height: 630, child: SwipeableResponseCardList());
}

List<Widget> buildChoiceOptions(
    ChartQuestion question, void Function(void Function()) setState) {
  List<Widget> optionWidgets = [];
  for (var option in question.options) {
    Widget optionWidget;
    if (question.questionType == QuestionType.SingleChoice) {
      optionWidget = ListTile(
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
      );
    } else {
      optionWidget = CheckboxListTile(
        title: Text(option),
        value: question.selectedOptions.contains(option),
        onChanged: (bool? value) {
          setState(() {
            question.answer(option);
          });
        },
      );
    }
    optionWidgets.add(optionWidget);
  }
  return optionWidgets;
}

Widget buildTextOption(
    ChartQuestion question, void Function(void Function()) setState) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      onChanged: (value) {
        setState(() {
          question.answer(value);
        });
      },
      decoration: InputDecoration(
        hintText: '输入你的答案',
        border: OutlineInputBorder(),
      ),
    ),
  );
}

Widget buildPriorityQuestion(
    PriorityQuestion question, void Function(void Function()) setState) {
  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TitleText(question.questionText),
        ),
        ...question.options.map((option) {
          return ListTile(
            title: Text(option),
            trailing: question.selectedOptions.contains(option)
                ? Icon(Icons.check_box)
                : Icon(Icons.check_box_outline_blank),
            onTap: () {
              setState(() {
                question.selectOption(option);
              });
            },
          );
        }).toList(),
// 在这里添加显示已选择选项的顺序
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "已选择的顺序：",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
// 显示已选择选项的列表，包括顺序号
        ...question.selectedOptions.asMap().entries.map((entry) {
          int idx = entry.key + 1; // 顺序号（从1开始）
          String option = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text("$idx. $option"),
          );
        }).toList(),
      ],
    ),
  );
}

Widget buildMealQuestion(BuildContext context, MealQuestion question,
    void Function(void Function()) setState) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (question.imageUrl != null) Image.network(question.imageUrl!),
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
          ...question.meals.map((meal) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(meal)),
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          question.removeMeal(meal);
                        });
                      },
                    ),
                  ],
                ),
                ...buildSubQuestions(
                    context, question.subQuestions[meal]!, setState),
              ],
            );
          }).toList(),
          TextButton(
            child: Text('点击添加计划餐食'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  String newMeal = '';
                  String mealItems = '';
                  return AlertDialog(
                    title: Text('添加新餐食'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          onChanged: (value) {
                            newMeal = value;
                          },
                          decoration: InputDecoration(hintText: '输入餐食名称'),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text('取消'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('确定'),
                        onPressed: () {
                          setState(() {
                            question.addMeal(newMeal);
                            question.addSubQuestion(
                              newMeal,
                              TextQuestion('请列出" $newMeal "要进食的食物和份量', true),
                            );
                            question.addSubQuestion(
                              newMeal,
                              TimeQuestion('" $newMeal "的时间',
                                  initialTime: DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                      7,
                                      0)),
                            );
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    ),
  );
}

Widget buildSliderQuestion(BuildContext context, SliderQuestion question,
    void Function(void Function()) setState) {
  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        ...?question.getSubQuestions((value) => value > 0)?.map((subQuestion) {
          return buildSubQuestion(
              context, subQuestion, setState); // 使用和之前一样的子问题构建逻辑
        }).toList(),
      ],
    ),
  );
}

//  --- SubQuestions below ---
List<Widget> buildSubQuestions(BuildContext context,
    List<Question> subQuestions, void Function(void Function()) setState) {
  return subQuestions.map((subQuestion) {
    if (subQuestion is SingleChoiceQuestion ||
        subQuestion is MultipleChoiceQuestion) {
// 当问题是单选或多选时，递归地构建其子问题
      return buildSubQuestion(context, subQuestion, setState);
    } else {
      // 对于其他类型的问题，直接构建对应的 Widget
      // TODO: Find out what's different
      return buildSubQuestion(context, subQuestion, setState);
    }
  }).toList();
}

Widget buildSubQuestion(BuildContext context, Question subQuestion,
    void Function(void Function()) setState) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Card(
      elevation: 2.0, // Adjust elevation for shadow effect
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (subQuestion is SingleChoiceQuestion)
              buildSubSingleChoiceQuestion(context, subQuestion, setState),
            if (subQuestion is MultipleChoiceQuestion)
              buildSubMultipleChoiceQuestion(context, subQuestion, setState),
            if (subQuestion is TextQuestion)
              buildSubTextQuestion(subQuestion, setState),
            if (subQuestion is TimeQuestion)
              buildSubTimeQuestion(context, subQuestion, setState),
            if (subQuestion is SliderQuestion)
              buildSliderQuestion(context, subQuestion, setState),
            if (subQuestion is PriorityQuestion)
              buildPriorityQuestion(subQuestion, setState),
            if (subQuestion is ResponseCardQuestion)
              buildResponseCardQuestion(context, subQuestion, setState),
            if (subQuestion is ChartQuestion)
              buildChartQuestion(subQuestion, setState)
          ],
        ),
      ),
    ),
  );
}

Widget buildSubSingleChoiceQuestion(BuildContext context,
    SingleChoiceQuestion question, void Function(void Function()) setState) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (question.imageUrls != null &&
          question.imageUrls!.isNotEmpty) // 如果有图片 URLs，则显示图片轮播图
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
          ),
          items: question.imageUrls!.map((url) {
            return Image.network(url);
          }).toList(),
        ),
      if (question.imageUrl != null) // 如果有图片 URL，则显示图片
        Image.network(question.imageUrl!),
      Padding(
        padding: const EdgeInsets.all(8.0),
// 使用Text Widget来显示问题文本，并应用自定义样式

        child: Text(
          question.questionText,
          style: TextStyle(
            fontSize: 18, // 设置字体大小
// 你可以继续添加其他样式属性，如字体颜色等
          ),
        ),
      ),
      if (question.description != null)
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
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
        ...buildSubQuestions(context,
            question.subQuestions[question.selectedOption!]!, setState),
    ],
  );
}

Widget buildSubMultipleChoiceQuestion(BuildContext context,
    MultipleChoiceQuestion question, void Function(void Function()) setState) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (question.imageUrl != null) // 如果有图片 URL，则显示图片
        Image.network(question.imageUrl!),
      Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 8.0),
        child: Text(
          question.questionText,
          style: TextStyle(
            fontSize: 18, // 设置字体大小
// 你可以继续添加其他样式属性，如字体颜色等
          ),
        ),
      ),
      if (question.description != null)
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
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
                    if (!question.selectedOptions.contains(option)) {
                      question.selectedOptions.add(option);
                    }
                  } else {
                    question.selectedOptions.remove(option);
                  }
                });
              },
            ),
            if (question.isSelected(option) &&
                question.subQuestions.containsKey(option))
              ...buildSubQuestions(
                  context, question.subQuestions[option]!, setState),
          ],
        );
      }).toList(),

// Optionally add additional widgets here if needed
    ],
  );
}

Widget buildSubTextQuestion(
    TextQuestion question, void Function(void Function()) setState) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (question.imageUrl != null) Image.network(question.imageUrl!),
      Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 8.0),
        child: Text(
          question.questionText,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      if (question.description != null)
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          child: DescriptionText(question.description!),
        ),
      SizedBox(height: 16.0),
      ...List.generate(question.answers.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: question.controllers[index],
                  decoration: InputDecoration(
                    hintText: '输入你的答案',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      question.answers[index] = value;
                    });
                  },
                ),
              ),
              if (index > 0)
                IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    setState(() {
                      question.removeAnswer(index);
                    });
                  },
                ),
            ],
          ),
        );
      }),
      if (question.canAddMore)
        TextButton(
          child: Text('Add another answer'),
          onPressed: () {
            setState(() {
              question.addAnswer('');
            });
          },
        ),
    ],
  );
}

// Adjust the buildSubTimeQuestion function to match the style
Widget buildSubTimeQuestion(BuildContext context, TimeQuestion question,
    void Function(void Function()) setState) {
  return ListTile(
    title: Text(
      question.questionText,
      style: TextStyle(
        fontSize: 18, // 设置字体大小
// 你可以继续添加其他样式属性，如字体颜色等
      ),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (question.description != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: DescriptionText(question.description!),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${question.selectedTime.hour}:${question.selectedTime.minute.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 14),
            ),
            ElevatedButton(
              onPressed: () => _selectTime(context, question, setState),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor, // 按钮文字颜色
              ),
              child: Text('改变时间'),
            ),
          ],
        ),
      ],
    ),
  );
}

// Helper function to show time picker
void _selectTime(BuildContext context, TimeQuestion question,
    void Function(void Function()) setState) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(question.selectedTime),
  );
  if (picked != null &&
      picked != TimeOfDay.fromDateTime(question.selectedTime)) {
    setState(() {
      question.selectedTime = DateTime(
        question.selectedTime.year,
        question.selectedTime.month,
        question.selectedTime.day,
        picked.hour,
        picked.minute,
      );
    });
  }
}
