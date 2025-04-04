import 'package:flutter/material.dart';
import 'package:namer_app/models/survey_models.dart'; // Import the location of your Survey models
import 'package:namer_app/pages/Survey/survey_page.dart'; // Import your SurveyPage widget if reusable

class FoodPurgePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SurveyPage(
        survey: foodPurgeSurvey,
        taskId: 'foodPurgeSurvey',
      ),
    );
  }
}

var foodPurgeSurvey = Survey(title: '食物清除记录', questions: [
  SingleChoiceQuestion(
    '首先，呈现三个注意事项：1.请努力在行为发生后尽快填写它！2.你不需要改变自己的行为，只需要努力真实地记录自己的情况就好。3.请记录下一天内的所有相关行为。',
    ['好的！'],
    {},
  ),
  TimeQuestion('清除食物的具体时间', initialTime: DateTime.now()),
  TextQuestion('你采取了哪种方式清除食物？', true,
      description: '请尽可能详细地描述你采取的方法，例如：自我诱吐、使用泻药等。'),
  SliderQuestion('情绪强度', {}, min: 1, max: 7, divisions: 6,
      labelBuilder: (value) {
    if (value == 1) {
      return '很不开心';
    } else if (value == 4)
      return '一般';
    else if (value == 7) return '超开心';
    return value.toInt().toString();
  }),
  MultipleChoiceQuestion(
      '情绪种类', ['伤心', '疲惫', '紧张', '无聊', '兴奋', '羞愧', '愤怒', '恐惧', '平静', '开心'], {}),
  TextQuestion('发生前的饮食情况', true,
      description: '请描述在你决定清除食物前，你吃了什么，包括食物种类和大概的量。'),
  TextQuestion('清除后的感受', true, description: '请描述在你清除食物后，你的身体和情绪感受。'),
  TextQuestion('是否有触发因素？', true, description: '如果有，请描述是什么因素促使了这次食物清除行为。'),
  TextQuestion('更多注释（想法，感受等等）', true,
      description:
          '记录任何可能会影响你这次行为的东西，不管是你的纠结，想法还是情绪都可以。努力写一些！这一块的记录往往会在之后成为你改善行为的奇招！'),
]);
