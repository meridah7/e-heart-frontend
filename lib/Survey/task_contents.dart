//定义了每天的任务内容
// DayX 有很多不同的task
// task有不同的种类，可以是聊天机器人，也可以是问卷调查

import '../Chatbot/chat_models.dart';
import '../TodayList/task_models.dart';
import 'survey_models.dart';


List<Task>TaskDay0 = [ task2,task5, task6, reflectiveActivity, impulseWave, monitoringTeachingReflection, regularDietReflection];

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
  chatbotContent: chatbotContentCustom,
);



// Day 0
List<Content> chatbotContent1 = [
  Content(text: 'Hi，你好呀，我是小E', type: ContentType.TEXT, responseType: ResponseType.auto),
  // ... 其他内容实例
];
List<Content> chatbotContentCustom = [
  Content(
    text: '你好！先来介绍一下我自己吧～我是小E。在你学习如何进行饮食康复的旅程中，我会一直陪伴着你～',
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: '让小E先来带你看看我们一期的饮食康复之路会有哪些内容。',
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: '克服暴食/清除食物是我们的一个大敌人。想要打败它，我们首先需要磨练两项基础内功。',
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: '内功一：饮食日志及其反思分析',
    choices: ['好的～我已经准备好啦！'],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text: '第一项内功——饮食日志，是我们之后每天都需要完成的内容，我们等等会教你如何完成它。放心！每天完成饮食日志的时间约只有4-6分钟。时间不长，但坚持很重要呀～',
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: '还有第二项内容：内功二：计划饮食及其反思分析',
    choices: ['我明白了，继续。'],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text: '第二项内功——计划饮食，会从第二周的第一天开始。它同样也需要每天完成，但每天只需要约2分钟！也要努力坚持哦～毕竟内功需要的就是持之以恒的锻炼。',
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: '二者对应的反思分析，会从一周两次的频率过渡到一周一次。这是对训练成果的总结、吸收和复盘。它非常重要！到时候我们会教你怎么做～',
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "除了内功外，小E还会教你战胜敌人的心法（选修教学内容）；为你打造个性化的武器（冲动替代策略）；教你各种各样的招式（DBT技巧训练）；同时，你需要在应对暴食的实战中不断训练，提升自己的武艺。（冲动应对及其反思分析）",
    choices: ['好的。'],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text: "今天是我们的起始日，我们来学习第一项非常重要的基本功——填写饮食日志",
    choices: ['什么是饮食日志呢？'],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text: "饮食日志是对自己一天中所有饮食的记录，内容包括吃了什么，在哪吃的，是否有暴食或清除，诱因是什么，当时的情绪感受等内容",
    choices: ['知道了！不过我在很多app里也记录过饮食，似乎没什么用…'],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text: "我同意，机械的记录不会有多大的帮助，精确的卡路里计算反而会让我们更愧疚。但是，我们的饮食日志和你看到过所有的饮食日志都不一样。它是被临床心理学家设计用来改善饮食障碍的，是我们治疗方案中的一个重要部分。它能够帮助你从更宏观的角度洞察、分析自己的饮食模式，找到改善暴食和清除食物行为的切入点。",
    type: ContentType.TEXT,
    responseType: ResponseType.userInput
  ),
  Content(
    text: "好的！那么我该如何填写呢？",
    type: ContentType.TEXT,
    responseType: ResponseType.userInput
  ),
  Content(
    text: "这是一个重要的问题！让小E来带你看看吧。",
    type: ContentType.TEXT,
    responseType: ResponseType.auto
  ),
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
var sampleSurvey = Survey(title: '1111 Survey', questions: [ activityTimeQuestion, questionWithAdditionalOptions, questionWithoutAdditionalOptions, question3, sliderQuestion, question2]);
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
  '您今天的心情如何？',{},
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
  title: '饮食日志',
  questions: [

    SingleChoiceQuestion(
      '首先呈现三个注意事项：1.请努力在吃完后尽快填写它！2.你不需要改变自己的进食，只需要努力真实地记录自己的饮食情况就好。3.请记录下一天内的所有饮食，而不只是正餐。',
      ['好的！?'],
      {},
    ),
    MultipleChoiceQuestion('你本次要做的记录包括',['饮食记录','食物清除记录'],{}),
    TimeQuestion('进食具体时间', initialTime: DateTime.now()),
    TextQuestion('吃了什么&吃了多少', true, description: '填写你这次进食吃下、喝下的所有东西以及大概的量。千万不要具体记录摄入食物的重量和卡路里！正确示例：八包薯片，一个八寸披萨，一小碗酸奶。'),
    SingleChoiceQuestion('属于哪一餐', ['早餐', '上午点心', '午餐', '下午点心', '晚餐', '夜宵', '零食', '饮料'], 
    {}),
    SliderQuestion('情绪强度',{}, min: 1, max: 7, divisions: 6, labelBuilder: (value) {
      if (value == 1) return '很不开心';
      else if (value == 4) return '一般';
      else if (value == 7) return '超开心';
      return value.toInt().toString();
    }),
    MultipleChoiceQuestion('情绪种类', ['伤心', '疲惫', '紧张', '无聊', '兴奋', '羞愧', '愤怒', '恐惧', '平静', '开心'], {}),
    SingleChoiceQuestion('在哪吃', ['家里', '学校', '工作地点', '餐馆', '外面', '其他'], {}, description: '选择你这次进食的所在之处。若没有对应选项，请于下方手动填写。'),
    TextQuestion('具体地点', false),
    SingleChoiceQuestion('有没有节食', ['有', '没有'], {}),
    SliderQuestion('是否暴食',{}, min: 0, max: 10, divisions: 10, labelBuilder: (value) {
      if (value == 0) return '没有暴食';
      else if (value == 5) return '中度暴食';
      else if (value == 10) return '重度暴食';
      return value.toInt().toString();
    },),
    TextQuestion('更多注释（想法，感受等等）', true, description: '记录任何可能会影响你这次饮食的东西，不管是你的纠结，想法还是情绪都可以。努力写一些！这一块的记录往往会在之后成为你改善暴食的奇招！'),
    MultipleChoiceQuestion('也许你有一些困惑：', ['我感觉记录我的饮食尤其是暴食是一件很羞耻的事情', '我极力想要忘记吃东西这件事，但记录自己吃了什么会让我更加专注于吃，这会不会让我更难受？', '我曾经记录过自己的饮食，但感觉没什么帮助', '我感觉很难坚持'], {}),
  ]
);

Task dietaryIntake = Task(
  title: "饮食日志",
  id: 'task4',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: dietaryIntakeSurvey,
);

Task task5 = Task(
  title: "每日饮食计划",
  id: 'task5',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: mealPlanningSurvey,
);


Task task6 = Task(
  title: "冲动记录反思",
  id: 'task6',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: bingeEatingReflectionSurvey,
);



Task reflectiveActivity = Task(
  title: "冲动应对策略制定",
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
  title: "饮食日志反思",
  id: 'task9',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey:  monitoringTeachingReflectionSurvey,
);

//regularDietReflection
Task regularDietReflection = Task(
  title: "饮食计划反思",
  id: 'task10',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey:  regularDietReflectionSurvey,
);
//impulseRecordingSurvey
Task impulseRecording = Task(
  title: "记录冲动",
  id: 'task11',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 1, // Assuming this is for the second day
  survey: impulseRecordingSurvey,
);


var mealPlanningSurvey = Survey(
  title: '每日饮食计划',
  questions: [
    MealQuestion(
      '制定饮食计划的核心原则：每餐的间隔应该在3-4小时之间！',
      description: '开始制定你的计划吧',
      {
        
      },
    ),
    SingleChoiceQuestion('参考营养学原则及具体食谱推荐', 
    ['点击详细展开'], 
    {
      '点击详细展开':[
        SingleChoiceQuestion('1.参考原则：\n'
        '   正餐：最好同时具备碳水化合物、蔬菜水果和优质蛋白质\n'
        '   其它餐：可以选择坚果、水果、蔬菜、奶制品、甜点（少量）\n\n'
        '2.具体食谱：\n'
        '   正餐：\n'
        '       碳水化合物：米饭/五谷杂粮/面食/包子/全麦面包/玉米/土豆/薯类\n'
        '       蛋白质：蛋类/奶制品/豆浆/肉类（羊牛猪、鸡鸭鹅、鱼虾贝）\n'
        '       维生素+膳食纤维：果蔬汁/水果/蔬菜\n'
        '   其他餐：牛奶、酸奶、咖啡，水果，坚果，小点心，蔬菜沙拉', ['好的！'], {})
      ]
    }),
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
    '为什么在计划的时候要把每一次进食的间隔控制在3-4小时？': [
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
  title: '冲动记录反思',
  questions: [
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
  title: '冲动记录',
  questions: [
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
    SliderQuestion('此冲动的强烈程度',{}, min: 1, max: 10, divisions: 9, labelBuilder: (value) {
      if (value == 1) return '轻度';
      else if (value == 5) return '中度';
      else if (value == 10) return '重度';
      return value.toInt().toString();
    }),
    TextQuestion('此冲动的诱因是什么？', true),
    TextQuestion('结合你的替代策略，制定你对这次冲动的应对方案', true,
    imageUrls: ['http://picture.gptkong.com/20240425/6ee7ca9254ab42ec84b0a13be39d683a.JPEG',
    'http://picture.gptkong.com/20240425/74bed7ac5c1744a2a042363eeee97407.JPEG']),
    // More questions can be added here
  ]
);




var reflectiveActivitySurvey = Survey(
  title: '冲动应对策略制定',
  questions: [
    SingleChoiceQuestion('第一步，制定冲动应对策略', ['好的！'], 
    {
      '好的！':[
        TextQuestion(
          '首先，请先仔细想想在你生活中满足以下三个特征的活动，并记下来\n',
          true,
          description:'1. 你需要积极地投入（比如运动）而不是消极地接受。\n'
                      '2. 这些活动能够给你带来积极情绪，让你开心或是有成就感！\n'
                      '3. 你真的有可能去做，而非仅仅是“想象中会去做”。',
        ),
        MultipleChoiceQuestion(
          '其次，这里有一些满足第一个特征（积极投入而非被动接受）的活动清单。\n'
          '勾选一下哪些是能给你带来积极情绪、成就感并且你比较方便去做的活动。', [
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
        ], {},description: ''),
        TextQuestion(
          '研究发现聆听你喜欢的音乐对应对暴食或是清除食物冲动来说也有不错的效果！',
          true,
          description: '在这里写下至少三首你喜欢的音乐。',
        ),
      ]
    }),
    
    SingleChoiceQuestion('第二步，计划具体执行方法', ['好的！'], 
    {
      '好的！':[
        MultipleChoiceQuestion(
          '比如：去看一本书。具体策略：“我可以在电子书中找到武侠小说，比如金庸的《射雕英雄传》”', [
          '听音乐',
          '骑自行车',
          '和朋友/家人打电话聊天',
          '去找朋友/家人玩',
          '玩游戏',
          '洗澡',
          '看电影',
        ], {
          '听音乐':[
            TextQuestion('', false)
          ],
          '骑自行车':[
            TextQuestion(' ', false)
          ],
          
          '和朋友/家人打电话聊天':[
            TextQuestion(' ', false)
          ],
          '去找朋友/家人玩':[
            TextQuestion(' ', false)
          ],
          '玩游戏':[
            TextQuestion(' ', false)
          ],
          '洗澡':[
            TextQuestion(' ', false)
          ],
          '看电影':[
            TextQuestion(' ', false)
          ],

        },description: '')
      ]
    }),
    
    SingleChoiceQuestion('第三步，策略排序', ['好的！'], {
      '好的！':[
        PriorityQuestion(
          '请按照你的优先级排序，把这些活动排序，最能带给你积极情绪的放在最前面。',
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
        ),
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
  ChartType.Bar,

  description: '选择最符合你情况的描述。',
);

var chartQuestion2 = ChartQuestion(
  '你冲动冲浪的时间分布',
  chartData2,
  QuestionType.SingleChoice,
  ['少于5分钟', '5到10分钟', '超过10分钟'],
  ChartType.Bar,
  description: '选择最符合你情况的时间区间。',
);



// 定义饮食日志教学反思Survey
var monitoringTeachingReflectionSurvey = Survey(
  title:'饮食日志反思',
  questions:[
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
    SingleChoiceQuestion(
      '我完成的饮食日志有多少天？',
      ['5-7天', '0-4天'],
      {
        '5-7天': [
          SingleChoiceQuestion('你太棒啦！有这种坚持的能力，小E相信，不管是暴食还是生命中其他的挑战你都一定能战胜他们。我们希望你之后的每周都至少能完成五天的饮食日志，当然越多越有效啦！', ['好的！'], {})
        ],
        '0-4天': [
          SingleChoiceQuestion('没关系的，万事开头难，很多人都很难在前几周就完成5天及以上的的饮食日志。您只需要想想干扰自己进行饮食日志记录的原因，并提出一些可能的改善策略就好啦。', ['好的！'], {}),
          TextQuestion('请先思考一下没有完整记录的原因', false),
          TextQuestion('然后在这里写下你的应对策略', false),
        ]
      },
      description: '*完成指的是————您完整记录下了一天内所有的进食情况'
    ),
    SingleChoiceQuestion(
      '您是否记录了所有吃&喝的食物',
      ['是', '否'],
      {
        '否': 
        [
          TextQuestion('请先思考一下没有完整记录的原因', false),
          TextQuestion('然后在这里写下你的应对策略', false),
        ]
      }
    ),
    // ... 其他问题

    // 问题4
    SingleChoiceQuestion(
      '您是否在吃完之后尽快地把它们记录下来',
      ['是', '否'],
      {
        '否':
        [
          TextQuestion('请先思考一下没有尽快记录的原因', false),
          TextQuestion('然后在这里写下你的应对策略', false),
        ]
      }
    ),

    // 问题5
    SingleChoiceQuestion(
      '您是否诚实地记录了自己的暴食情况',
      ['是', '否'],
      { '否':        
        [
            TextQuestion('请先思考一下没有诚实记录的原因', false),
            TextQuestion('然后在这里写下你的应对策略', false),
        ]
      }, // 暂无子问题
    ),
   
    
    // 问题6
    SingleChoiceQuestion(
      '您是否在最后一栏里记录了进食前后影响您饮食的想法和情绪',
      ['是', '否'],
      {
        '否':         
        [
          TextQuestion('请先思考一下没有完整记录的原因', false),
          TextQuestion('然后在这里写下你的应对策略', false),
        ]
      }
    ),
    SingleChoiceQuestion(
      '你的本周总暴食次数为**，让我们开始对暴食部分的分析吧',
      ['好的！'],
      {} // 可能需要添加子问题或描述
    ),
    bingeEatingCauseChartQuestion,
    triggerFrequencyChartQuestion,
    TextQuestion('我的暴食诱因通常是什么呢？', false),
    TextQuestion('怎样对我的暴食诱因进行更好的控制和管理呢？', false),
    bingeEatingWeekChartQuestion,
    bingeEatingTimeChartQuestion,
    TextQuestion('我的暴食和时间有什么关联？', false),
    TextQuestion('我能依此做什么调整来减少暴食？', false),
    bingeEatingLocationChartQuestion,
    TextQuestion('在哪吃会影响我的暴食吗？', false),
    TextQuestion('我能依此做什么调整来减少暴食？', false),
    bingeEatingEmotionalIntensityChartQuestion,
    bingeEatingEmotionalTypeChartQuestion,
    TextQuestion('情绪如何影响我的暴食？', false),
    TextQuestion('我能依此做什么调整来减少暴食？', false),
    bingeEatingFoodFrequencyChartQuestion,
    TextQuestion('我暴食的时候都吃什么种类的食物？为什么吃这些食物？', false),
    TextQuestion('我能依此做什么调整来减少暴食？', false),


    bingeEatingWeekChartQuestion,
    restrictWeekChartQuestion,
    TextQuestion('我这几天的节食情况怎么样？它和我的暴食之间有什么关系？', false),


    restrictWeekChartQuestion,
    TextQuestion('我的节食和时间有什么关联？', false),
    TextQuestion('我能对我的节食行为做出什么调整，以减少暴食的发生？', false),


    restrictLocationChartQuestion,
    TextQuestion('在哪吃会影响我的节食吗？', false),
    TextQuestion('我能对我的节食行为做出什么调整，以减少暴食的发生？', false),

    restrictEmotionChartQuestion,
    restrictEmotionalIntensityChartQuestion,
    TextQuestion('情绪如何影响我的节食？', false),
    TextQuestion('我能对我的节食行为做出什么调整，以减少暴食的发生？', false),

    restrictFoodFrequencyChartQuestion,
    TextQuestion('我节食的时候都吃什么种类的食物？为什么吃这些食物？', false),
    TextQuestion('我能对我的节食行为做出什么调整，以减少暴食的发生？', false),




    foodRemovalWeekChartQuestion,
    foodRemovalTimeOfDayChartQuestion,
    TextQuestion('我的食物清除和时间有什么关联？', false),

    foodRemovalEmotionChartQuestion,
    foodRemovalEmotionalIntensityChartQuestion,
    TextQuestion('情绪如何影响我的食物清除行为？', false),
    
    foodRemovalFoodListChartQuestion,
    TextQuestion('吃、喝的食物如何影响我的清除食物行为？', false),
    TextQuestion('我能如何改善我的清除食物行为？', false),
    SingleChoiceQuestion(
      '今天你成功完成了一次对自己的饮食日志的反思分析！您可以带着这些宝贵的想法进行之后的饮食日志记录，尤其是关于暴食诱因的模块，相信你一定对它有了更多觉察～',
      ['ok！'],
      {},
    ),
    SingleChoiceQuestion(
      '这样的饮食日志反思在前两周会以每周两次的频率进行，之后则是一周一次。您在这里写下的每一句话在之后可能都具有无与伦比的治疗效果~',
      ['好的！'],
      {},
    ),


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

// 示例数据3 - 食物清除方式比例的柱状图
List<ChartData> foodRemovalMethodsData = [
  ChartData("药物催吐", 60),
  ChartData("利尿剂", 40),
];

 // 示例数据4 - 每天节食次数在一周内变化的折线图
List<ChartData> restrictData = [
  ChartData("星期一", 1),
  ChartData("星期二", 2),
  ChartData("星期三", 1),
  ChartData("星期四", 4),
  ChartData("星期五", 1),
  ChartData("星期六", 1),
  ChartData("星期日", 2),
];


 // 示例数据4 - 每天节食次数在一周内变化的折线图
List<ChartData> foodRemovalData = [
  ChartData("星期一", 1),
  ChartData("星期二", 0),
  ChartData("星期三", 1),
  ChartData("星期四", 0),
  ChartData("星期五", 1),
  ChartData("星期六", 2),
  ChartData("星期日", 1),
];

ChartQuestion bingeEatingCauseChartQuestion = ChartQuestion(
  "能识别诱因和不能识别诱因的暴食比例",
  bingeEatingCauseData,
  QuestionType.None,
  [],
  ChartType.Bar,
);

ChartQuestion foodRemovalMethodsChartQuestion = ChartQuestion(
  "食物清除方式的比例",
  foodRemovalMethodsData,
  QuestionType.None,
  [],
  ChartType.Pie,
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
  ChartType.Bar,
  orientation: ChartOrientation.horizontal,
);

// Example data for "Observing the number of binge episodes and the time of day they occur"
List<ChartData> bingeEatingtimeOfDayChartData = [
  
  ChartData('0', 0),
  ChartData('3', 0),
  ChartData('6', 0),
  ChartData('9', 5),
  ChartData('12', 10),
  ChartData('15', 0),
  ChartData('18', 15),
  ChartData('21', 7),
];

// Example data for "Observing the number of binge episodes and corresponding locations"
List<ChartData> locationChartData = [
  ChartData('家里', 12),
  ChartData('公司', 8),
  ChartData('学校', 3),
  ChartData('饭店', 5),
];

// Example data for "Binge Episodes and Emotional Intensity"
List<ChartData> bingeEatingEmotionalIntensityChartData = [
  ChartData('非常不开心', 6),
  ChartData('很不开心', 3),
  ChartData('不开心', 11),
  ChartData('一般', 9),
  ChartData('开心', 4),
  ChartData('很开心', 4),
  ChartData('非常开心', 2),
];
// Example data for "Binge Episodes and Emotional Intensity"
List<ChartData> restrictEmotionalIntensityChartData = [
  ChartData('非常不开心', 4),
  ChartData('很不开心', 1),
  ChartData('不开心', 3),
  ChartData('一般', 4),
  ChartData('开心', 1),
  ChartData('很开心', 4),
  ChartData('非常开心', 2),
];
// Example data for "Binge Episodes and Emotional Intensity"
List<ChartData> foodRemovalEmotionalIntensityChartData = [
  ChartData('非常不开心', 1),
  ChartData('很不开心', 2),
  ChartData('不开心', 3),
  ChartData('一般', 4),
  ChartData('开心', 3),
  ChartData('很开心', 4),
  ChartData('非常开心', 1),
];



// Example data for "Characteristics and Frequencies of Foods Consumed during Binge Eating"
List<ChartData> bingeEatingFoodFrequencyChartData = [
  ChartData('快餐', 14),
  ChartData('甜食', 10),
  ChartData('小吃', 18),
  ChartData('营养餐', 3),
];

List<ChartData> foodRemovalFoodFrequencyChartData = [
  ChartData("快餐", 8),
  ChartData("水果", 2),
  ChartData("蔬菜", 3),
  ChartData("甜食", 4)
];

List<String> foodRemovalFoodFrequencyList = [
  "一个小蛋糕，一块巧克力 - 8次",
  "三个包子，一碗牛奶 - 2次",
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
  bingeEatingtimeOfDayChartData,
  QuestionType.None,
  [],
  ChartType.Bar,
  description: '分析一天中暴食发生的时间段。'
);


ChartQuestion bingeEatingLocationChartQuestion = ChartQuestion(
  '暴食次数与对应的地点',
  locationChartData,
  QuestionType.None,
   [],
  ChartType.Bar,
  orientation: ChartOrientation.horizontal,
  description: '分析暴食发生的地点。'
);

ChartQuestion bingeEatingEmotionalIntensityChartQuestion = ChartQuestion(
  '暴食次数与情绪强度',
  bingeEatingEmotionalIntensityChartData,
  QuestionType.None,
  [],
  ChartType.Bar,
);



ChartQuestion bingeEatingEmotionalTypeChartQuestion = ChartQuestion(
  '暴食次数与情绪类型',
  emotionalTypeChartData,
  QuestionType.None,
  [],
  ChartType.Bar,
  // orientation: ChartOrientation.horizontal,
);

ChartQuestion bingeEatingFoodFrequencyChartQuestion = ChartQuestion(
  '暴食次数与食物类型',
  bingeEatingFoodFrequencyChartData,
  QuestionType.None,
  [],
  ChartType.Bulleted,
  orientation: ChartOrientation.horizontal,
);

ChartQuestion bingeEatingWeekChartQuestion = ChartQuestion(
  "每天暴食次数在一周内变化",
  bingeEatingData,
  QuestionType.None,
  [],
  ChartType.Bar,
);

ChartQuestion restrictWeekChartQuestion = ChartQuestion(
  "每天节食次数在一周内变化",
  restrictData,
  QuestionType.None,
  [],
  ChartType.Bar,
);

ChartQuestion foodRemovalWeekChartQuestion = ChartQuestion(
  "每天食物清除次数在一周内变化",
  foodRemovalData,
  QuestionType.None,
  [],
  ChartType.Bar,
);


ChartQuestion restrictTimeOfDayChartQuestion = ChartQuestion(
  '节食行为与一周内一天中的时间段的关系',
  restrictTimeOfDayChartData, // 假数据
  QuestionType.None,
  [],
  ChartType.Bar,
  description: '分析一天中节食发生的时间段。',
);

ChartQuestion foodRemovalTimeOfDayChartQuestion = ChartQuestion(
  '食物清除行为与一周内一天中的时间段的关系',
  foodRemovalTimeOfDayChartData, // 假数据
  QuestionType.None,
  [],
  ChartType.Bar,
  description: '分析一天中食物清除发生的时间段。',
);

ChartQuestion restrictLocationChartQuestion = ChartQuestion(
  '节食行为与一周内吃饭的地点的关系',
  restrictLocationChartData, // 假数据
  QuestionType.None,
  [],
  ChartType.Bar,
  orientation: ChartOrientation.horizontal,
  description: '分析节食发生的地点和同伴。',
);


ChartQuestion restrictEmotionChartQuestion = ChartQuestion(
  '节食次数和情绪种类的关系',
  restrictEmotionChartData, // 假数据
  QuestionType.None,
  [],
  ChartType.Bar,
  description: '分析情绪强度和种类与节食的关系。',
);

ChartQuestion foodRemovalEmotionChartQuestion = ChartQuestion(
  '食物清除次数和情绪种类的关系',
  restrictEmotionChartData, // 假数据
  QuestionType.None,
  [],
  ChartType.Bar,
  description: '分析情绪强度和种类与食物清除的关系。',
);

ChartQuestion restrictEmotionalIntensityChartQuestion = ChartQuestion(
  '节食次数与情绪强度的关系',
  restrictEmotionalIntensityChartData,
  QuestionType.None,
  [],
  ChartType.Bar,
);

ChartQuestion foodRemovalEmotionalIntensityChartQuestion = ChartQuestion(
  '食物清除次数与情绪强度的关系',
  foodRemovalEmotionalIntensityChartData,
  QuestionType.None,
  [],
  ChartType.Bar,
);

ChartQuestion restrictFoodFrequencyChartQuestion = ChartQuestion(
  '节食时选择的食物种类',
  restrictFoodFrequencyChartData, // 假数据
  QuestionType.None,
  [],
  ChartType.Bulleted,
  orientation: ChartOrientation.horizontal,
  description: '分析节食时选择的食物种类。',
);

ChartQuestion foodRemovalFoodListChartQuestion = ChartQuestion(
  '食物清除前进食的东西',
  foodRemovalFoodFrequencyChartData, // 假数据
  QuestionType.None,
  [],
  ChartType.Bulleted,
  orientation: ChartOrientation.horizontal,
  description: '分析食物清除时选择的食物种类。',
);

List<ChartData> restrictTimeOfDayChartData = [
  ChartData('0', 0),
  ChartData('3', 0),
  ChartData('6', 0),
  ChartData('9', 5),
  ChartData('12', 10),
  ChartData('15', 0),
  ChartData('18', 15),
  ChartData('21', 7),
];

List<ChartData> foodRemovalTimeOfDayChartData = [
  ChartData('0', 0),
  ChartData('3', 1),
  ChartData('6', 0),
  ChartData('9', 8),
  ChartData('12', 3),
  ChartData('15', 0),
  ChartData('18', 5),
  ChartData('21', 7),
];

List<ChartData> restrictLocationChartData = [
  ChartData("家", 4),
  ChartData("工作地点", 2),
  ChartData("餐馆", 9),
  ChartData("户外", 7),
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
  ChartData("甜食", 4)
];



// 创建新的问卷
var regularDietReflectionSurvey = Survey(
   title: "饮食计划反思",
   questions: [
    SingleChoiceQuestion(
      "刚刚，小E对您的饮食计划进行了整理，并将帮助你以专业的视角反思自己的饮食计划。\n\n"
      "饮食计划和对应的反思是方案中被证明最有效的内容，因此要认真填写～\n\n"
      "没有想法的空可以不填，你只要分析对自己有启发的部分。您的回答绝对保密，放心填写就好啦。",
      ["好的！"],
      {}
    ),
    
    dietaryPlanChartQuestion,
    SingleChoiceQuestion(
      "我每天有提前做好饮食计划吗？",
      ["0-5天","6-7天",],
      {"0-5天":[
        TextQuestion('小E知道坚持完成这个任务是个不容易的事情，因此没有每天进行饮食计划也完全没关系～您只需要想想干扰自己进行饮食日志记录的原因，并提出一些可能的改善策略就好啦。\n\n'
        '干扰原因', false),
        TextQuestion('对策', false)
      ],
      "6-7天":[
        SingleChoiceQuestion('能坚持这么久，真的好厉害！努力保持哟～', ['好的'], {})
      ]},
      description: '小E看到您已经做了x天的计划'
    ),

  mealIntervalChartQuestion,

     SingleChoiceQuestion(
      "2. 我是否按照要求，将饮食计划的每餐间隔时间控制在3- 4 小时之间？",
      ["是", "否"],
      {
        "是": [
          SingleChoiceQuestion(
            "很棒！看来你已经完全理解我们饮食计划的核心原则啦！相信我们，这一定对缓解暴食有所帮助～", 
            [],{}
          )
        ],
        "否": [
          SingleChoiceQuestion(
            "为什么在计划的时候要把每一次进食的间隔控制在3-4小时呢？",
            ['点击查看原因'],
            {
              '点击查看原因':[
                SingleChoiceQuestion('四小时就能让你之前吃的东西消化的差不多，因此超过四小时还不吃东西就会让你的身体感到饥饿。\n\n'
                '此外，太久不吃东西会让你一直挂念着食物；这种生理饥饿和心理压力会同时发挥作用，就会有极大的可能引发暴食！\n\n'
                '饮食计划的核心原则是让您一天计划的每一次进食都间隔在3-4小时之间，其实就能够让你同时避免身体和心理的这两方面的影响，从而达到减少暴食的目的。',
                 ['好的！'], {})
            ]}
          )
        ],
      },
      description: "您计划进食的时间共有x次不在3- 4 小时之间"
    ),

     SingleChoiceQuestion(
      "我有努力按照自己的计划内容进食吗（在第二天进食时，和前一天的计划内容有一些差别很正常，不用和计划内容完全一致，只要尽量按照计划执行就好～）",
      ["我努力了～", "还没有那么努力～"],
      {
        "我努力了～": [
          SingleChoiceQuestion(
            "你真的非常棒！努力继续坚持吧～", 
            [],{}
          )
        ],

        "还没有那么努力～": [
          TextQuestion('按照计划进食真的是一件不容易的事情，需要我们一起慢慢努力。那么，你可以想想干扰自己按照饮食计划进食的原因，并提出一些可能的改善策略就好啦。\n\n'
          '干扰原因', false),
          TextQuestion('对策', false)
        ]
      },
      description: ""
    ),

     SingleChoiceQuestion(
      "如果我没有遵循饮食计划，我会努力重新专注于下一次计划吗？",
      ["即使我出于某些原因没有遵循某一餐的计划，我也能努力去完成接下来的饮食计划", 
      "如果某一次进食我没按照计划完成，我可能就会彻底放弃今天的所有计划"],
      {
        "即使我出于某些原因没有遵循某一餐的计划，我也能努力去完成接下来的饮食计划": [
          SingleChoiceQuestion(
            "非常好，你的想法很棒！",['好的！'], {}
          )
        ],

        "如果某一次进食我没按照计划完成，我可能就会彻底放弃今天的所有计划": [
          SingleChoiceQuestion(
            "如果你的一次进食没按计划做好，你可能非常沮丧，认为一整天的饮食都毁了。但其实不是的！你不需要将饮食计划做到完美，追求完美只会成为暴食最好的帮凶。\n\n"
            "因此，不管之前发生了什么，只需要重新专注于完成下一次的进食计划就好啦！",['好的！'], {}
          )
        ]
      },
      description: ""
    ),

     SingleChoiceQuestion(
      "我每天的饮食计划是否可以完全不一样？",
      ["可以", 
      "不可以"],
      {
        "可以": [
          SingleChoiceQuestion(
            "非常好，你的想法很棒！",['好的！'], {}
          )
        ],
        "不可以": [
          SingleChoiceQuestion(
            "请记住，每一天的计划都可以是不一样的！我们不需要您保持非常规律的饮食模式，您完全可以根据下一天的安排来个性化地计划自己的饮食！当然，要遵循我们每餐间隔3-4小时的核心原则哦。",['好的！'], {}
          )
        ]
      },
      description: ""
    ),

     SingleChoiceQuestion(
      "我做的饮食计划还有什么可以调整改善的地方吗？",
      ["暂时没有，我已经很棒啦", 
      "有一些可以调整的地方"],
      {
        "暂时没有，我已经很棒啦": [
          SingleChoiceQuestion(
            "真棒！继续努力哦～",['好的！'], {}
          )
        ],

        "有一些可以调整的地方": [
          TextQuestion(
            "请写下您认为可以调整的地方，您可以在明天的计划中努力做到~",false,
          )
        ]
      },
      description: ""
    ),

    SingleChoiceQuestion('真棒，你已经完成今天全部的反思内容啦，您可以再整体回顾一下您的成果，是不是有不一样的收获呢', [], {}),


    
    SingleChoiceQuestion('今天你成功完成了一次对自己的饮食计划的反思分析！饮食计划反思要常常做，您可以以反思报告为依据，将之后的饮食计划做得更好！', [], {})
  
  ]
);



List<ChartData> dietaryPlanChartData = [
  ChartData("做了计划的天数", 3), // 假设这里的数字0会根据用户实际情况动态改变
  ChartData("没做计划的天数", 4),
];

ChartQuestion dietaryPlanChartQuestion = ChartQuestion(
  "我有提前做好每天的饮食计划吗？",
  dietaryPlanChartData,
  QuestionType.None,
  [],
  ChartType.Bar,
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
  ChartType.Bar,
  description: "展示您在过去一周内每天记录的餐数，包括记录了4餐及以上的天数以及记录少于4餐的天数。"
);

List<ChartData> mealIntervalChartData = [
  ChartData("间隔在3-4小时的饮食计划次数", 3), // 假设这里的数字0会根据用户实际情况动态改变
  ChartData("间隔在3-4小时以外的饮食计划次数", 5),
];

ChartQuestion mealIntervalChartQuestion = ChartQuestion(
  "我的饮食计划中的每餐间隔时间",
  mealIntervalChartData,
  QuestionType.None,
  [],
  ChartType.Bar,
  description: ""
);
