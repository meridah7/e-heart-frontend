//定义了每天的任务内容
// DayX 有很多不同的task
// task有不同的种类，可以是聊天机器人，也可以是问卷调查

import '../chat_models.dart';
import '../task_models.dart';
import 'survey_models.dart';


List<Task>TaskDay0 = [ task5, task6, reflectiveActivity, impulseWave, monitoringTeachingReflection, regularDietReflection];

Task task1 = Task(
  title: "Understanding Binge Eating",
  id: 'task1',
  type: TaskType.CHATBOT,
  isCompleted: false,
  day: 0,
  chatbotContent: chatbotContent2,
);

Task task2 = Task(
  title: "饮食日志教学",
  id: 'task2',
  type: TaskType.CHATBOT,
  isCompleted: false,
  day: 0,
  chatbotContent: chatbotContent1,
);



// Day 0
List<Content> chatbotContent1 = [
  Content(text: 'Hi，你好呀，我是小E', type: ContentType.TEXT, responseType: ResponseType.auto),
  // ... 其他内容实例
];

final List<Content> chatbotContent2 = [
  Content(text: 'Hi, hello there, I am E-Heart assistant', type: ContentType.TEXT, responseType: ResponseType.auto),
  Content(text: 'First of all, I want to congratulate you! Congratulations on bravely taking the first step towards combating binge eating and becoming a better version of yourself!', type: ContentType.TEXT, responseType: ResponseType.auto),
  Content(text: 'You mainly belong to', choices: ['Subjective Binge Eating', 'Objective Binge Eating'], type: ContentType.TEXT, responseType: ResponseType.choices),
  Content(text: 'Common benefits you can choose, multiple selections allowed!', choices: [
      "A. Get rid of fatigue easily, more energetic",
      "B. No more cold hands and feet",
      "C. Improved immunity",
      "D. Reduced symptoms of hypoglycemia",
      "E. No longer overweight or obese",
      "F. Alleviate gastrointestinal discomfort",
    ], type: ContentType.TEXT, responseType: ResponseType.multiChoices),
   
  Content(text: 'Great! In addition to the above, you can continue to add other health benefits in text form. Send each benefit to me separately. When you have sent all the benefits', type: ContentType.TEXT, responseType: ResponseType.userInput),
];



 // Define the questions
var question2 = MultipleChoiceQuestion('Which fruits do you like?', ['Apple', 'Banana', 'Cherry', 'Date'], {});
var question3 = TextQuestion('What is your hobby?', true);


// Define the survey
var sampleSurvey = Survey('1111 Survey', [ activityTimeQuestion, questionWithAdditionalOptions, questionWithoutAdditionalOptions, question3, sliderQuestion, question2]);
// Define the task
Task task3 = Task(
  title: "改变准备",
  id: 'task3',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 0,
  survey: sampleSurvey,
);

var activityTimeQuestion = TimeQuestion(
  'At what time would you like to start the activity?',
  initialTime: DateTime.now(), // 设置默认时间为当前时间
);


// 提供additionalOptions
var questionWithAdditionalOptions = MultipleChoiceQuestion(
  'Which additional features are important to you?',
  ['Feature A', 'Feature B', 'Feature C'],
  {},
  additionalOptions: {'Feature D': false, 'Feature E': false},
  description: 'Please select all that apply.',
);

// 不提供additionalOptions
var questionWithoutAdditionalOptions = MultipleChoiceQuestion(
  'Which features are important to you?',
  ['Feature A', 'Feature B', 'Feature C'],
  {},
  description: 'Please select all that apply.',
);

var sliderQuestion = SliderQuestion(
  '您今天的心情如何？',
  min: 0.0,
  max: 10.0,
  divisions: 10,
  labelBuilder: _moodSliderLabel,
);

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




Task dietaryIntake = Task(
  title: "饮食监控",
  id: 'task4',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: dietaryIntakeSurvey,
);

Task task5 = Task(
  title: "明天饮食计划",
  id: 'task5',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: mealPlanningSurvey,
);


Task task6 = Task(
  title: "暴食替代反思",
  id: 'task6',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: bingeEatingReflectionSurvey,
);

//impulseRecordingSurvey
Task impulseRecording = Task(
  title: "记录冲动",
  id: 'task6',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: impulseRecordingSurvey,
);

Task reflectiveActivity = Task(
  title: "制定暴食策略",
  id: 'task7',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: reflectiveActivitySurvey,
);

Task impulseWave = Task(
  title: "学习冲动冲浪",
  id: 'task8',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey:  impulseWaveSurvey,
);

//monitoringTeachingReflectionSurvey

Task monitoringTeachingReflection = Task(
  title: "监控反思教学",
  id: 'task9',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey:  monitoringTeachingReflectionSurvey,
);

//regularDietReflection
Task regularDietReflection = Task(
  title: "规律饮食计划反思",
  id: 'task10',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey:  regularDietReflectionSurvey,
);

var mealPlanningSurvey = Survey(
  '饮食计划调查',
  [
    MultipleChoiceQuestion(
      '请在其中选择5-6餐进行计划',
      ['早餐', '上午点心', '午餐', '下午点心', '晚餐', '夜宵'],
      {
        '早餐': [
          TextQuestion('早餐进食的食物', true),
          TimeQuestion('早餐的时间', initialTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 7, 0)),
        ],
        '上午点心': [
          TextQuestion('上午点心进食的食物', true),
          TimeQuestion('上午点心的时间', initialTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0)),
        ],
        '午餐': [
          TextQuestion('午餐进食的食物', true),
          TimeQuestion('午餐的时间', initialTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 0)),
        ],
        '下午点心': [
          TextQuestion('下午点心进食的食物', true),
          TimeQuestion('下午点心的时间', initialTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 15, 0)),
        ],
        '晚餐': [
          TextQuestion('晚餐进食的食物', true),
          TimeQuestion('晚餐的时间', initialTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 18, 0)),
        ],
        '夜宵': [
          TextQuestion('夜宵进食的食物', true),
          TimeQuestion('夜宵的时间', initialTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 21, 0)),
        ],
      },
    ),
    MultipleChoiceQuestion(
  '你可能有些困惑',
  [
    '已经吃了这么多顿了，每一顿居然还要尽量吃饱？？谁会这么吃？这会不会让我变得很胖？',
    '为什么在计划的时候要把每一次进食的间隔控制在3-4小时？',
    '我感觉饱的感觉不太舒服',
    '一旦吃饱，我就会觉得自己吃太多了，我要减肥！',
    '噢，我觉得没什么困惑',
  ],
  {
    '已经吃了这么多顿了，每一顿居然还要尽量吃饱？？谁会这么吃？这会不会让我变得很胖？': [
      SingleChoiceQuestion(
        '虽然饮食计划会让你吃5-6顿，但身体每天所需的总能量是固定的。因此每天的进食次数多了，每一顿吃的东西实就会变少。此外，更多的进食次数减少了食物带给你的心理压力，从而减少因为暴食变胖的可能。',
        ['好的！'],
        {}
      )
    ],
    '为什么在计划的时候要把每一次进食的间隔控制在3-4小时？ ': [
      SingleChoiceQuestion(
        '超过四小时不吃东西会让你不自觉地想着食物，给自己带来极大的心理压力。此外，四小时也会让你的身体基本消化上一次进食的食物。因此，超过四小时不吃东西会让生理的饥饿感和心理压力同时发挥作用，从而引发暴食！',
        ['好的！'],
        {}
      )
    ],
    '我感觉饱的感觉不太舒服': [
      SingleChoiceQuestion(
        '刚开始几天确实会这样，建议您尽量穿着宽松的衣物进食。过几天后这种感觉就会慢慢消失的！',
        ['好的！'],
        {}
      )
    ],
    '一旦吃饱，我就会觉得自己吃太多了，我要减肥！': [
      SingleChoiceQuestion(
        '研究发现，如果你每天吃的很少，没有摄入身体所必要的能量，这种减肥方式往往是无效的。我们把这种减肥方式叫做“溜溜球式减肥”。',
        ['好的！'],
        {}
      )
    ],
    '噢，我觉得没什么困惑': [
      // Optionally, add a SingleChoiceQuestion for this option
    ],
  },
)
 
    // Other questions for the survey
  ]
);



var bingeEatingReflectionSurvey = Survey(
  '暴食替代反思',
  [
    SingleChoiceQuestion(
      '现在，小E将教你如何基于暴食替代记录情况进行反思，这是帮助你抵抗暴食的重要环节，接下来，小E会通过问题来引导您进行反思和分析，请认真回答哟',
      ['好的！'],
      {},
    ),
    SingleChoiceQuestion(
      '在回答问题之前，小E想对你说：不要有压力，这里没有所谓的正确选项，选择最符合您真实情况的选项即可，每个选项小E都设置了相应的解决方案。所谓“双向奔赴”，您无论从哪个方向向前迈一步，我们都会稳稳接住您并给予回应~',
      ['了解了！'],
      {},
    ),
    SingleChoiceQuestion(
      '您是否在每次识别到自己暴食/清除食物冲动的时候，都立即记录下来？',
      ['是的', '有未记录的情况'],
      {
        '是的': [TextQuestion('真棒，希望你继续坚持', false)],
        '有未记录的情况': [
          TextQuestion('其实只是坚持记录冲动都对克服暴食有很大的帮助，这次是什么阻止你延迟或未记录它们呢？你觉得有什么好方法克服这些阻碍呢？', true),
        ],
      },
    ),
    SingleChoiceQuestion(
      '您是否在每次识别到自己暴食/清除食物冲动的时候，都使用了先前制定好的替代方法？',
      ['有', '没有'],
      {
        '有': [TextQuestion('真棒，想暴食/清除时转移一下注意力，可是有大作用呢', false)],
        '没有': [
          TextQuestion('您需要在此写下是什么阻止你使用它们，毕竟认识到问题是解决问题的第一步~（文本框）如果下次再遇到这种情况，您打算如何克服他们？', true),
        ],
      },
    ),
    TextQuestion('我的替代活动本身及我对它们的使用是否有改进的空间？（辅助思考：我干预得够早吗？我实践过后，是否需要根据实际效果删改或调整替代活动的优先级呢）', true),
    // More questions or reflection points can be added here
  ]
);

var impulseRecordingSurvey = Survey(
  '冲动记录',
  [
     SingleChoiceQuestion(
      '你这次冲动属于',
      ['A. 暴食冲动', 'B. 清除食物的冲动'],
      {
        'A. 暴食冲动': [], // Optionally, add sub-questions for 'A. 暴食冲动' if needed
        'B. 清除食物的冲动': [
          MultipleChoiceQuestion(
            '选择',
            ['催吐', '服用泻药', '服用利尿剂', '服用减少消化吸收的其他药品'],
            {}, // No sub-questions for these options
          ),
        ],
      },
    ),

    TimeQuestion('刚刚识别到此冲动的具体时间', initialTime: DateTime.now()),
    SliderQuestion('此冲动的强烈程度', min: 1, max: 10, divisions: 9, labelBuilder: (value) {
      if (value == 1) return '轻度';
      else if (value == 5) return '中度';
      else if (value == 10) return '重度';
      return value.toInt().toString();
    }),
    TextQuestion('此冲动的诱因是什么？', true),
    TextQuestion('结合你的替代策略，制定你对这次冲动的应对方案', true),
    // More questions can be added here
  ]
);



var reflectiveActivitySurvey = Survey(
  'Reflective Activity',
  [
    TextQuestion(
      '首先，请先仔细想想在你生活中满足以下三个特征的活动，并记下来',
      true,
      description: '1. 你需要积极地投入（比如运动）而不是消极地接受（比如看甄嬛传）\n'
                   '2. 这些活动能够给你带来积极情绪，让你开心或是有成就感！\n'
                   '3. 你真的有可能去做，而非仅仅是“想象中会去做”',
    ),
    PriorityQuestion(
      '其次，这里有一些满足第一个特征（积极投入而非被动接受）的活动清单。',
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
      description: '请按照你的优先级排序，把这些活动排序，最能带给你积极情绪的放在最前面。',
    ),
    TextQuestion(
      '最后，研究发现聆听你喜欢的音乐对应对暴食或是清除食物冲动来说也有不错的效果！',
      true,
      description: '在这里写下至少三首你喜欢的音乐。',
    ),
    
  ],
);



var impulseWaveSurvey = Survey(
  'Impulse Wave',
  [
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




// 首先定义一些示例数据用于图表
var chartData1 = [
  ChartData('选项 A', 30),
  ChartData('选项 B', 20),
  ChartData('选项 C', 50),
];

var chartData2 = [
  ChartData('类别 1', 40),
  ChartData('类别 2', 60),
  ChartData('类别 3', 30),
];

// 创建 ChartQuestion 实例
var chartQuestion1 = ChartQuestion(
  '这是你冲动冲浪的效果图表',
  chartData1,
  QuestionType.MultipleChoice,
  ['效果很好', '有待提高', '效果一般'],
  description: '选择最符合你情况的描述。',
);

var chartQuestion2 = ChartQuestion(
  '你冲动冲浪的时间分布',
  chartData2,
  QuestionType.SingleChoice,
  ['少于5分钟', '5到10分钟', '超过10分钟'],
  description: '选择最符合你情况的时间区间。',
);



// 定义监控教学反思Survey
var monitoringTeachingReflectionSurvey = Survey(
  '监控教学反思',
  [
    SingleChoiceQuestion(
      '授人以鱼不如授人以渔，今天小E将手把手教您如何基于饮食记录进行反思和分析，让您成为自己的暴食治疗师',
      ['知道了！'],
      {},
      description: '在开始前，小E再多说一句，反思分析非常重要，现在才是发挥您之前饮食记录最大作用的时候！'
    ),
    SingleChoiceQuestion(
      '我完成的饮食监控有多少天？',
      ['5-7天', '0-4天'],
      {
        '5-7天': [
          SingleChoiceQuestion('你太棒啦！有这种坚持的能力，小E相信，不管是暴食还是生命中其他的挑战你都一定能战胜他们。我们希望你之后的每周都至少能完成五天的饮食监控，当然越多越有效啦！', ['好的！'], {})
        ],
        '0-4天': [
          SingleChoiceQuestion('没关系的，万事开头难，很多人都很难在前几周就完成至少5天的饮食记录。不过，您还是需要填写阻碍您完整记录的原因和对策，这样才能在下一周做的更好~', ['好的！'], {}),
          TextQuestion('先想三个对策，然后排除两个您最不可能做到的。', true),
          MultipleChoiceQuestion(
            '没有顺利坚持5-7天饮食监控会对之后的治疗效果产生较大影响，因此，我们推荐您在这个环节暂停一下，重新进行一周的饮食监控并争取让自己在下一周的坚持天数达到5-7天。或者，您也可以回顾一下之前的“改变准备”一栏，重新思考一下自己改变的意愿。',
            ['中止反思，再进行一周的饮食监控（推荐）', '我要继续反思（不推荐，会影响之后的治疗计划效果）'],
            {}
          )
        ]
      },
      description: '完成：您完整记录下了一天内所有的进食情况'
    ),
    SingleChoiceQuestion(
      '您是否记录了所有吃&喝的食物',
      ['是', '否'],
      {
        '否': [TextQuestion('阻碍原因和对策', true)]
      }
    ),
    // ... 其他问题
    SingleChoiceQuestion(
      '您是否记录了所有吃&喝的食物',
      ['是', '否'],
      {
        '否': [TextQuestion('阻碍原因和对策', true)]
      }
    ),

    // 问题4
    SingleChoiceQuestion(
      '您是否在吃完之后尽快地把它们记录下来',
      ['是', '否'],
      {
        '否': [TextQuestion('阻碍原因和对策', true)]
      }
    ),

    // 问题5
    SingleChoiceQuestion(
      '您是否诚实地记录了自己的暴食情况',
      ['是', '否'],
      { '否': [TextQuestion('阻碍原因和对策', true)]}, // 暂无子问题
    ),
   
    
    // 问题6
    SingleChoiceQuestion(
      '您是否在最后一栏里记录了进食前后影响您饮食的想法和情绪',
      ['是', '否'],
      {
        '否': [TextQuestion('阻阻碍原因和对策', true)]
      }
    ),
    SingleChoiceQuestion(
      '我是否对自己的饮食模式更加了解了？',
      ['是', '否'],
      {} // 可能需要添加子问题或描述
    ),
    bingeEatingChartQuestion,
    bingeEatingCauseChartQuestion,
    triggerFrequencyChartQuestion,
     SingleChoiceQuestion(
      '我能够识别我暴食的诱发因素吗？',
      ['是', '否'],
      {
        '是': [TextQuestion('我的暴食诱因都是什么？', true)]
      }
    ),
    TextQuestion(
      '写下从中获得的关于饮食模式的新认识以及你觉得对克服暴食行为有用的启发',
      true // 允许多行文本输入
    ),
    bingeEatingTimeChartQuestion,
    TextQuestion('观察暴食次数与一天中的时间段，我都在什么时候暴食？发生在特定的时间吗？', true),
    bingeEatingLocationChartQuestion,
    TextQuestion('察暴食次数与对应的地点，我都在什么地方暴食？和谁吃的？', true),
    bingeEatingEmotionalIntensityChartQuestion,
    bingeEatingEmotionalTypeChartQuestion,
    TextQuestion('我的情绪和暴食之间具有什么样的关系？', true),
    bingeEatingFoodFrequencyChartQuestion,
    TextQuestion('我暴食的时候吃食物都有什么特点？我为什么选择吃这些食物？它们是我平时不敢吃的食物吗？', true),
    TextQuestion('对于诱因的有什么新发现？', true),
    TextQuestion('针对诱因的控制和管理有什么新的想法吗？', true),
    restrictTimeOfDayChartQuestion,
    TextQuestion('观察暴食次数与一天中的时间段，我都在什么时候暴食？发生在特定的时间吗', true),

    // 问题 2
    restrictLocationChartQuestion,
    TextQuestion('和谁吃，在哪吃会影响我的节食行为吗？', true),

    // 问题 3
    restrictEmotionChartQuestion,
    TextQuestion('我的情绪和节食之间具有什么样的关系？', true),

    // 问题 4
    restrictFoodFrequencyChartQuestion,
    TextQuestion('我节食的时候吃食物都有什么特点？我为什么选择吃这些食物？', true),

    // 问题 5
    TextQuestion('对于节食的新发现有什么看法或感受？', true),

    // 问题 6
    TextQuestion('探讨节食和暴食行为之间的关系及其对您的影响', true),

  ]
);


 // 示例数据1 - 每天暴食次数在一周内变化的折线图
List<ChartData> bingeEatingData = [
  ChartData("星期一", 3),
  ChartData("星期二", 2),
  ChartData("星期三", 5),
  ChartData("星期四", 4),
  ChartData("星期五", 1),
  ChartData("星期六", 3),
  ChartData("星期日", 2),
];

// 示例数据2 - 能识别诱因和不能识别诱因的暴食比例的柱状图
List<ChartData> bingeEatingCauseData = [
  ChartData("能识别诱因", 60),
  ChartData("不能识别诱因", 40),
];
ChartQuestion bingeEatingCauseChartQuestion = ChartQuestion(
  "能识别诱因和不能识别诱因的暴食比例",
  bingeEatingCauseData,
  QuestionType.None,
  [],
);

// 示例数据3 - 诱因频率表
List<ChartData> triggerFrequencyData = [
  ChartData("工作压力", 30),
  ChartData("情绪波动", 25),
  ChartData("睡眠不足", 15),
  ChartData("社交活动", 20),
  ChartData("无特定原因", 10),
];
ChartQuestion triggerFrequencyChartQuestion = ChartQuestion(
  "诱因频率表",
  triggerFrequencyData,
  QuestionType.None,
  [],
);



// Example data for "Observing the number of binge episodes and the time of day they occur"
List<ChartData> timeOfDayChartData = [
  ChartData('Morning', 5),
  ChartData('Afternoon', 10),
  ChartData('Evening', 15),
  ChartData('Night', 7),
];

// Example data for "Observing the number of binge episodes and corresponding locations"
List<ChartData> locationChartData = [
  ChartData('Home', 12),
  ChartData('Work', 8),
  ChartData('School', 3),
  ChartData('Restaurant', 5),
];

// Example data for "Binge Episodes and Emotional Intensity"
List<ChartData> emotionalIntensityChartData = [
  ChartData('Intensity 1-2', 6),
  ChartData('Intensity 3-4', 11),
  ChartData('Intensity 5-6', 9),
  ChartData('Intensity 7-8', 4),
  ChartData('Intensity 9-10', 2),
];

// Example data for "Characteristics and Frequencies of Foods Consumed during Binge Eating"
List<ChartData> foodFrequencyChartData = [
  ChartData('Fast Food', 14),
  ChartData('Sweets', 10),
  ChartData('Snacks', 18),
  ChartData('Healthy Food', 3),
];

List<ChartData> emotionalTypeChartData = [
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
];


ChartQuestion bingeEatingTimeChartQuestion = ChartQuestion(
  '暴食次数与一天中的时间段',
  timeOfDayChartData,
  QuestionType.None,
  [],
  description: '分析一天中暴食发生的时间段。'
);

ChartQuestion bingeEatingLocationChartQuestion = ChartQuestion(
  '暴食次数与对应的地点',
  locationChartData,
  QuestionType.None,
   [],
  description: '分析暴食发生的地点。'
);

ChartQuestion bingeEatingEmotionalIntensityChartQuestion = ChartQuestion(
  '暴食次数与情绪强度',
  emotionalIntensityChartData,
  QuestionType.None,
  [],
);

ChartQuestion bingeEatingEmotionalTypeChartQuestion = ChartQuestion(
  '暴食次数与情绪类型',
  emotionalTypeChartData,
  QuestionType.None,
  [],
);

ChartQuestion bingeEatingFoodFrequencyChartQuestion = ChartQuestion(
  '暴食次数与食物类型',
  foodFrequencyChartData,
  QuestionType.None,
  [],
);


ChartQuestion bingeEatingChartQuestion = ChartQuestion(
  "每天暴食次数在一周内变化",
  bingeEatingData,
  QuestionType.None,
  [],
);


ChartQuestion restrictTimeOfDayChartQuestion = ChartQuestion(
  '节食行为与一周内一天中的时间段的关系',
  restrictTimeOfDayChartData, // 假数据
  QuestionType.None,
  [],
  description: '分析一天中节食发生的时间段。',
);

ChartQuestion restrictLocationChartQuestion = ChartQuestion(
  '节食行为与一周内和谁吃饭、吃饭的地点的关系',
  restrictLocationChartData, // 假数据
  QuestionType.None,
  [],
  description: '分析节食发生的地点和同伴。',
);

ChartQuestion restrictEmotionChartQuestion = ChartQuestion(
  '节食次数、情绪强度和情绪种类的关系',
  restrictEmotionChartData, // 假数据
  QuestionType.None,
  [],
  description: '分析情绪强度和种类与节食的关系。',
);

ChartQuestion restrictFoodFrequencyChartQuestion = ChartQuestion(
  '节食时选择的食物种类及频率',
  restrictFoodFrequencyChartData, // 假数据
  QuestionType.None,
  [],
  description: '分析节食时选择的食物种类及频率。',
);
List<ChartData> restrictTimeOfDayChartData = [
  ChartData("早上", 9),
  ChartData("下午", 7),
  ChartData("晚上", 1),
  ChartData("夜晚", 6)
];

List<ChartData> restrictLocationChartData = [
  ChartData("家", 4),
  ChartData("工作地点", 2),
  ChartData("餐馆", 9),
  ChartData("户外", 7)
];

List<ChartData> restrictEmotionChartData = [
  ChartData("快乐", 3),
  ChartData("悲伤", 4),
  ChartData("愤怒", 8),
  ChartData("压力", 1)
];

List<ChartData> restrictFoodFrequencyChartData = [
  ChartData("快餐", 10),
  ChartData("水果", 8),
  ChartData("蔬菜", 0),
  ChartData("甜食", 4)
];




// 创建新的问卷
var regularDietReflectionSurvey = Survey(
   "规律饮食计划反思",
   [
    SingleChoiceQuestion(
      "Hi，你还记得我们第五天一起做的关于饮食监控的反思嘛～//今天的任务和那次的一样，也是教你如何成为自己的暴食治疗师，将“规律饮食”的作用发挥到极致~接下来，小E会通过问题来引导您进行反思和分析，请认真回答哟",
      ["好的！"],
      {}
    ),
    SingleChoiceQuestion(
      "在回答问题之前，小E想对你说：不要有压力，这里没有所谓的正确选项，选择最符合您真实情况的选项即可，每个选项小E都设置了相应的解决方案。/所谓“双向奔赴”，您无论从哪个方向向前迈一步，我们都会稳稳接住您并给予回应~",
      ["没问题"],
      {}
       
    ),
    dietaryPlanChartQuestion,
     SingleChoiceQuestion(
      "我有提前做好每天的规律饮食计划吗？",
      ["0-4天", "5-6天", "7天"],
      {
        "0-4天": [
          TextQuestion(
            "没有顺利坚持5-7天的规律饮食可能会对之后的治疗效果产生较大影响，因此，我们推荐您在这个环节暂停一下，重新进行一段时间的规律饮食并争取让自己在下一周的坚持天数达到5-7天。或者，您也可以回顾一下之前的“改变准备”一栏，重新思考一下自己改变的意愿。您需要写下是什么在阻碍您完成全部的计划，这样有助于更好地开始全新的一周。如果您选择继续改变，就可以带着您自己拟好的对策重新出发了，加油！", 
            true
          )
        ],
        "5-6天": [
          TextQuestion(
            "哇，作为萌新坚持这么久已经很棒啦，不过您需要写下是什么在阻碍您完成全部的计划，这样有助于您之后更好地坚持哦",
            true
          )
        ],
        "7天": [
          TextQuestion(
            "本场的MVP非你莫属！您已超越99.9%的同行者，要继续保持哟",
            false
          )
        ]
      },
      description: "选择反映您规律饮食计划制定情况的选项"
    ),
    
    mealRecordingChartQuestion,
    SingleChoiceQuestion(
    "我的每一餐记录了吗？有多少天记录了4餐及以上呢？",
    ["0-4天", "5-9天", "你也太厉害了叭！继续坚持嗷！"],
    {
      "0-4天": [
        SingleChoiceQuestion(
          "每天没有计划够4餐及以上可能会对之后的治疗效果产生较大影响，因此，我们推荐您在这个环节暂停一下，重新进行一段时间的规律饮食并争取让自己在下一周计划时每天计划够4餐及以上。或者，您也可以回顾一下之前的“改变准备”一栏，重新思考一下自己改变的意愿。您需要写下是什么在阻碍您完成全部的计划，这样有助于更好地开始全新的一周。如果你选择继续改变，就可以带着您自己拟好的对策重新出发了，加油！",
           [
            "中止反思，再进行一周的饮食计划（推荐）",
            "我要继续反思（不推荐，会影响之后的治疗计划效果）"
          ],
          {}
        )
      ],
      "5-9天": [
        TextQuestion(
          "您在计划中一点一滴的努力都会转化为之后的成效，不过您需要写下是什么在阻碍您完成这一部分，然后争取在之后的旅途中做的更好",
          true
        )
      ],
      "你也太厉害了叭！继续坚持嗷！": [
        TextQuestion(
          "好的！",
          false
        )
      ],
    }
  ),
  SingleChoiceQuestion(
    "我有努力按我所计划的内容进食吗?",
    ["基本都按照计划完成啦。", "完成了差不多一半哦。", "基本都没有按照计划完成。"],
    {
      "完成了差不多一半哦。": [
        TextQuestion(
          "请写下阻碍因素和对策！",
          true,
          description: "千万不要有压力哦，我们只是建议你尽量按照计划进食，因为这样会增强您对饮食的掌控感，但如果您因为各种原因暂时与计划有出入，也没有关系，也是非常棒的。"
        )
      ],
      "基本都没有按照计划完成。": [
        TextQuestion(
          "请写下阻碍因素和对策！",
          true,
          description: "千万不要有压力哦，我们只是建议你尽量按照计划进食，因为这样会增强您对饮食的掌控感，但如果您因为各种原因暂时与计划有出入，也没有关系，也是非常棒的。"
        )
      ],
    },
    description: "大致估计就好"
  ),
  mealIntervalChartQuestion,
  SingleChoiceQuestion(
    "为什么在计划的时候要把每一次进食的间隔控制在3-4小时呢？",
    ["下图是一个人在早上的血糖变化。七点是她吃早餐的时间，吃完早餐后血糖浓度逐渐升高，在约四小时后回落到较低水平。而在这时候，身体就会向大脑发出“无力”“头晕”等信号，提示您需要进食。因此，你需要将每一次进食间隔控制在四小时之内，避免因为身体过度饥饿引发的暴食。如果你超过四小时不吃东西，上面说到的生理饥饿和心理压力会同时发挥作用，就会有极大的可能引发暴食！规律饮食计划要求您一天吃5-6餐（每餐间隔3-4小时），其实就能够让你同时避免这两方面的影响，从而达到停止暴食的目的。"],
    {}, // 这个问题是教学性质的，所以没有子问题
    description: "解释了控制进食间隔的重要性和其对防止暴食的帮助。",
  ),
  SingleChoiceQuestion(
    "如果我没有遵循饮食计划，我是自暴自弃还是重新专注于下一次计划？",
    ["即使我偶尔没有遵循计划，我也不气馁，还能坚持完成好剩下的任务", "我一旦未能遵循，就会觉得完蛋了，从而放弃计划"],
     {
      "即使我偶尔没有遵循计划，我也不气馁，还能坚持完成好剩下的任务": [
        SingleChoiceQuestion("非常好，你的想法是完全正确的。", [], {}),
      ],
      "我一旦未能遵循，就会觉得完蛋了，从而放弃计划": [
        TextQuestion("没关系的，您不是一个人，有暴饮暴食问题的人均倾向于把一天看成一个整体，一旦出了什么问题，他们就会认为一整天被毁了。这种非黑即白的思维是不恰当的，偶尔不遵循计划没什么大不了的。一切瞬息万变，计划不被完成才是常态，您只需要随机应变，尽快回到正轨，尽量不要错过下一餐或零食。而不是拖延到第二天——这样只会让您陷入恶性循环。", false),
      ],
    },
    description: "这个问题旨在让参与者反思他们对未能遵守计划的反应，并提供正面的指导。",
  ),


  
  SingleChoiceQuestion(
    "如果一旦脱离计划暴食或清除，就会感觉心理和生理上双重不适，该如何克服呢？",
    ["针对这个问题，小E在首页也为您准备了暴食&清除应对卡，分别从心理和生理上为您减负，以后如果发生了类似情况，请及时点开应对卡哦，它会帮助您的！"],
    {}
  ),
  SingleChoiceQuestion(
    "我是否能根据具体的情境和安排调整我下一天的饮食计划？",
    ["是", "否"],
    {
      "是": [
        SingleChoiceQuestion(
          "非常好，请继续保持。",
          [],
          {}
        )
      ],
      "否": [
        TextQuestion(
          "突然而来的ddl，甲方莫名其妙的不满，喜欢的餐馆没有开门……很多事情不是我们能够掌控的，你能够做的就是接纳他们，并且适当地修改或调整我们的计划，再好的饮食模板和计划都不是必须要遵循的金科玉律，最好的执行是因时因地制宜，最好的方案是适合你的方案",
          false
        )
      ]
    }
  ),
  SingleChoiceQuestion(
    "我在计划方面有想要改进的点吗",
    ["暂时没有, 我已经很棒啦", "有可以调整的地方"],
    {
      "有可以调整的地方": [
        TextQuestion(
          "请写下您认为可以调整的地方",
          true
        )
      ]
    }
  ),

  ]
);



List<ChartData> dietaryPlanChartData = [
  ChartData("做了计划的天数", 3), // 假设这里的数字0会根据用户实际情况动态改变
  ChartData("没做计划的天数", 4),
];

ChartQuestion dietaryPlanChartQuestion = ChartQuestion(
  "我有提前做好每天的规律饮食计划吗？",
  dietaryPlanChartData,
  QuestionType.None,
  [],
  description: "展示您在过去一周内提前做好饮食计划的天数以及未提前做好计划的天数。"
);

List<ChartData> mealRecordingChartData = [
  ChartData("记录了4餐及以上的天数", 4), // 假设这里的数字0会根据用户实际情况动态改变
  ChartData("记录少于4餐的天数", 5),
];

ChartQuestion mealRecordingChartQuestion = ChartQuestion(
  "我的每一餐记录了吗？有多少天记录了4餐及以上？",
  mealRecordingChartData,
  QuestionType.None,
  [],
  description: "展示您在过去一周内每天记录的餐数，包括记录了4餐及以上的天数以及记录少于4餐的天数。"
);

List<ChartData> mealIntervalChartData = [
  ChartData("超过4小时的次数", 3), // 假设这里的数字0会根据用户实际情况动态改变
  ChartData("4小时内的次数", 5),
];

ChartQuestion mealIntervalChartQuestion = ChartQuestion(
  "我每餐之间是否超过 4 小时？",
  mealIntervalChartData,
  QuestionType.None,
  [],
  description: "展示您在过去一周内每餐之间是否超过4小时的次数，以及在4小时内进食的次数。"
);
