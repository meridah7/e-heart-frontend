import 'package:dio/dio.dart';
import 'package:namer_app/constants/tasks/daily_tasks.dart';
import 'package:namer_app/models/task_models.dart';
import 'package:namer_app/services/dio_client.dart';
import 'package:namer_app/models/survey_models.dart';
import 'package:namer_app/constants/index.dart';
import 'api_endpoints.dart';

class SurveyService {
  static final DioClient dioClient = DioClient();

  // static Future<Survey> generateSurvey(String taskId) async {
  //   try {
  //     Response response = await dioClient.getRequest(
  //       '${ApiEndpoints.SURVEY_GENERATOR}/$taskId/',
  //     );
  //     if (response.statusCode == 200) {
  //       return Survey.fromJson(response.data);
  //     } else {
  //       throw Exception('Failed to generate survey');
  //     }
  //   } catch (err) {
  //     print('Error generating survey: $err');
  //     throw Exception(err);
  //   }
  // }
  static Future<List<Question>?> generateSurveyQuestions(String taskId) async {
    try {
      Task task = taskMap[taskId]!;
      List<Question> questionList = [];
      if (SurveyTask.NEED_GENERATED_TASK_IDS.contains(taskId)) {
        switch (taskId) {
          case 'S4':
            questionList = await generateDietPlanReview();
            return questionList;
          case 'S5':
            questionList = await generateImpulseReview();
            return questionList;
          default:
            break;
        }
      } else {
        return task.survey!.questions;
      }
    } catch (err) {
      print('Error generating survey: $err');
      return null;
    }
    return null;
  }

  // S5 冲动记录反思
  static Future<List<Question>> generateImpulseReview() async {
    final DioClient dioClient = DioClient();
    try {
      Response res = await dioClient.getRequest(ApiEndpoints.IMPULSE_RECORDS);
      int count = res.data.length;
      return [
        SingleChoiceQuestion(
          '小E对你记录的所有暴食、清除食物冲动进行了总结，帮助你以专业的视角进行反思，看看还有哪些可以改善的地方。\n\n'
          '没有想法的空可以不填，你只要分析对自己有启发的部分。您的回答绝对保密，放心填写就好啦。',
          ['好的！'],
          {},
        ),
        SingleChoiceQuestion(
            '小E统计发现，您至今为止记录了$count次暴食、清除冲动，并制定了相应的应对策略，您真的很棒！要继续坚持记录和应对哦。',
            ['了解了！'],
            {},
            description: ''),
        SingleChoiceQuestion(
            '您是否在每次识别到自己暴食、清除食物冲动的时候，都努力立即记录下来？',
            ['是的', '比较难做到'],
            {
              '是的': [SingleChoiceQuestion('真棒，希望你继续坚持哦～', [], {})],
              '比较难做到': [
                TextQuestion(
                    '即使不制定应对策略而就简单记录一下冲动，都会让你感觉好不少！因此，如果你觉得太难，也可以先不填写策略的部分。\n\n'
                    '你觉得是什么阻碍了你对冲动的记录呢？',
                    false,
                    alias: 'reasons_not_record_impulses'),
                TextQuestion('你觉得有什么好方法克服它们？', false,
                    alias: 'strategies_not_record_impulses'),
              ],
            },
            alias: 'record_impulses_immediately'),
        SingleChoiceQuestion(
          '您是否在每次识别到自己暴食、清除食物冲动的时候，都使用了先前制定好的替代方法？可以回到自己的每一次记录去看一看～',
          ['有', '没有'],
          {
            '有': [
              SingleChoiceQuestion(
                  '真棒，感受到暴食、清除冲动时用一些更友好的策略来应对冲动，可是有大作用呢。慢慢来，相信自己～', [], {})
            ],
            '没有': [
              SingleChoiceQuestion(
                  '刚开始冲动太过强烈，可能想的应对策略没什么效果。\n'
                  '这很正常，每次只需要尽力坚持得比以前久一些就好～在这里，制定下一个想要坚持的时间吧。',
                  [],
                  {}),
              TextQuestion('当我记录下我的冲动并制定相应策略后，我想在这个冲动下坚持  ____ 分钟。', false,
                  alias: 'impulse_persistence_minutes'),
              TextQuestion('为了完成这个目标，你觉得有哪些可能的困难和阻碍？', false,
                  alias: 'impulse_persistence_barriers'),
              TextQuestion('你觉得有什么好方法来克服这些困难呢？', false,
                  alias: 'impulse_persistence_methods'),
            ],
          },
          alias: 'use_alternatives',
        ),
        TextQuestion(
            '我使用应对策略应对冲动的效果怎样？具体的应对冲动过程是否有可以改进的空间？\n\n'
            'a.效果',
            false,
            alias: 'impulse_persistence_effects'),
        TextQuestion('b.改进空间', false,
            alias: 'impulse_persistence_improvement_areas'),
        // More questions or reflection points can be added here

        //未完成
        SingleChoiceQuestion(
          '如果你需要对冲动应对卡进行修改，请点击这里。',
          ['点击展示冲动应对策略'],
          {
            '点击展示冲动应对策略': [ResponseCardQuestion()]
          },
        )
      ];
    } catch (e) {
      return [
        SingleChoiceQuestion("问卷数据获取有误，请尝试重新进入", ["好的！"], {}, required: false),
      ];
    }
  }

  // S4 饮食计划反思
  static Future<List<Question>> generateDietPlanReview() async {
    final DioClient dioClient = DioClient();
    try {
      // 饮食计划数据
      Response mealPlanRes =
          await dioClient.getRequest(ApiEndpoints.MEAL_PLAN_REFLECTIONS);
      // // 饮食计划缺失的计划天数
      // Response missingPlanDaysRes = await dioClient.getRequest(
      //     '/meal_plans/missing-planning-days/$mondayTimestamp/$sundayTimestamp');
      // // 饮食计划不合理间隔次数
      // Response unreasonableIntervalCountRes = await dioClient.getRequest(
      //     '/meal_plans/unreasonable-interval-counts/$mondayTimestamp/$sundayTimestamp');
      // // 饮食计划不合理计划餐食次数
      // Response unreasonableMealPlanCountsRes = await dioClient.getRequest(
      //     '/meal_plans/unreasonable-interval-counts/$mondayTimestamp/$sundayTimestamp');
      if (mealPlanRes.statusCode == 200) {
        int unreasonableCount = mealPlanRes.data['unreasonableCount'] ?? 0;
        int reasonableCount = mealPlanRes.data['reasonableCount'] ?? 0;
        int missingDays = mealPlanRes.data['missingDaysCount'] ?? 0;
        int plannedDays = mealPlanRes.data['plannedDaysCount'] ?? 0;
        int startTimestamp = mealPlanRes.data['startTimestamp'] ?? 0;
        int endTimestamp = mealPlanRes.data['endTimestamp'] ?? 0;

        // 计算时间间隔日
        DateTime startDate =
            DateTime.fromMillisecondsSinceEpoch(startTimestamp);
        DateTime endDate = DateTime.fromMillisecondsSinceEpoch(endTimestamp);

        startDate = DateTime(startDate.year, startDate.month, startDate.day);
        endDate = DateTime(endDate.year, endDate.month, endDate.day);

        int days = endDate.difference(startDate).inDays;

        List<Question> missingDayQuestion() {
          if (missingDays > 1) {
            return [
              TextQuestion(
                  '小E知道坚持完成这个任务是个不容易的事情，因此没有每天进行饮食计划也完全没关系～\n\n您只需要想想干扰自己进行饮食日志记录的原因，并提出一些可能的改善策略就好啦。\n\n'
                  '有什么困难阻碍着我',
                  false,
                  alias: 'reason_not_planned'),
              TextQuestion('想想办法，怎样才能做的更好呢', false,
                  alias: 'countermeasure_not_planned')
            ];
          } else {
            return [
              SingleChoiceQuestion('能坚持这么久，真的好厉害！努力保持哟～', ['好的'], {},
                  required: false)
            ];
          }
        }

        return [
          SingleChoiceQuestion(
              "刚刚，小E对您的饮食计划进行了整理，并将帮助你以专业的视角反思自己的饮食计划。\n\n"
              "饮食计划和对应的反思是方案中被证明最有效的内容，因此要认真填写～\n\n"
              "没有想法的空可以不填，你只要分析对自己有启发的部分。您的回答绝对保密，放心填写就好啦。",
              ["好的！"],
              {},
              required: false),
          ChartQuestion(
              "我有提前做好每天的饮食计划吗？",
              [
                ChartData("做了计划的天数", plannedDays), // 假设这里的数字0会根据用户实际情况动态改变
                ChartData("没做计划的天数", missingDays),
              ],
              QuestionType.None,
              [],
              ChartType.Bar,
              description: "展示您在过去一周内提前做好饮食计划的天数以及未提前做好计划的天数。"),
          SingleChoiceQuestion(
              "我每天有提前做好饮食计划吗？",
              [
                '是',
                '否',
              ],
              {},
              description: '小E看到您已经做了$plannedDays天的计划',
              required: false),
          // TODO 接口数据
          ChartQuestion(
            "饮食计划完成与未完成次数表",
            [
              ChartData('按计划完成的次数', 4),
              ChartData('未按计划完成的次数', 1),
            ],
            QuestionType.None,
            [],
            ChartType.Bar,
            description: "",
          ),
          // TODO 接口alias
          SingleChoiceQuestion('我有按照计划完成每一餐吗？', [
            '有',
            '没有'
          ], {
            '没有': [
              TextQuestion('你觉得是什么导致了有时没按照计划饮食？', false),
              TextQuestion('你对此有什么应对策略？', false)
            ],
          }),
          ...missingDayQuestion(),
          ChartQuestion(
              "我的饮食计划中的每餐间隔时间",
              [
                ChartData(
                    "在3-4小时内的计划次数", unreasonableCount), // 假设这里的数字0会根据用户实际情况动态改变
                ChartData("在3-4小时以外的计划次数", reasonableCount),
              ],
              QuestionType.None,
              [],
              ChartType.Bar,
              description: ""),
          SingleChoiceQuestion(
              "我是否按照要求，将饮食计划的每餐间隔时间控制在3- 4 小时之间？",
              ["是", "否"],
              {
                "是": [
                  SingleChoiceQuestion(
                      "很棒！看来你已经完全理解我们饮食计划的核心原则啦！相信我们，这一定对缓解暴食有所帮助～", [], {})
                ],
                "否": [
                  SingleChoiceQuestion("为什么在计划的时候要把每一次进食的间隔控制在3-4小时呢？", [
                    '点击查看原因'
                  ], {
                    '点击查看原因': [
                      SingleChoiceQuestion(
                          '四小时就能让你之前吃的东西消化的差不多，因此超过四小时还不吃东西就会让你的身体感到饥饿。\n\n'
                          '此外，太久不吃东西会让你一直挂念着食物；这种生理饥饿和心理压力会同时发挥作用，就会有极大的可能引发暴食！\n\n'
                          '饮食计划的核心原则是让您一天计划的每一次进食都间隔在3-4小时之间，其实就能够让你同时避免身体和心理的这两方面的影响，从而达到减少暴食的目的。',
                          ['好的！'],
                          {})
                    ]
                  })
                ],
              },
              alias: 'is_time_controlled',
              description: "小E看到您本周有$unreasonableCount天仅仅计划了3餐或3餐以下"),
          // description: "您计划进食的时间共有x次不在3- 4 小时之间"),
          SingleChoiceQuestion(
              "我有努力按照自己的计划内容进食吗（在第二天进食时，和前一天的计划内容有一些差别很正常，不用和计划内容完全一致，只要尽量按照计划执行就好～）",
              ["我努力了～", "还没有那么努力～"],
              {
                "我努力了～": [SingleChoiceQuestion("你真的非常棒！努力继续坚持吧～", [], {})],
                "还没有那么努力～": [
                  TextQuestion(
                      '按照计划进食真的是一件不容易的事情，需要我们一起慢慢努力。那么，你可以想想干扰自己按照饮食计划进食的原因，并提出一些可能的改善策略就好啦。\n\n'
                      '干扰原因',
                      false,
                      alias: 'reason_not_efforted'),
                  TextQuestion('对策', false,
                      alias: 'countermeasure_not_efforted')
                ]
              },
              alias: 'is_effortted',
              description: ""),
          SingleChoiceQuestion(
              "如果我没有遵循饮食计划，我会努力重新专注于下一次计划吗？",
              [
                "即使我出于某些原因没有遵循某一餐的计划，我也能努力去完成接下来的饮食计划",
                "如果某一次进食我没按照计划完成，我可能就会彻底放弃今天的所有计划"
              ],
              {
                "即使我出于某些原因没有遵循某一餐的计划，我也能努力去完成接下来的饮食计划": [
                  SingleChoiceQuestion("非常好，你的想法很棒！", ['好的！'], {})
                ],
                "如果某一次进食我没按照计划完成，我可能就会彻底放弃今天的所有计划": [
                  SingleChoiceQuestion(
                      "如果你的一次进食没按计划做好，你可能非常沮丧，认为一整天的饮食都毁了。但其实不是的！你不需要将饮食计划做到完美，追求完美只会成为暴食最好的帮凶。\n\n"
                      "因此，不管之前发生了什么，只需要重新专注于完成下一次的进食计划就好啦！",
                      ['好的！'],
                      {})
                ]
              },
              alias: 'is_focused_next',
              description: ""),
          SingleChoiceQuestion(
              "我每天的饮食计划是否可以完全不一样？",
              ["可以", "不可以"],
              {
                "可以": [
                  SingleChoiceQuestion("非常好，你的想法很棒！", ['好的！'], {})
                ],
                "不可以": [
                  SingleChoiceQuestion(
                      "请记住，每一天的计划都可以是不一样的！我们不需要您保持非常规律的饮食模式，您完全可以根据下一天的安排来个性化地计划自己的饮食！当然，要遵循我们每餐间隔3-4小时的核心原则哦。",
                      ['好的！'],
                      {})
                ]
              },
              alias: 'is_different_plan',
              description: ""),
          SingleChoiceQuestion(
              "我做的饮食计划还有什么可以调整改善的地方吗？",
              ["暂时没有，我已经很棒啦", "有一些可以调整的地方"],
              {
                "暂时没有，我已经很棒啦": [
                  SingleChoiceQuestion("真棒！继续努力哦～", ['好的！'], {})
                ],
                "有一些可以调整的地方": [
                  TextQuestion("请写下您认为可以调整的地方，您可以在明天的计划中努力做到~", false,
                      alias: 'improvement_content')
                ]
              },
              alias: 'is_improved',
              description: ""),
          SingleChoiceQuestion(
              '真棒，你已经完成今天全部的反思内容啦，您可以再整体回顾一下您的成果，是不是有不一样的收获呢', [], {},
              required: false),
          SingleChoiceQuestion(
              '今天你成功完成了一次对自己的饮食计划的反思分析！饮食计划反思要常常做，您可以以反思报告为依据，将之后的饮食计划做得更好！',
              [],
              {},
              required: false)
        ];
      }
    } catch (e) {
      throw Exception('Error in fetch Diet Reflection data');
    }

    return [
      SingleChoiceQuestion("问卷数据获取有误，请尝试重新进入", ["好的！"], {}, required: false),
    ];
  }
}
