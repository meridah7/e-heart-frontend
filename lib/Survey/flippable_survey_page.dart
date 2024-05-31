import 'package:flutter/material.dart';
import 'survey_models.dart';
import 'package:namer_app/global_setting.dart';

/// @desc 可翻页的问券
///
/// @note 当前需求只要求给问题全部分页 / 全部不分页，所以这个组件粗暴的把全部问题分页了，后续如果有混合诉求的话，则考虑把这个跟 SurveyPage 一起重构了
class FlippableSurveyPage extends StatefulWidget {
  final Survey survey;

  FlippableSurveyPage({required this.survey});

  @override
  _FlippableSurveyPageState createState() => _FlippableSurveyPageState();
}

class _FlippableSurveyPageState extends State<FlippableSurveyPage> {
  int _curStep = 0;

  void nextStep() {
    setState(() {
      if (_curStep < widget.survey.questions.length - 1) {
        _curStep = _curStep + 1;
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
        backgroundColor: themeColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 16.0,
        ),
        child: Icon(Icons.check),
      ),
    );
  }
}
