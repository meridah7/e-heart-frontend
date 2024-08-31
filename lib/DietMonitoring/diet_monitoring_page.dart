import 'package:flutter/material.dart';
import 'package:namer_app/Survey/survey_models.dart'; // Import the location of your Survey models
import 'package:namer_app/Survey/survey_page.dart'; // Import your SurveyPage widget if reusable
import 'package:namer_app/Tasks/Survey/tasks.dart';

// Assuming 'themeColor' is defined elsewhere in your application
const Color themeColor = Colors.blue; // Placeholder for the actual theme color

class DietMonitoringPage extends StatelessWidget {
  // Example survey object. Replace this with your actual survey object
  // var dietaryIntakeSurvey = Survey(title: '饮食日志', questions: [
  //   SingleChoiceQuestion(
  //     '首先呈现三个注意事项：\n'
  //     '1.请努力在吃完后尽快填写它！\n'
  //     '2.你不需要改变自己的进食，只需要努力真实地记录自己的饮食情况就好。\n'
  //     '3.请记录下一天内的所有饮食，而不只是正餐。',
  //     ['好的！'],
  //     {},
  //   ),
  //   MultipleChoiceQuestion(
  //     '你本次要做的记录包括',
  //     ['饮食记录', '食物清除记录'],
  //     {
  //       '食物清除记录': [
  //         TimeQuestion('食物清除的时间', initialTime: DateTime.now()),
  //         SliderQuestion('食物清除的时候感受到的情绪强度', {}, min: 1, max: 7, divisions: 6,
  //             labelBuilder: (value) {
  //           if (value == 1) {
  //             return '很不开心';
  //           } else if (value == 4)
  //             return '一般';
  //           else if (value == 7) return '超开心';
  //           return value.toInt().toString();
  //         }),
  //         MultipleChoiceQuestion('食物清除的时候感受到的情绪种类', [
  //           '伤心',
  //           '疲惫',
  //           '紧张',
  //           '无聊',
  //           '兴奋',
  //           '羞愧',
  //           '愤怒',
  //           '恐惧',
  //           '平静',
  //           '开心',
  //           '其他'
  //         ], {
  //           '其他': [
  //             TextQuestion('请输入其他情绪种类', false),
  //           ]
  //         }),
  //         TextQuestion('请努力识别这次食物清除的诱发因素并填写它！', false),
  //       ],
  //       '饮食记录': [
  //         TimeQuestion('进食具体时间', initialTime: DateTime.now()),
  //         TextQuestion('吃了什么&吃了多少', true,
  //             description:
  //                 '填写你这次进食吃下、喝下的所有东西以及大概的量。千万不要具体记录摄入食物的重量和卡路里！正确示例：八包薯片，一个八寸披萨，一小碗酸奶。'),
  //         SingleChoiceQuestion('属于哪一餐', [
  //           '早餐',
  //           '上午点心',
  //           '午餐',
  //           '下午点心',
  //           '晚餐',
  //           '夜宵',
  //           '零食',
  //           '饮料',
  //         ], {
  //           '其他': [
  //             SingleChoiceQuestion('其他类型', ['零食', '饮料'], {})
  //           ],
  //         }),
  //         SliderQuestion('进食的时候感受到的情绪强度', {}, min: 1, max: 7, divisions: 6,
  //             labelBuilder: (value) {
  //           if (value == 1) {
  //             return '很不开心';
  //           } else if (value == 4)
  //             return '一般';
  //           else if (value == 7) return '超开心';
  //           return value.toInt().toString();
  //         }),
  //         MultipleChoiceQuestion('情绪种类', [
  //           '伤心',
  //           '疲惫',
  //           '紧张',
  //           '无聊',
  //           '兴奋',
  //           '羞愧',
  //           '愤怒',
  //           '恐惧',
  //           '平静',
  //           '开心',
  //           '其他'
  //         ], {
  //           '其他': [
  //             TextQuestion('请输入其他情绪种类', false),
  //           ]
  //         }),
  //         SingleChoiceQuestion(
  //             '在哪吃',
  //             ['家里', '宿舍', '公司', '食堂', '饭店', '车上', '其他'],
  //             {
  //               '其他': [
  //                 TextQuestion('请输入其他地点', false),
  //               ],
  //               '家里': [
  //                 SingleChoiceQuestion('是在家里的', [
  //                   '客厅',
  //                   '卧室',
  //                   '餐桌',
  //                   '厨房',
  //                   '洗手间',
  //                   '其他'
  //                 ], {
  //                   '其他': [
  //                     TextQuestion('请输入其他地点', false),
  //                   ],
  //                 })
  //               ]
  //             },
  //             description: '选择你这次进食的所在之处。若没有对应选项，请于下方手动填写。'),
  //         SingleChoiceQuestion('有没有节食', ['有', '没有'], {}),
  //         // TODO: add some popup sub question
  //         SliderQuestion(
  //             '是否暴食',
  //             {
  //               'default': [
  //                 SingleChoiceQuestion(
  //                     '请努力识别这次暴食的诱发因素并填写它！',
  //                     ['不知道', '点击填写'],
  //                     {
  //                       '点击填写': [TextQuestion('questionText', false)]
  //                     },
  //                     description: '这一部分很重要！如果没有识别出来，请选择未知。\n\n'
  //                         '常见的暴食诱因：\n\n'
  //                         '1. 吃的太少，身体能量不足\n\n'
  //                         '2. 过度地节食\n\n'
  //                         '3. 情绪（比如抑郁、焦虑、无聊、兴奋等）\n\n'
  //                         '4. 松散的时间安排\n\n'
  //                         '5. 一个人呆着（一个人呆着常常“肆无忌惮”地吃很多）\n\n'
  //                         '6. 感觉自己很胖或者体重增加，破罐子破摔\n\n'
  //                         '7. 饮酒\n\n'
  //                         '8. 月经期间的激素影响\n\n'
  //                         '9.其他任何引起你暴食的东西')
  //               ]
  //             },
  //             min: 0,
  //             max: 10,
  //             divisions: 10, labelBuilder: (value) {
  //           if (value == 0) {
  //             return '没有暴食';
  //           } else if (value == 5)
  //             return '中度暴食';
  //           else if (value == 10) return '重度暴食';
  //           return value.toInt().toString();
  //         }),
  //         TextQuestion('更多注释（想法，感受等等）', false,
  //             description:
  //                 '记录任何可能会影响你这次饮食的东西，不管是你的纠结，想法还是情绪都可以。努力写一些！这一块的记录往往会在之后成为你改善暴食的奇招！'),
  //         MultipleChoiceQuestion('也许你有一些困惑：', [
  //           '我感觉记录我的饮食尤其是暴食是一件很羞耻的事情',
  //           '我极力想要忘记吃东西这件事，但记录自己吃了什么会让我更加专注于吃，这会不会让我更难受？',
  //           '我曾经记录过自己的饮食，但感觉没什么帮助',
  //           '我感觉很难坚持'
  //         ], {
  //           '我感觉记录我的饮食尤其是暴食是一件很羞耻的事情': [
  //             SingleChoiceQuestion(
  //                 '暴食很容易让我们愧疚，因此记下它确实是很不容易的事情。但你只需要坚持过去头几天！你会发现，之后有效分析带来的收获能够帮助你很好的应对羞耻的不快。别忘记，当你感觉到困难的时候，往往是你在面临最关键的改变部分！',
  //                 ['好的！'],
  //                 {})
  //           ],
  //           '我极力想要忘记吃东西这件事，但记录自己吃了什么会让我更加专注于吃，这会不会让我更难受？': [
  //             SingleChoiceQuestion(
  //                 '在饮食日志的前几天，你确实可能发现你对饮食的注意力增加了。但是克服暴食的第一步就是直面它！过了几天，你就会习惯于记录自己的饮食，就像平时吃饭喝水一样简单。',
  //                 ['好的！'],
  //                 {})
  //           ],
  //           '我曾经记录过自己的饮食，但感觉没什么帮助': [
  //             SingleChoiceQuestion(
  //                 '还是那句话，越感到困难的时候越说明你在面临改变越关键的部分。试着设置闹钟，或者找个朋友提醒自己～',
  //                 ['好的！'],
  //                 {})
  //           ],
  //           '我感觉很难坚持': [
  //             SingleChoiceQuestion(
  //                 '你的记录很有可能不像本方案教你的那么系统。同时，本方案还会基于你的饮食日志，教你如何分析自己的饮食模式。这是你一个人做不到的！',
  //                 ['好的！'],
  //                 {})
  //           ],
  //         }),
  //       ]
  //     },
  //   ),
  // ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SurveyPage(
        survey: dietaryIntake.survey!,
        taskId: dietaryIntake.id,
      ),
    );
  }
}
