import 'package:namer_app/user_preference.dart';
import '../../Survey/survey_models.dart';

// var impulseRetrospectSurvey = Survey(title: 'x 月 x 日冲动记录回顾', questions: [
//   TextQuestion('你感觉这次的应对策略怎么样？整个应对过程有什么可以改进的地方呢？', false,
//       description: '你的冲动记录时间是：年，月，日，时，分\n'
//           '你记录的冲动种类是：暴食冲动  / 清除食物冲动\n'
//           '你记录的冲动强度是：0-10\n'
//           '你记录的冲动诱因是：YYYY\n'
//           '针对这次冲动，你制定的应对策略是:XXXXXX\n'
//           '针对这次冲动，你希望自己坚持冲动冲浪的时间：Z分钟\n'),
//   TextQuestion('你这次冲动大约持续了多少分钟？', false),
// ]);

var sampleSurvey = Survey(title: '1111 Survey', questions: [
  TimeQuestion(
    'At what time would you like to start the activity?',
    initialTime: DateTime.now(), // 设置默认时间为当前时间
  ),
  MultipleChoiceQuestion(
    'Which additional features are important to you?',
    ['Feature A', 'Feature B', 'Feature C'],
    {},
    additionalOptions: {'Feature D': false, 'Feature E': false},
    description: 'Please select all that apply.',
  ),
  MultipleChoiceQuestion(
    'Which features are important to you?',
    ['Feature A', 'Feature B', 'Feature C'],
    {},
    description: 'Please select all that apply.',
  ),
  TextQuestion('What is your hobby?', true),
  SliderQuestion(
    '您今天的心情如何？',
    {},
    min: 0.0,
    max: 10.0,
    divisions: 10,
    labelBuilder: _moodSliderLabel,
  ),
  MultipleChoiceQuestion(
      'Which fruits do you like?', ['Apple', 'Banana', 'Cherry', 'Date'], {})
]);

String _moodSliderLabel(double value) {
  switch (value.round()) {
    case 1:
      return '很不开心';
    case 2:
      return '不太开心';
    case 3:
      return '不太开心';
    case 4:
      return '一般';
    case 5:
      return '较开心';
    case 6:
      return '较开心';
    case 7:
      return '很开心';
    default:
      return '心情${value.round()}';
  }
}

// 饮食记录
var dietaryIntakeSurvey = Survey(title: '饮食记录', questions: [
  SingleChoiceQuestion(
    '首先呈现三个注意事项：\n'
    '1.请努力在吃完后尽快填写它！\n'
    '2.你不需要改变自己的进食，只需要努力真实地记录自己的饮食情况就好。\n'
    '3.请记录下一天内的所有饮食，而不只是正餐。',
    ['好的！'],
    {},
  ),
  TimeQuestion('进食具体时间', initialTime: DateTime.now()),
  TextQuestion('吃了什么&吃了多少', true,
      description:
          '填写你这次进食吃下、喝下的所有东西以及大概的量。千万不要具体记录摄入食物的重量和卡路里！正确示例：八包薯片，一个八寸披萨，一小碗酸奶。'),
  SingleChoiceQuestion('属于哪一餐', [
    '早餐',
    '上午点心',
    '午餐',
    '下午点心',
    '晚餐',
    '夜宵',
    '其他'
  ], {
    '其他': [
      SingleChoiceQuestion('其他类型', ['零食', '饮料'], {})
    ],
  }),
  SliderQuestion('进食的时候感受到的情绪强度', {}, min: 1, max: 7, divisions: 6,
      labelBuilder: (value) {
    if (value == 1) {
      return '很不开心';
    } else if (value == 4)
      return '一般';
    else if (value == 7) return '超开心';
    return value.toInt().toString();
  }),
  MultipleChoiceQuestion('情绪种类', [
    '伤心',
    '疲惫',
    '紧张',
    '无聊',
    '兴奋',
    '羞愧',
    '愤怒',
    '恐惧',
    '平静',
    '开心',
    '其他'
  ], {
    '其他': [
      TextQuestion('请输入其他情绪种类', false),
    ]
  }),
  SingleChoiceQuestion(
      '在哪吃',
      ['家里', '宿舍', '公司', '食堂', '饭店', '车上', '其他'],
      {
        '其他': [
          TextQuestion('请输入其他地点', false),
        ],
        '家里': [
          SingleChoiceQuestion('是在家里的', [
            '客厅',
            '卧室',
            '餐桌',
            '厨房',
            '洗手间',
            '其他'
          ], {
            '其他': [
              TextQuestion('请输入其他地点', false),
            ],
          })
        ]
      },
      description: '选择你这次进食的所在之处。若没有对应选项，请于下方手动填写。'),
  SingleChoiceQuestion('有没有节食', ['有', '没有'], {}),
  SliderQuestion(
      '是否暴食',
      {
        'default': [
          SingleChoiceQuestion(
              '请努力识别这次暴食的诱发因素并填写它！',
              ['不知道', '点击填写'],
              {
                '点击填写': [TextQuestion('请填写诱因', false)]
              },
              description: '这一部分很重要！如果没有识别出来，请选择未知。\n\n'
                  '常见的暴食诱因：\n\n'
                  '1. 吃的太少，身体能量不足\n\n'
                  '2. 过度地节食\n\n'
                  '3. 情绪（比如抑郁、焦虑、无聊、兴奋等）\n\n'
                  '4. 松散的时间安排\n\n'
                  '5. 一个人呆着（一个人呆着常常“肆无忌惮”地吃很多）\n\n'
                  '6. 感觉自己很胖或者体重增加，破罐子破摔\n\n'
                  '7. 饮酒\n\n'
                  '8. 月经期间的激素影响\n\n'
                  '9.其他任何引起你暴食的东西')
        ]
      },
      min: 0,
      max: 10,
      divisions: 10, labelBuilder: (value) {
    if (value == 0) {
      return '没有暴食';
    } else if (value == 5)
      return '中度暴食';
    else if (value == 10) return '重度暴食';
    return value.toInt().toString();
  }),
  TextQuestion('更多注释（想法，感受等等）', false,
      description:
          '记录任何可能会影响你这次饮食的东西，不管是你的纠结，想法还是情绪都可以。努力写一些！这一块的记录往往会在之后成为你改善暴食的奇招！'),
]);

// 食物清除记录
var vomitRecordSurvey = Survey(title: '食物清除记录', questions: [
  TimeQuestion('食物清除的时间', initialTime: DateTime.now()),
  SliderQuestion('食物清除的时候感受到的情绪强度', {}, min: 1, max: 7, divisions: 6,
      labelBuilder: (value) {
    if (value == 1) {
      return '很不开心';
    } else if (value == 4)
      return '一般';
    else if (value == 7) return '超开心';
    return value.toInt().toString();
  }),
  MultipleChoiceQuestion('食物清除的时候感受到的情绪种类', [
    '伤心',
    '疲惫',
    '紧张',
    '无聊',
    '兴奋',
    '羞愧',
    '愤怒',
    '恐惧',
    '平静',
    '开心',
    '其他'
  ], {
    '其他': [
      TextQuestion('请输入其他情绪种类', false),
    ]
  }),
  TextQuestion('请努力识别这次食物清除的诱发因素并填写它！', false),
  TextQuestion('更多注释（想法，感受等等）', false,
      description:
          '记录任何可能会影响你这次饮食的东西，不管是你的纠结，想法还是情绪都可以。努力写一些！这一块的记录往往会在之后成为你改善暴食的奇招！'),
]);

// 每日饮食计划
var mealPlanningSurvey = Survey(title: '每日饮食计划', questions: [
  SingleChoiceQuestion(
    '饮食计划入口将在前一天中午12点后开放，并持续到当天中午12点。超过12点的计划我们会自动算作下一天的哦。',
    [],
    {},
    description: '举个例子：你在8.27号中午12点后，就可以进行8.28的饮食计划。\n'
        '当然，你也可以选择在8.28的早上进行当天的饮食计划，只要在中午12点前完成就好啦。',
  ),
  MealQuestion(
    '制定饮食计划的核心原则：每餐的间隔应该在3-4小时之间！',
    description: '开始制定你的计划吧',
    {},
  ),
  SingleChoiceQuestion('参考营养学原则及具体食谱推荐', [
    '点击详细展开'
  ], {
    '点击详细展开': [
      SingleChoiceQuestion(
          '1.参考原则：\n'
          '   正餐：最好同时具备碳水化合物、蔬菜水果和优质蛋白质\n'
          '   其它餐：可以选择坚果、水果、蔬菜、奶制品、甜点（少量）\n\n'
          '2.具体食谱：\n'
          '   正餐：\n'
          '       碳水化合物：米饭/五谷杂粮/面食/包子/全麦面包/玉米/土豆/薯类\n'
          '       蛋白质：蛋类/奶制品/豆浆/肉类（羊牛猪、鸡鸭鹅、鱼虾贝）\n'
          '       维生素+膳食纤维：果蔬汁/水果/蔬菜\n'
          '   其他餐：牛奶、酸奶、咖啡，水果，坚果，小点心，蔬菜沙拉',
          ['好的！'],
          {})
    ]
  }),
  MultipleChoiceQuestion(
    '你可能有些困惑',
    [
      '为什么在计划的时候要把每一次进食的间隔控制在3-4小时？',
      '每顿都吃饱，我担心会变胖怎么办',
      '我想减肥，因此我每顿计划的饮食都不想吃饱，怎么办？',
      '我感觉饱的感觉不太舒服',
      '我可以在早上的时候计划当天一整天的进食吗？',
      '噢，我觉得没什么困惑',
    ],
    {
      '每顿都吃饱，我担心会变胖怎么办': [
        SingleChoiceQuestion(
            '虽然你吃的顿数多了，但因为一个人每天所需总能量大致相同，所以你一天的总进食量不会有太大变化。此外，你还能减少暴食摄入的额外能量。因此，从长期来看你或许会变瘦！',
            ['好的！'],
            {})
      ],
      '为什么在计划的时候要把每一次进食的间隔控制在3-4小时？': [
        SingleChoiceQuestion(
            '四小时就能让你之前吃的东西消化的差不多，因此超过四小时还不吃东西会太饿，从而可能引发暴食。此外，太久不吃东西会让你一直挂念着食物，从而也可能引发暴食。',
            ['好的！'],
            {})
      ],
      '我感觉饱的感觉不太舒服': [
        SingleChoiceQuestion(
            '如果你不习惯于吃饱，刚开始几天吃饱的感觉确实不太舒服，建议您尽量穿着宽松的衣物进食。过几天后这种感觉就会慢慢消失的！',
            ['好的！'],
            {})
      ],
      '我想减肥，因此我每顿计划的饮食都不想吃饱，怎么办？': [
        SingleChoiceQuestion(
            '如果你每天吃的很少，没有摄入身体所必要的能量，长期来看是无法达到减肥效果的。我们把这种方式叫做“溜溜球式减肥”。因为大部分人发现，体重减掉了一段时间后，过段时间又反弹回来了。因此，满足身体所需能量是必不可少的！我们可以通过其它营养学的方式来减肥。',
            ['好的！'],
            {})
      ],
      '我可以在早上的时候计划当天一整天的进食吗？': [
        SingleChoiceQuestion(
            '当然可以！你既可以在前一天晚上进行计划饮食，也可以在第二天的一早进行计划。', ['好的！'], {})
      ],
      '噢，我觉得没什么困惑': [
        // Optionally, add a SingleChoiceQuestion for this option
      ],
    },
  )

  // Other questions for the survey
]);

// 冲动记录反思
var bingeEatingReflectionSurvey = Survey(
    title: '冲动记录反思',
    isNeedTopArea: true,
    questions: [
      SingleChoiceQuestion(
        '小E对你记录的所有暴食、清除食物冲动进行了总结，帮助你以专业的视角进行反思，看看还有哪些可以改善的地方。\n\n'
        '没有想法的空可以不填，你只要分析对自己有启发的部分。您的回答绝对保密，放心填写就好啦。',
        ['好的！'],
        {},
      ),
      SingleChoiceQuestion(
          '小E统计发现，您至今为止记录了**次暴食、清除冲动，并制定了相应的应对策略，您真的很棒！要继续坚持记录和应对哦。',
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

      //TODO 此处需要呈现呈现总反思表
      //未完成
      SingleChoiceQuestion(
        '如果你需要对冲动应对卡进行修改，请点击这里。',
        ['点击展示冲动应对策略'],
        {
          '点击展示冲动应对策略': [ResponseCardQuestion()]
        },
      )
    ],
    navigateToSummary: true);

// TODO 冲动应对策略制定 还需要check
// TODO 这个问卷需要存储第一步的状态
var reflectiveActivitySurvey = Survey(
  title: '冲动应对策略制定',
  questions: [
    SingleChoiceQuestion('第一步，制定冲动应对策略', [
      '好的！'
    ], {
      '好的！': [
        TextQuestion('首先，请先仔细想想在你生活中满足以下三个特征的活动，并记下来\n', true,
            description: '1. 你需要积极地投入（比如运动）而不是消极地接受。\n'
                '2. 这些活动能够给你带来积极情绪，让你开心或是有成就感！\n'
                '3. 你真的有可能去做，而非仅仅是“想象中会去做”。',
            alias: 'q1'),
        MultipleChoiceQuestion(
            '其次，这里有一些满足第一个特征（积极投入而非被动接受）的活动清单。\n'
            '勾选一下哪些是能给你带来积极情绪、成就感并且你比较方便去做的活动。',
            [
              '去散步',
              '骑自行车',
              '和朋友/家人打电话聊天',
              '去找朋友/家人玩',
              '玩游戏',
              '洗澡',
              '看一部引人入胜的电影',
              '做家务（比如打扫房子）',
              '阅读一本书',
              '用心涂抹你最喜欢的香水、精油或润肤霜',
              '泡脚',
              '做个足疗/美甲'
            ],
            {},
            description: '',
            alias: 'q2'),
        TextQuestion('研究发现聆听你喜欢的音乐对应对暴食或是清除食物冲动来说也有不错的效果！', true,
            description: '在这里写下至少三首你喜欢的音乐。', alias: 'q3'),
      ]
    }),
    SingleChoiceQuestion('第二步，计划具体执行方法', [
      '好的！'
    ], {
      '好的！': [
        MultipleChoiceQuestion(
            '比如：去看一本书。具体策略：“我可以在电子书中找到武侠小说来看，比如金庸的《射雕英雄传》”',
            [
              '听音乐',
              '骑自行车',
              '和朋友/家人打电话聊天',
              '去找朋友/家人玩',
              '玩游戏',
              '洗澡',
              '看电影',
            ],
            {
              '听音乐': [TextQuestion('', false)],
              '骑自行车': [TextQuestion('', false)],
              '和朋友/家人打电话聊天': [TextQuestion('', false)],
              '去找朋友/家人玩': [TextQuestion('', false)],
              '玩游戏': [TextQuestion('', false)],
              '洗澡': [TextQuestion('', false)],
              '看电影': [TextQuestion('', false)],
            },
            description: '',
            alias: 'q4')
      ]
    }),
    SingleChoiceQuestion('第三步，策略排序', [
      '好的！'
    ], {
      '好的！': [
        PriorityQuestion(
            '请将你认为应对暴食/清除食物冲动最有效的活动排在前面.',
            [
              '逛街',
              '骑自行车/做一项运动',
              '和朋友/家人打电话聊天',
              '去找朋友/家人玩',
              '玩游戏',
              '洗澡',
              '看一部引人入胜的电影',
              '做家务（比如打扫房子）',
              '阅读一本书',
              '用心涂抹你最喜欢的香水、精油或润肤霜',
              '泡脚',
              '做个足疗/美甲/美睫',
              '绘画',
              '学做美食',
              '整理房间',
              '追星',
              '陪宠物玩',
              '听音乐'
            ],
            description: '',
            alias: 'q5'),
      ]
    }),
  ],
);

var impulseWaveSurvey = Survey(
  title: 'Impulse Wave',
  questions: [
    SingleChoiceQuestion(
      '我们常常认为，暴食或者清除食物的冲动会越来越强烈，直到我们无法克制。但实际上，这些冲动在上升到一个峰值后，会逐渐下降。中间可能还有几次起起伏伏，但是最终都会逐渐消逝。因此，我们就有了应对暴食和清除食物冲动的的第一种方法—冲动冲',
      ['这是什么呢？'],
      {},
    ),
    SingleChoiceQuestion(
      '想象你的冲动是海上的波浪。而你需要不断学习如何“冲浪”。当一次冲动来临时，你会发现它逐渐变得越来越强。但没关系，你需要做的，就是想象自己站在冲浪板学习如何在这个冲动上保持平衡。',
      ['当我这样想的时候会发生什么呢？'],
      {},
    ),
    MultipleChoiceQuestion(
      '是的，这是一件不容易的事情，但你有很长的时间来慢慢练习，不要急着在短时间内就学会它。你会发现，在长期的练习中，你能够成功冲浪的时间越来越久。这会给你带来很好的感受。如果你还想知道一些帮助我运用这个方法的技巧！',
      ['看得更远', '从小浪开始', '循序渐进'],
      {},
    ),
    SingleChoiceQuestion(
      '在冲浪的时候努力想：这种冲动过一会儿就会消退！它只是刚开始比较强烈而已',
      ['我知道了！'],
      {},
    ),
    TextQuestion(
      '随着时间推移，你会注意到这种冲动的力量在波动起伏。随着它升起、落下，升起…你需要学着驾驭海浪—暴食冲动，并最终平静下来。你的第一个目标是，坚持冲动冲浪几分钟？',
      false,
    ),
  ],
);

// TODO 定义饮食日志教学反思Survey
var monitoringTeachingReflectionSurvey = Survey(
    title: '饮食日志反思',
    questions: [
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
          SingleChoiceQuestion(
              '你的本周总暴食次数为**，让我们开始对暴食部分的分析吧', ['好的！'], {} // 可能需要添加子问题或描述
              ),
          ChartQuestion(
            "能识别诱因和不能识别诱因的暴食比例",
            [
              ChartData("能识别诱因", 60),
              ChartData("不能识别诱因", 40),
            ],
            QuestionType.None,
            [],
            ChartType.Bar,
          ),
          ChartQuestion(
            "暴食诱因频率表",
            [
              ChartData("工作压力", 30),
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
          TextQuestion('我的暴食诱因通常是什么呢？', false),
          TextQuestion('怎样对我的暴食诱因进行更好的控制和管理呢？', false),
          ChartQuestion(
            "每天暴食次数在一周内变化",
            [
              ChartData("星期一", 3),
              ChartData("星期二", 2),
              ChartData("星期三", 5),
              ChartData("星期四", 4),
              ChartData("星期五", 1),
              ChartData("星期六", 3),
              ChartData("星期日", 2),
            ],
            QuestionType.None,
            [],
            ChartType.Bar,
          ),
          ChartQuestion(
              '暴食次数与一天中的时间段',
              [
                ChartData('0', 0),
                ChartData('3', 0),
                ChartData('6', 0),
                ChartData('9', 5),
                ChartData('12', 10),
                ChartData('15', 0),
                ChartData('18', 15),
                ChartData('21', 7),
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
                ChartData('家里', 12),
                ChartData('公司', 8),
                ChartData('学校', 3),
                ChartData('饭店', 5),
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
              ChartData('非常不开心', 6),
              ChartData('很不开心', 3),
              ChartData('不开心', 11),
              ChartData('一般', 9),
              ChartData('开心', 4),
              ChartData('很开心', 4),
              ChartData('非常开心', 2),
            ],
            QuestionType.None,
            [],
            ChartType.Bar,
          ),
          ChartQuestion(
            '暴食次数与情绪类型',
            [
              ChartData('伤心', 10),
              ChartData('疲惫', 8),
              ChartData('紧张', 12),
              ChartData('无聊', 7),
              ChartData('兴奋', 5),
              ChartData('羞愧', 6),
              ChartData('愤怒', 11),
              ChartData('恐惧', 4),
              ChartData('平静', 3),
              ChartData('开心', 2)
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
              ChartData('快餐', 14),
              ChartData('甜食', 10),
              ChartData('小吃', 18),
              ChartData('营养餐', 3),
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
              ChartData("星期一", 1),
              ChartData("星期二", 2),
              ChartData("星期三", 1),
              ChartData("星期四", 4),
              ChartData("星期五", 1),
              ChartData("星期六", 1),
              ChartData("星期日", 2),
            ],
            QuestionType.None,
            [],
            ChartType.Bar,
          ),
          ChartQuestion(
            "每天暴食次数在一周内变化",
            [
              ChartData("星期一", 3),
              ChartData("星期二", 2),
              ChartData("星期三", 5),
              ChartData("星期四", 4),
              ChartData("星期五", 1),
              ChartData("星期六", 3),
              ChartData("星期日", 2),
            ],
            QuestionType.None,
            [],
            ChartType.Bar,
          ),
          TextQuestion('我这几天的节食情况怎么样？它和我的暴食之间有什么关系？', false),
          ChartQuestion(
            "每天节食次数在一周内变化",
            [
              ChartData("星期一", 1),
              ChartData("星期二", 2),
              ChartData("星期三", 1),
              ChartData("星期四", 4),
              ChartData("星期五", 1),
              ChartData("星期六", 1),
              ChartData("星期日", 2),
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
              ChartData("家", 4),
              ChartData("工作地点", 2),
              ChartData("餐馆", 9),
              ChartData("户外", 7),
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
              ChartData('非常不开心', 4),
              ChartData('很不开心', 1),
              ChartData('不开心', 3),
              ChartData('一般', 4),
              ChartData('开心', 1),
              ChartData('很开心', 4),
              ChartData('非常开心', 2),
            ],
            QuestionType.None,
            [],
            ChartType.Bar,
          ),
          ChartQuestion(
            '节食次数和情绪种类的关系',
            [
              ChartData("快乐", 3),
              ChartData("悲伤", 4),
              ChartData("愤怒", 8),
              ChartData("压力", 1)
            ], // 假数据
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
              ChartData("快餐", 10),
              ChartData("水果", 8),
              ChartData("甜食", 4)
            ], // 假数据
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
      SingleChoiceQuestion('清除食物行为分析', [
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
      ),
    ],
    navigateToSummary: true);

// 饮食计划反思 D15
var regularDietReflectionSurvey = Survey(
    title: "饮食计划反思",
    questions: [
      SingleChoiceQuestion(
          "刚刚，小E对您的饮食计划进行了整理，并将帮助你以专业的视角反思自己的饮食计划。\n\n"
          "饮食计划和对应的反思是方案中被证明最有效的内容，因此要认真填写～\n\n"
          "没有想法的空可以不填，你只要分析对自己有启发的部分。您的回答绝对保密，放心填写就好啦。",
          ["好的！"],
          {}),
      ChartQuestion(
          "我有提前做好每天的饮食计划吗？",
          [
            ChartData("做了计划的天数", 3), // 假设这里的数字0会根据用户实际情况动态改变
            ChartData("没做计划的天数", 4),
          ],
          QuestionType.None,
          [],
          ChartType.Bar,
          description: "展示您在过去一周内提前做好饮食计划的天数以及未提前做好计划的天数。"),
      SingleChoiceQuestion(
          "我每天有提前做好饮食计划吗？",
          [
            "0-5天",
            "6-7天",
          ],
          {
            "0-5天": [
              TextQuestion(
                  '小E知道坚持完成这个任务是个不容易的事情，因此没有每天进行饮食计划也完全没关系～\n\n您只需要想想干扰自己进行饮食日志记录的原因，并提出一些可能的改善策略就好啦。\n\n'
                  '有什么困难阻碍着我',
                  false),
              TextQuestion('想想办法，怎样才能做的更好呢', false)
            ],
            "6-7天": [
              SingleChoiceQuestion('能坚持这么久，真的好厉害！努力保持哟～', ['好的'], {})
            ]
          },
          description: '小E看到您已经做了x天的计划'),
      ChartQuestion(
          "我的饮食计划中的每餐间隔时间",
          [
            ChartData("间隔在3-4小时的饮食计划次数", 3), // 假设这里的数字0会根据用户实际情况动态改变
            ChartData("间隔在3-4小时以外的饮食计划次数", 5),
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
          // TODO 补齐状态
          description: "小E看到您本周有y天仅仅计划了3餐或3餐以下"),
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
                  false),
              TextQuestion('对策', false)
            ]
          },
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
          description: ""),
      SingleChoiceQuestion(
          "我做的饮食计划还有什么可以调整改善的地方吗？",
          ["暂时没有，我已经很棒啦", "有一些可以调整的地方"],
          {
            "暂时没有，我已经很棒啦": [
              SingleChoiceQuestion("真棒！继续努力哦～", ['好的！'], {})
            ],
            "有一些可以调整的地方": [
              TextQuestion(
                "请写下您认为可以调整的地方，您可以在明天的计划中努力做到~",
                false,
              )
            ]
          },
          description: ""),
      SingleChoiceQuestion(
          '真棒，你已经完成今天全部的反思内容啦，您可以再整体回顾一下您的成果，是不是有不一样的收获呢', [], {}),
      SingleChoiceQuestion(
          '今天你成功完成了一次对自己的饮食计划的反思分析！饮食计划反思要常常做，您可以以反思报告为依据，将之后的饮食计划做得更好！',
          [],
          {})
    ],
    navigateToSummary: true);

// 冲动记录
var impulseRecordingSurvey = Survey(title: '冲动记录', questions: [
  SingleChoiceQuestion(
    '你这次冲动属于',
    ['A. 暴食冲动', 'B. 清除食物的冲动'],
    {
      'A. 暴食冲动': [], // Optionally, add sub-questions for 'A. 暴食冲动' if needed
      'B. 清除食物的冲动': [],
    },
    alias: 'impulse_type',
  ),
  TimeQuestion('刚刚识别到此冲动的具体时间',
      initialTime: DateTime.now(), alias: 'timestamp'),
  // MultipleChoiceQuestion(
  //   '请选择你的暴食应对策略：',
  //   ['散步', '玩游戏', '听音乐', '找朋友'],
  //   {}, // No sub-questions for these options
  // ),

  SliderQuestion('此冲动的强烈程度', {},
      min: 1, max: 10, divisions: 9, alias: "intensity", labelBuilder: (value) {
    if (value == 1) {
      return '轻度';
    } else if (value == 5)
      return '中度';
    else if (value == 10) return '重度';
    return value.toInt().toString();
  }),
  TextQuestion('此冲动的诱因是什么？', false, alias: 'trigger'),

  // TextQuestion('结合你的替代策略，制定你对这次冲动的应对方案', false),
  SingleChoiceQuestion('结合你的替代策略，制定你对这次冲动的应对方案', [
    'A. 回顾“冲动冲浪”',
    'B. 展示“冲动替代策略卡”'
  ], {
    'A. 回顾“冲动冲浪”': [
      SingleChoiceQuestion(
          '''想象你的暴食或是清除食物的冲动是海上的波浪。而你需要学习“冲浪”。当一次冲动来临时——你发现波浪一开始会比较大，并逐渐变得越来越大……
你需要做的，就是想象自己站在冲浪板上。随着时间推移，你会注意到这种冲动的力量在波动起伏。随着它升起、落下，升起……你需要学着驾驭海浪——暴食冲动，并最终平静下来
练习这个技能会让你发现，暴食或是清除食物的冲动就像波浪一样，随着时间不断变化。如果你不屈服于强烈的冲动，它就会自行结束。
''', ['知道了'], {}),
      TextQuestion('你这次的目标是，坚持冲动冲浪几分钟?', false),
    ],
    'B. 展示“冲动替代策略卡”': [
      ResponseCardQuestion(),
    ]
  }),
  // More questions can be added here
  TextQuestion('请你制定一下针对这次冲动的应对策略吧！', false, alias: 'plan', required: true),
]);
