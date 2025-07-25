import 'package:dio/dio.dart';
import 'package:namer_app/constants/tasks/daily_tasks.dart';
import 'package:namer_app/models/task_models.dart';
import 'package:namer_app/services/dio_client.dart';
import 'package:namer_app/models/survey_models.dart';
import 'package:namer_app/constants/index.dart';
import 'package:namer_app/utils/index.dart';
import 'api_endpoints.dart';

class SurveyService {
  static final DioClient dioClient = DioClient();

  // 辅助方法：统计数组中每个元素出现的次数
  static List<MapEntry<String, int>> _countListElements(List list) {
    Map<String, int> countMap = {};

    for (var item in list) {
      String key = item.toString();
      countMap[key] = (countMap[key] ?? 0) + 1;
    }

    return countMap.entries.toList();
  }

  static Future<List<Question>?> generateSurveyQuestions(String taskId) async {
    try {
      List<Question> questionList = [];

      // 检查 taskId 是否在 taskMap 中
      if (!taskMap.containsKey(taskId)) {
        print('Error: taskId $taskId not found in taskMap');
        return null;
      }

      Task task = taskMap[taskId]!;
      if (SurveyTask.NEED_GENERATED_TASK_IDS.contains(taskId)) {
        switch (taskId) {
          case 'S4':
            questionList = await generateDietPlanReview();
            return questionList;
          case 'S5':
            questionList = await generateImpulseReview();
            return questionList;
          case 'S2':
            questionList = await generateDietLogReflectionReview();
            return questionList;
          default:
            break;
        }
      } else {
        return task.survey!.questions;
      }
    } catch (err) {
      print('Error generating survey: $err');
      throw Exception(err);
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

  // S2 饮食日志反思
  static Future<List<Question>> generateDietLogReflectionReview() async {
    final DioClient dioClient = DioClient();
    try {
      Response reflectionIdRes =
          await dioClient.getRequest(ApiEndpoints.CURRENT_DIET_LOG_REFLECTIONS);
      if (reflectionIdRes.statusCode == 200) {
        print('res =======> ${reflectionIdRes.data}');
        int? id = reflectionIdRes.data?['id'];
        Response reflectionSummary = await dioClient
            .getRequest(ApiEndpoints().DIET_LOG_REFLECTION_SUMMARY(id));
        if (reflectionSummary.statusCode == 200) {
          print('reflectionSummary.data: ${reflectionSummary.data}');
          print(
              'reflectionSummary.data type: ${reflectionSummary.data.runtimeType}');

          // 更精准的类型检查
          if (reflectionSummary.data is! Map<String, dynamic>) {
            throw Exception(
                'Expected Map<String, dynamic> but got ${reflectionSummary.data.runtimeType}');
          }

          final data = reflectionSummary.data as Map<String, dynamic>;

          // 检查 binge 字段
          final bingeData = data['binge'];
          print('binge data: $bingeData, type: ${bingeData.runtimeType}');

          if (bingeData != null && bingeData is! Map<String, dynamic>) {
            throw Exception(
                'Expected binge to be Map<String, dynamic> but got ${bingeData.runtimeType}');
          }

          // 检查 dieting 字段
          final dietingData = data['dieting'];
          print('dieting data: $dietingData, type: ${dietingData.runtimeType}');

          if (dietingData != null && dietingData is! Map<String, dynamic>) {
            throw Exception(
                'Expected dieting to be Map<String, dynamic> but got ${dietingData.runtimeType}');
          }

          Map<String, dynamic> binge = bingeData ?? {};
          Map<String, dynamic> dieting = dietingData ?? {};

          // 更精准地检查每个字段
          print(
              'binge[dayOfWeek]: ${binge['dayOfWeek']}, type: ${binge['dayOfWeek'].runtimeType}');
          print(
              'binge[foodDetails]: ${binge['foodDetails']}, type: ${binge['foodDetails'].runtimeType}');
          print(
              'binge[specificTriggers]: ${binge['specificTriggers']}, type: ${binge['specificTriggers'].runtimeType}');

          // 安全地解构数据，处理空数组和 null 值
          final bingeDayOfWeek = (binge['dayOfWeek'] is Map &&
                  (binge['dayOfWeek'] as Map).isNotEmpty)
              ? mapToEntryList(binge['dayOfWeek'])
              : <MapEntry<String, dynamic>>[];

          final bingeTimeOfDay = (binge['timeOfDay'] is Map &&
                  (binge['timeOfDay'] as Map).isNotEmpty)
              ? mapToEntryList(binge['timeOfDay'])
              : <MapEntry<String, dynamic>>[];

          final bingeLocation = (binge['location'] is List &&
                  (binge['location'] as List).isNotEmpty)
              ? _countListElements(binge['location'] as List)
              : <MapEntry<String, int>>[];

          final bingeEmotionIntensity = (binge['emotionIntensity'] is Map &&
                  (binge['emotionIntensity'] as Map).isNotEmpty)
              ? mapToEntryList(binge['emotionIntensity'])
              : <MapEntry<String, dynamic>>[];

          final bingeEmotionType = (binge['emotionType'] is Map &&
                  (binge['emotionType'] as Map).isNotEmpty)
              ? mapToEntryList(binge['emotionType'])
              : <MapEntry<String, dynamic>>[];

// 对于 List 类型的字段，需要特别处理
          final bingeFoodDetails = (binge['foodDetails'] is List &&
                  (binge['foodDetails'] as List).isNotEmpty)
              ? _countListElements(binge['foodDetails'] as List)
              : <MapEntry<String, int>>[];

// 安全处理 triggerIdentificationSuccess - 这里是导致错误的原因
          final bingeTriggerIdentificationSuccess =
              (binge['triggerIdentificationSuccess'] is Map &&
                      (binge['triggerIdentificationSuccess'] as Map).isNotEmpty)
                  ? binge['triggerIdentificationSuccess']
                      as Map<String, dynamic>
                  : <String, dynamic>{};

          final bingeSpecificTriggers = (binge['specificTriggers'] is List &&
                  (binge['specificTriggers'] as List).isNotEmpty)
              ? _countListElements(binge['specificTriggers'] as List)
              : <MapEntry<String, int>>[];

// 解构 dieting 数据 - 同样进行安全处理
          final dietingDayOfWeek = (dieting['dayOfWeek'] is Map &&
                  (dieting['dayOfWeek'] as Map).isNotEmpty)
              ? mapToEntryList(dieting['dayOfWeek'])
              : <MapEntry<String, dynamic>>[];

          final dietingLocation = (dieting['location'] is List &&
                  (dieting['location'] as List).isNotEmpty)
              ? _countListElements(dieting['location'] as List)
              : <MapEntry<String, int>>[];

          final dietingEmotionIntensity = (dieting['emotionIntensity'] is Map &&
                  (dieting['emotionIntensity'] as Map).isNotEmpty)
              ? mapToEntryList(dieting['emotionIntensity'])
              : <MapEntry<String, dynamic>>[];

          final dietingEmotionType = (dieting['emotionType'] is Map &&
                  (dieting['emotionType'] as Map).isNotEmpty)
              ? mapToEntryList(dieting['emotionType'])
              : <MapEntry<String, dynamic>>[];

          final dietingFoodDetails = (dieting['foodDetails'] is List &&
                  (dieting['foodDetails'] as List).isNotEmpty)
              ? _countListElements(dieting['foodDetails'] as List)
              : <MapEntry<String, int>>[];

// 安全计算 bingeTimes
          int bingeTimes = bingeDayOfWeek.isNotEmpty
              ? bingeDayOfWeek.fold(
                  0, (sum, v) => sum + (v.value is int ? v.value as int : 0))
              : 0;

          return [
            SingleChoiceQuestion('检查完成情况', [
              '好的'
            ], {
              '好的': [
                SingleChoiceQuestion(
                  '刚刚，小E对您之前记录的饮食日志内容进行了初步整理。接下来，小E将会问你一些问题，帮助你以更高维度的视角分析、反思自己的饮食模式。',
                  ['下一步'],
                  {},
                ),
                SingleChoiceQuestion(
                  '对自己饮食模式的觉察和反思是非常非常重要的！经过研究表明，它能够帮助你增强对自己进食的掌控感，进而显著减少暴食和清除食物行为的发生频率。请千万不要忽视它！',
                  ['好的！'],
                  {},
                ),
                SingleChoiceQuestion(
                  '如果真的没有发现什么，完全可以放空不填～我们希望你分析对自己有意义的部分。并且，您的回答也是绝对保密的，只有自己才能看到。所以，放心真诚地回答就好啦～',
                  ['知道了！'],
                  {},
                ),
                // TODO 只有周初的饮食监控需要这一项，周中不用
                SingleChoiceQuestion(
                    '我完成的饮食日志有多少天？',
                    ['5-7天', '0-4天'],
                    {
                      '5-7天': [
                        SingleChoiceQuestion(
                            '你太棒啦！有这种坚持的能力，小E相信，不管是暴食还是生命中其他的挑战你都一定能战胜他们。我们希望你之后的每周都至少能完成五天的饮食日志，当然越多越有效啦！',
                            ['好的！'],
                            {})
                      ],
                      '0-4天': [
                        SingleChoiceQuestion(
                            '没关系的，万事开头难，很多人都很难在前几周就完成5天及以上的的饮食日志。您只需要想想干扰自己进行饮食日志记录的原因，并提出一些可能的改善策略就好啦。',
                            ['好的！'],
                            {}),
                        TextQuestion('请先思考一下没有完整记录的原因', false),
                        TextQuestion('然后在这里写下你的应对策略', false),
                      ]
                    },
                    description: '*完成指的是————您完整记录下了一天内所有的进食情况'),
                SingleChoiceQuestion('我是否准确地完成了我的饮食日志？记录方面还有改进的空间嘛？', [
                  '检查一下'
                ], {
                  '检查一下': [
                    SingleChoiceQuestion('您是否记录了所有吃&喝的食物', [
                      '是',
                      '否'
                    ], {
                      '否': [
                        TextQuestion('请先思考一下没有完整记录的原因', false),
                        TextQuestion('然后在这里写下你的应对策略', false),
                      ]
                    }),
                    // ... 其他问题

                    // 问题4
                    SingleChoiceQuestion('您是否在吃完之后尽快地把它们记录下来', [
                      '是',
                      '否'
                    ], {
                      '否': [
                        TextQuestion('请先思考一下没有尽快记录的原因', false),
                        TextQuestion('然后在这里写下你的应对策略', false),
                      ]
                    }),

                    // 问题5
                    SingleChoiceQuestion(
                      '您是否诚实地记录了自己的暴食情况',
                      ['是', '否'],
                      {
                        '否': [
                          TextQuestion('请先思考一下没有诚实记录的原因', false),
                          TextQuestion('然后在这里写下你的应对策略', false),
                        ]
                      }, // 暂无子问题
                    ),

                    // 问题6
                    SingleChoiceQuestion('在饮食日志最后的“更多注释”一栏，您是否有尝试记录一些自己的所思所想', [
                      '是',
                      '否'
                    ], {
                      '否': [
                        TextQuestion('请先思考一下没有完整记录的原因', false),
                        TextQuestion('然后在这里写下你的应对策略', false),
                      ]
                    }),
                  ]
                }),
              ]
            }),
            SingleChoiceQuestion('暴食分析', [
              '开始吧'
            ], {
              '开始吧': [
                SingleChoiceQuestion('你的本周总暴食次数为$bingeTimes，让我们开始对暴食部分的分析吧',
                    ['好的！'], {} // 可能需要添加子问题或描述
                    ),
                ChartQuestion(
                  "能识别诱因和不能识别诱因的暴食比例",
                  [
                    ChartData("能识别诱因",
                        bingeTriggerIdentificationSuccess['success'] ?? 0),
                    ChartData("不能识别诱因",
                        bingeTriggerIdentificationSuccess['fail'] ?? 0),
                  ],
                  QuestionType.None,
                  [],
                  ChartType.Bar,
                ),
                ChartQuestion(
                  "暴食诱因频率表",
                  [
                    ...bingeSpecificTriggers
                        .map((entry) => ChartData(entry.key, entry.value)),
                    // ChartData("工作压力", 30),
                    // ChartData("情绪波动", 25),
                    // ChartData("睡眠不足", 15),
                    // ChartData("社交活动", 20),
                    // ChartData("无特定原因", 10),
                  ],
                  QuestionType.None,
                  [],
                  ChartType.Bar,
                  orientation: ChartOrientation.horizontal,
                ),
                TextQuestion('我的暴食诱因通常是什么呢？', false),
                TextQuestion('怎样对我的暴食诱因进行更好的控制和管理呢？', false),
                ChartQuestion(
                  "每天暴食次数在一周内变化",
                  [
                    ...bingeDayOfWeek
                        .map((entry) => ChartData(entry.key, entry.value)),
                    // ChartData("星期一", 3),
                    // ChartData("星期二", 2),
                    // ChartData("星期三", 5),
                    // ChartData("星期四", 4),
                    // ChartData("星期五", 1),
                    // ChartData("星期六", 3),
                    // ChartData("星期日", 2),
                  ],
                  QuestionType.None,
                  [],
                  ChartType.Bar,
                ),
                ChartQuestion(
                    '暴食次数与一天中的时间段',
                    [
                      ...bingeTimeOfDay
                          .map((entry) => ChartData(entry.key, entry.value)),
                    ],
                    QuestionType.None,
                    [],
                    ChartType.Bar,
                    description: '分析一天中暴食发生的时间段。'),
                TextQuestion('我的暴食和时间有什么关联？', false),
                TextQuestion('我能依此做什么调整来减少暴食？', false),
                ChartQuestion(
                    '暴食次数与对应的地点',
                    [
                      ...bingeLocation
                          .map((entry) => ChartData(entry.key, entry.value)),
                    ],
                    QuestionType.None,
                    [],
                    ChartType.Bar,
                    orientation: ChartOrientation.horizontal,
                    description: '分析暴食发生的地点。'),
                TextQuestion('在哪吃会影响我的暴食吗？', false),
                TextQuestion('我能依此做什么调整来减少暴食？', false),
                ChartQuestion(
                  '暴食次数与情绪强度',
                  [
                    ...bingeEmotionIntensity
                        .map((entry) => ChartData(entry.key, entry.value)),
                  ],
                  QuestionType.None,
                  [],
                  ChartType.Bar,
                ),
                ChartQuestion(
                  '暴食次数与情绪类型',
                  [
                    ...bingeEmotionType
                        .map((entry) => ChartData(entry.key, entry.value)),
                  ],
                  QuestionType.None,
                  [],
                  ChartType.Bar,
                  // orientation: ChartOrientation.horizontal,
                ),
                TextQuestion('情绪如何影响我的暴食？', false),
                TextQuestion('我能依此做什么调整来减少暴食？', false),
                ChartQuestion(
                  '暴食次数与食物类型',
                  [
                    ...bingeFoodDetails
                        .map((entry) => ChartData(entry.key, entry.value)),
                  ],
                  QuestionType.None,
                  [],
                  // TODO 这个图表的类型还没实现
                  // ChartType.Bulleted
                  ChartType.Bar,
                  orientation: ChartOrientation.horizontal,
                ),
                TextQuestion('我暴食的时候都吃什么种类的食物？为什么吃这些食物？', false),
                TextQuestion('我能依此做什么调整来减少暴食？', false),
              ],
            }),
            SingleChoiceQuestion('节食分析', [
              '开始吧'
            ], {
              '开始吧': [
                ChartQuestion(
                  "每天节食次数在一周内变化",
                  [
                    ...dietingDayOfWeek
                        .map((entry) => ChartData(entry.key, entry.value)),
                    // ChartData("星期一", 1),
                    // ChartData("星期二", 2),
                    // ChartData("星期三", 1),
                    // ChartData("星期四", 4),
                    // ChartData("星期五", 1),
                    // ChartData("星期六", 1),
                    // ChartData("星期日", 2),
                  ],
                  QuestionType.None,
                  [],
                  ChartType.Bar,
                ),
                ChartQuestion(
                  "每天暴食次数在一周内变化",
                  [
                    ...bingeDayOfWeek
                        .map((entry) => ChartData(entry.key, entry.value)),
                    // ChartData("星期一", 3),
                    // ChartData("星期二", 2),
                    // ChartData("星期三", 5),
                    // ChartData("星期四", 4),
                    // ChartData("星期五", 1),
                    // ChartData("星期六", 3),
                    // ChartData("星期日", 2),
                  ],
                  QuestionType.None,
                  [],
                  ChartType.Bar,
                ),
                TextQuestion('我这几天的节食情况怎么样？它和我的暴食之间有什么关系？', false),
                ChartQuestion(
                  "每天节食次数在一周内变化",
                  [
                    ...dietingDayOfWeek
                        .map((entry) => ChartData(entry.key, entry.value)),
                    // ChartData("星期一", 1),
                    // ChartData("星期二", 2),
                    // ChartData("星期三", 1),
                    // ChartData("星期四", 4),
                    // ChartData("星期五", 1),
                    // ChartData("星期六", 1),
                    // ChartData("星期日", 2),
                  ],
                  QuestionType.None,
                  [],
                  ChartType.Bar,
                ),
                TextQuestion('我的节食和时间有什么关联？', false),
                TextQuestion('我能对我的节食行为做出什么调整，以减少暴食的发生？', false),
                ChartQuestion(
                  '节食行为与一周内吃饭的地点的关系',
                  [
                    ...dietingLocation
                        .map((entry) => ChartData(entry.key, entry.value)),
                    // ChartData("家", 4),
                    // ChartData("工作地点", 2),
                    // ChartData("餐馆", 9),
                    // ChartData("户外", 7),
                  ], // 假数据
                  QuestionType.None,
                  [],
                  ChartType.Bar,
                  orientation: ChartOrientation.horizontal,
                  description: '分析节食发生的地点和同伴。',
                ),
                TextQuestion('在哪吃会影响我的节食吗？', false),
                TextQuestion('我能对我的节食行为做出什么调整，以减少暴食的发生？', false),
                ChartQuestion(
                  '节食次数与情绪强度的关系',
                  [
                    ...dietingEmotionIntensity
                        .map((entry) => ChartData(entry.key, entry.value)),
                    // ChartData('非常不开心', 4),
                    // ChartData('很不开心', 1),
                    // ChartData('不开心', 3),
                    // ChartData('一般', 4),
                    // ChartData('开心', 1),
                    // ChartData('很开心', 4),
                    // ChartData('非常开心', 2),
                  ],
                  QuestionType.None,
                  [],
                  ChartType.Bar,
                ),
                ChartQuestion(
                  '节食次数和情绪种类的关系',
                  [
                    ...dietingEmotionType
                        .map((entry) => ChartData(entry.key, entry.value)),
                    // ChartData("快乐", 3),
                    // ChartData("悲伤", 4),
                    // ChartData("愤怒", 8),
                    // ChartData("压力", 1)
                  ],
                  QuestionType.None,
                  [],
                  ChartType.Bar,
                  description: '分析情绪强度和种类与节食的关系。',
                ),
                TextQuestion('情绪如何影响我的节食？', false),
                TextQuestion('我能对我的节食行为做出什么调整，以减少暴食的发生？', false),
                ChartQuestion(
                  '节食时选择的食物种类',
                  [
                    ...dietingFoodDetails
                        .map((entry) => ChartData(entry.key, entry.value)),
                  ],
                  QuestionType.None,
                  [],
                  ChartType.Bulleted,
                  orientation: ChartOrientation.horizontal,
                  description: '分析节食时选择的食物种类。',
                ),
                TextQuestion('我节食的时候都吃什么种类的食物？为什么吃这些食物？', false),
                TextQuestion('我能对我的节食行为做出什么调整，以减少暴食的发生？', false),
              ]
            }),
            SingleChoiceQuestion('清除食物行为分析TODO', [
              '开始吧'
            ], {
              '开始吧': [
                ChartQuestion(
                  "每天食物清除次数在一周内变化",
                  [
                    ChartData("星期一", 1),
                    ChartData("星期二", 0),
                    ChartData("星期三", 1),
                    ChartData("星期四", 0),
                    ChartData("星期五", 1),
                    ChartData("星期六", 2),
                    ChartData("星期日", 1),
                  ],
                  QuestionType.None,
                  [],
                  ChartType.Bar,
                ),
                ChartQuestion(
                  '食物清除行为与一周内一天中的时间段的关系',
                  [
                    ChartData('0', 0),
                    ChartData('3', 1),
                    ChartData('6', 0),
                    ChartData('9', 8),
                    ChartData('12', 3),
                    ChartData('15', 0),
                    ChartData('18', 5),
                    ChartData('21', 7),
                  ], // 假数据
                  QuestionType.None,
                  [],
                  ChartType.Bar,
                  description: '分析一天中食物清除发生的时间段。',
                ),
                TextQuestion('我的食物清除和时间有什么关联？', false),
                ChartQuestion(
                  '食物清除次数与情绪强度的关系',
                  [
                    ChartData('非常不开心', 1),
                    ChartData('很不开心', 2),
                    ChartData('不开心', 3),
                    ChartData('一般', 4),
                    ChartData('开心', 3),
                    ChartData('很开心', 4),
                    ChartData('非常开心', 1),
                  ],
                  QuestionType.None,
                  [],
                  ChartType.Bar,
                ),
                ChartQuestion(
                  '食物清除次数和情绪种类的关系',
                  [
                    ChartData("快乐", 3),
                    ChartData("悲伤", 4),
                    ChartData("愤怒", 8),
                    ChartData("压力", 1)
                  ], // 假数据
                  QuestionType.None,
                  [],
                  ChartType.Bar,
                  description: '分析情绪强度和种类与食物清除的关系。',
                ),
                TextQuestion('情绪如何影响我的食物清除行为？', false),
                ChartQuestion(
                  "食物清除诱因频率表",
                  [
                    ChartData("情绪波动", 25),
                    ChartData("睡眠不足", 15),
                    ChartData("社交活动", 20),
                    ChartData("无特定原因", 10),
                  ],
                  QuestionType.None,
                  [],
                  ChartType.Bar,
                  orientation: ChartOrientation.horizontal,
                ),
                TextQuestion('吃/喝的食物如何影响我的清除食物行为？', false),
                TextQuestion('我能如何改善我的清除食物行为?', false),
              ]
            }),
            SingleChoiceQuestion(
              '今天你成功完成了一次对自己的饮食日志的反思分析！您可以带着这些宝贵的想法进行之后的饮食日志记录，尤其是关于暴食诱因的模块，相信你一定对它有了更多觉察～',
              ['OK!'],
              {
                'OK!': [
                  SingleChoiceQuestion(
                    '这样的饮食日志反思在前两周会以每周两次的频率进行，之后则是一周一次。您在这里写下的每一句话在之后可能都具有无与伦比的治疗效果~',
                    ['好的！'],
                    {},
                  ),
                ]
              },
            )
          ];
        }
      }
    } catch (e) {
      print('error in fetching data $e');
      return [
        SingleChoiceQuestion("问卷数据获取有误，请尝试重新进入", ["好的！"], {}, required: false),
      ];
    }
    return [];
  }
}
