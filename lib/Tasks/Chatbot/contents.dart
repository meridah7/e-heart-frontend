import '../../Chatbot/chat_models.dart';

final List<Content> chatbotContent2 = [
  Content(
      text: 'Hi, hello there, I am E-Heart assistant',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text:
          'First of all, I want to congratulate you! Congratulations on bravely taking the first step towards combating binge eating and becoming a better version of yourself!',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: 'You mainly belong to',
      choices: ['Subjective Binge Eating', 'Objective Binge Eating'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text: 'Common benefits you can choose, multiple selections allowed!',
      choices: [
        "A. Get rid of fatigue easily, more energetic",
        "B. No more cold hands and feet",
        "C. Improved immunity",
        "D. Reduced symptoms of hypoglycemia",
        "E. No longer overweight or obese",
        "F. Alleviate gastrointestinal discomfort",
      ],
      type: ContentType.TEXT,
      responseType: ResponseType.multiChoices),
  Content(
      text:
          'Great! In addition to the above, you can continue to add other health benefits in text form. Send each benefit to me separately. When you have sent all the benefits',
      type: ContentType.TEXT,
      responseType: ResponseType.userInput),
];

final List<Content> chatbotTestContent = [
  Content(
      text: 'ContentType-TEXT-auto',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
    imageUrl:
        'https://pbs.twimg.com/profile_images/1511434207079407618/AwzUxnVf_400x400.png',
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
      text: 'ResponseType-choices',
      choices: ['A'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text: 'ResponseType-multiChoices',
      choices: ['A', 'B', 'C'],
      type: ContentType.TEXT,
      responseType: ResponseType.multiChoices),
  Content(
      text: 'ResponseType-userInput',
      type: ContentType.TEXT,
      responseType: ResponseType.userInput)
];

List<Content> chatbotContentCustom = [
  Content(
    text: '你好！先来介绍一下我自己吧～我是小E。在你学习如何进行饮食康复的旅程中，我会一直陪伴着你～',
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: '让小E先来带你看看我们一期的饮食康复之路会有哪些内容。',
    choices: ['好的～我已经准备好啦！'],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text: '克服暴食/清除食物是我们的一个大敌人。想要打败它，我们首先需要磨练两项基础内功。',
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: '内功一：饮食日志及其反思分析',
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text:
        '第一项内功——饮食日志，是我们之后每天都需要完成的内容，我们等等会教你如何完成它。放心！每天完成饮食日志的时间约只有4-6分钟。时间不长，但坚持很重要呀～',
    choices: ['好的，我明白了！'],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text: '内功二：计划饮食及其反思分析',
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: '第二项内功——计划饮食，它会从第二周的第一天开，同样也要每天完成，但每天只需约2分钟！也要努力坚持哦～',
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: '二者对应的反思分析，会从一周两次的频率过渡到一周一次。这是对训练成果的总结、吸收和复盘。它非常重要！到时候我们会教你怎么做～',
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text:
        "除了内功外，小E还会教你战胜敌人的心法（选修教学内容）；为你打造个性化的武器（冲动替代策略）；同时，你需要在应对暴食的实战中不断训练，提升自己的武艺。（冲动应对及其反思分析）",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
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
      text:
          "我同意，机械的记录不会有多大的帮助，精确的卡路里计算反而会让我们更愧疚。但是，我们的饮食日志和你看到过所有的饮食日志都不一样。它是被临床心理学家设计用来改善饮食障碍的，是我们治疗方案中的一个重要部分。它能够帮助你从更宏观的角度洞察、分析自己的饮食模式，找到改善暴食和清除食物行为的切入点。",
      choices: ['好的！那么我该如何填写呢？'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text: "这是一个重要的问题！让小E来带你看看吧。",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
];
