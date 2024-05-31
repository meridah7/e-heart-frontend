// 定义了survey界面，和创建不同类型问题的功能
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/global_setting.dart';
import 'survey_models.dart';
import 'SurveySummaryPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'survey_question_factory.dart';

import 'package:carousel_indicator/carousel_indicator.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  final List<String> images = [
    'https://via.placeholder.com/200',
    'https://via.placeholder.com/200',
    'https://via.placeholder.com/200',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CarouselSlider(
          items: images.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
// No need to check for null as `index` in onPageChanged should never be null.
// We validate index is within the range of our images list size.
              if (index >= 0 && index < images.length) {
                setState(() {
                  _currentIndex = index;
                });
              } else {
// Log this situation as it should never happen if images are set correctly
                debugPrint(
                    'Invalid pageIndex: $index detected in onPageChanged.');
              }
            },
          ),
        ),
        CarouselIndicator(
          count: images.length,
          index: _currentIndex, // 这里不再需要条件逻辑，因为 _currentIndex 现在应该始终有效。
        ),
      ],
    );
  }
}

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
          Widget questionWidget =
              questionWidgetFactory(context, question, setState);

          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 16.0,
            ),
            child: questionWidget,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
// 获取问卷摘要
          List<String> summary = widget.survey.getSurveySummary();

// 打印问卷摘要到控制台
          for (String line in summary) {
            print(line);
          }

// 导航到问卷摘要页面
          if (widget.survey.navigateToSummary) {
// 导航到问卷摘要页面
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurveySummaryPage(summary: summary),
              ),
            );
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
