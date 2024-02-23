import 'package:flutter/material.dart';
import 'package:namer_app/Survey/survey_models.dart'; // Import the location of your Survey models
import 'package:namer_app/Survey/survey_page.dart'; // Import your SurveyPage widget if reusable

// Assuming 'themeColor' is defined elsewhere in your application
const Color themeColor = Colors.blue; // Placeholder for the actual theme color

class DietMonitoringPage extends StatelessWidget {
  
  // Example survey object. Replace this with your actual survey object
  var dietaryIntakeSurvey = Survey(
  '饮食摄入调查',
  [
    SingleChoiceQuestion(
      '首先呈现三个注意事项：1.请努力在吃完后尽快填写它！2.你不需要改变自己的进食，只需要努力真实地记录自己的饮食情况就好。3.请记录下一天内的所有饮食，而不只是正餐。',
      ['好的！'],
      {},
    ),
   
    TimeQuestion('进食具体时间', initialTime: DateTime.now()),
    TextQuestion('吃了什么&吃了多少', true, description: '填写你这次进食吃下、喝下的所有东西以及大概的量。千万不要具体记录摄入食物的重量和卡路里！正确示例：八包薯片，一个八寸披萨，一小碗酸奶。'),
    SingleChoiceQuestion('属于哪一餐', ['早餐', '上午点心', '午餐', '下午点心', '晚餐', '夜宵', '零食', '饮料'], {}),
    SliderQuestion('情绪强度', min: 1, max: 7, divisions: 6, labelBuilder: (value) {
      if (value == 1) return '很不开心';
      else if (value == 4) return '一般';
      else if (value == 7) return '超开心';
      return value.toInt().toString();
    }),
    MultipleChoiceQuestion('情绪种类', ['伤心', '疲惫', '紧张', '无聊', '兴奋', '羞愧', '愤怒', '恐惧', '平静', '开心'], {}),
    SingleChoiceQuestion('在哪吃', ['家里', '学校', '工作地点', '餐馆', '外面', '其他'], {}, description: '选择你这次进食的所在之处。若没有对应选项，请于下方手动填写。'),
    TextQuestion('具体地点', false),
    SingleChoiceQuestion('有没有节食', ['有', '没有'], {}),
    SliderQuestion('是否暴食', min: 0, max: 10, divisions: 10, labelBuilder: (value) {
      if (value == 0) return '没有暴食';
      else if (value == 5) return '中度暴食';
      else if (value == 10) return '重度暴食';
      return value.toInt().toString();
    }),
    SingleChoiceQuestion('有没有清除食物的行为', ['有', '没有'], {}),
    TextQuestion('更多注释（想法，感受等等）', true, description: '记录任何可能会影响你这次饮食的东西，不管是你的纠结，想法还是情绪都可以。努力写一些！这一块的记录往往会在之后成为你改善暴食的奇招！'),
    MultipleChoiceQuestion('也许你有一些困惑：', ['我感觉记录我的饮食尤其是暴食是一件很羞耻的事情', '我极力想要忘记吃东西这件事，但记录自己吃了什么会让我更加专注于吃，这会不会让我更难受？', '我曾经记录过自己的饮食，但感觉没什么帮助', '我感觉很难坚持'], {}),
  ]
);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use the SurveyPage widget if it's designed to be directly reusable
      body: SurveyPage(survey: dietaryIntakeSurvey),
      // If you need to adapt the survey logic specifically for this page,
      // you might integrate it directly here instead of using SurveyPage.
    );
  }
}

