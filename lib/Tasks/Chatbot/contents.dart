import 'package:namer_app/models/chat_models.dart';

List<Content> dietLogTutorContent = [
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
  Content(
    imageUrl: 'assets/images/dietLogTutor-1.PNG',
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
      text: "小E会分析你进食的时间与异常饮食情况的关系，比如有些小伙伴会发现自己的暴食通常会发生在深夜或是周末…",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
    imageUrl: 'assets/images/dietLogTutor-2.PNG',
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
      text:
          "填写标准如图所示，注意我们不需要计算具体的卡路里哦。\n通过这一块的记录，你可能会发现自己只要一开始吃某种特定的食物（比如巧克力、碳水……）就容易暴食。",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
    imageUrl: 'assets/images/dietLogTutor-3.PNG',
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
    imageUrl: 'assets/images/dietLogTutor-4.PNG',
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
    imageUrl: 'assets/images/dietLogTutor-5.PNG',
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
      text: "常见的消极情绪都可能引发暴食（比如悲伤、焦虑、愤怒等）",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: "积极情绪也有可能引发暴食（比如兴奋、喜悦等）",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: "当然，感觉无聊也可能引发暴食！",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: "慢慢探索你引发暴食的更多情绪因素吧！",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
    imageUrl: 'assets/images/dietLogTutor-6.png',
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
      text: "比如有朋友发现自己单独在家或宿舍时容易暴食和催吐，当ta尝试去食堂吃饭就好很多…",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
    imageUrl: 'assets/images/dietLogTutor-7.png',
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
      text: "节食可是暴食的常见心理和生理诱因哦",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: "悄悄说一句：所有的问题答案我们都会加密，包括这个饮食日志的分析内容也是由后台自动整理的！所以请放心！真实地填写就好",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
    imageUrl: 'assets/images/dietLogTutor-8.png',
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
      text: "如果这两题你选了“是”，那么将会触发以下问题",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
    imageUrl: 'assets/images/dietLogTutor-9.png',
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
      text: '这是9条常见的暴食/清除食物诱发因素，看看哪些能引起你的共鸣呢？',
      choices: [
        "吃的太少，身体能量不足",
        "经期及激素的影响",
        "以某种方式限制饮食",
        "情绪",
        "感觉自己很胖",
        "松散的时间安排",
        "一个人呆着",
        "体重增加",
        "饮酒"
      ],
      type: ContentType.TEXT,
      responseType: ResponseType.multiChoices),
  Content(
      text: "看来以上因素更有可能引发你的暴食。觉知到它们是很重要的！",
      choices: ['好的！'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text: "你可能已经发现了，暴食或者清除食物的行为并不总是因为生理因素（吃的太少、经期及激素影响）。",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text:
          "它也可能来自于心理因素。（日常情绪、限制饮食的压力，感觉胖的烦恼，一些自动产生的其它固化认知等等）\n或来自于某些外部因素。（一个人呆着，称体重，喝酒）",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: "你可以想一下，自己平时的诱因都是什么呢？",
      type: ContentType.TEXT,
      responseType: ResponseType.userInput),
  Content(
      text: "真棒！在饮食日志填写的过程中，你会慢慢觉察到更多的暴食诱因，进而才能控制它们。",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: "关于暴食/清除食物诱因的更多有趣内容，小E会在我们的选修模块里和你分享！快去找她玩吧～",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
    imageUrl: 'assets/images/dietLogTutor-10.png',
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
      text:
          "清除食物就是以某种方式排出食物或是减少体内食物的吸收。\n你在这里需要选择具体的清除食物行为，比如催吐，使用泻药，过度运动等。\n关于清除食物的更多有趣内容，可以去问问小E～",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
    imageUrl: 'assets/images/dietLogTutor-11.png',
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
      text:
          "在这里，尝试以日志写作的方式，记录你对自己饮食情况的想法，感受。\n你写的内容没有人能看到，因此想写多少、写什么都可以。\n重要的是写出来，让它帮你释放、宣泄消极情绪，更好地理清自己的思维和困局，重获掌控感。",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: "好啦，今天很棒，在日后饮食日志的填写过程中，有任何疑问都可以打开这节课，再次重温一下哦",
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
];

List<Content> impulseSurfingTutorContent = [
  Content(
      text: '我们常常认为，暴食或者清除食物的冲动会越来越强烈，直到我们无法克制。',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '但实际上，这些冲动在上升到一个峰值后，会逐渐下降。中间可能还有几次起起伏伏，但是最终都会逐渐消逝。',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
    imageUrl: 'assets/images/impulseSurfingTutor-1.JPEG',
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
      text: '因此，我们就有了应对暴食和清除食物冲动的的第一种方法——冲动冲浪',
      choices: ['该怎么使用这种方法呢？'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text: '但实际上，这些冲动在上升到一个峰值后，会逐渐下降。中间可能还有几次起起伏伏，但是最终都会逐渐消逝。',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '想象你的冲动是海上的波浪。而你需要不断学习如何“冲浪”。',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '当一次冲动来临时，你会发现它逐渐变得越来越强。但没关系，你需要做的，就是想象自己站在冲浪板学习如何在这个冲动上保持平衡。',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '随着时间推移，你会注意到这种冲动的力量在波动起伏。随着它升起、落下，升起……你需要学着驾驭海浪——暴食冲动，并最终平静下来',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '练习这个技能会让你发现，冲动就像海上的波浪一样，随着时间不断变化。如果你不屈服于强烈的冲动，它就会自行结束。',
      choices: ['你说的简单，做起来也太难了'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text:
          '是的，这是一件不容易的事情，但你有很长的时间来慢慢练习，不要急着在短时间内就学会它。你会发现，在长期的练习中，你能够成功冲浪的时间越来越久。这会给你带来很好的感受。',
      choices: ['那么，有什么能够帮我更好地进行冲动冲浪的技巧吗？'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text: '当然有的！', type: ContentType.TEXT, responseType: ResponseType.auto),
  Content(
      text: '技巧一：看得更远\n在冲浪的时候努力想：这种冲动过一会儿就会消退！它只是刚开始比较强烈而已。',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text:
          '技巧二：从小浪开始\n尽可能早地发现自己暴食或是清除食物的冲动，冲动还比较小的时候会更容易成功，而当它们很强烈的时候你才开始冲浪往往会失败。想一想，哪几个冲浪新手的时候会一开始就挑战滔天巨浪呢？',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text:
          '技巧三：循序渐进\n不要指望一开始就坚持冲浪很长时间。刚开始只需要制定一个小目标，比如坚持“冲浪”三分钟。等到有能力完成这个目标了，再延长“冲浪”的时间。',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '那么，你的第一个冲浪目标是，在冲动前坚持冲浪（）分钟',
      type: ContentType.TEXT,
      responseType: ResponseType.userInput),
  Content(
      text: '好的，相信这个目标，你一定能够完成的！',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
];

List<Content> scheduleDietTutorContent = [
  Content(
      text: '恭喜你坚持到现在！还记得最开始我们说的，战胜暴食需要修炼两个内功吗？',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text:
          '第一个内功是你之前一直在做的饮食日志。而现在你将学习第二个内功，也是整个方案中被证明对缓解暴食最有效的部分——计划饮食。一句话概括，你需要为第二天的进食制定计划，并努力按照计划进食。',
      choices: ['计划明天吃什么和我减少暴食有什么关系呢？\n我平时也会思考明天要吃什么呀？\n这么简单的事情，如何帮助我克服暴食呢？'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text:
          '你的这些问题都非常好！不过，我们的计划饮食可不是让你随便想想，随心所欲地计划。在我们的方案中，我们要求你遵循“多餐制”这一核心原则。',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '一句话概括这一原则，就是每次计划进食的时间间隔必须在3-4小时之内！',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '当然，起床和第一餐的间隔时间、睡觉和最后一餐的间隔时间也需要满足这个标准哦。',
      choices: ['那么，遵循这个原则的饮食计划为什么能够帮助我减少暴食呢？'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text:
          '首先是生理原因：一个人消化完上一餐吃的全部食物的时间大概就是3-4小时。因此，一顿吃完3-4小时后，身体会自动发出饥饿的信号，比如饥饿、无力、头',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text:
          '其次是心理原因：如果超过四小时还不吃东西，你可能会发现，大脑控制不住地去想各种可口美食。这会带来极大的心理压力。这种压力也是引发暴食的关键因素。',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '因此，将每一餐的间隔时间计划在3-4小时内可以同时从生理和心理两方面帮助你控制暴食！',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '明白了！特殊的计划饮食同时从生理和心理两方面！减少进食的间隔时间就是有这么神奇的魅力～',
      choices: ['我还有一些疑惑：只要进食间隔在3-4小时之间，我每一餐吃多少食物都可以吗？我能刻意节食吗？我能暴饮暴食吗？'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text: '关于这个问题，我们给你简单直接的回答：',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '节食：不好！', type: ContentType.TEXT, responseType: ResponseType.auto),
  Content(
      text: '如果你有一顿节食了，那你很可能很快感到饥饿，并在3小时之内再次进食。这样，你就很容易打破我们饮食计划的原则了！',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '如果你对吃多少没有数，又害怕一下吃得太多，你可以在刚开始适当计划少一些，之后再慢慢增补。要记住，饮食计划每天都可以变动。慢',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '吃饱：最好！', type: ContentType.TEXT, responseType: ResponseType.auto),
  Content(
      text: '每一顿都能吃饱最好了！但这不容易，你很可能一不小心就吃多或者吃少了。不要急于前几',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '暴食：也行！', type: ContentType.TEXT, responseType: ResponseType.auto),
  Content(
      text: '如果你一不小心暴食了，也没关系。暴食不是一下就能被克服的，每个人都会经历许多波折。因此，原谅自己，专注于之后的计划就好！',
      choices: ["我应该知道我要吃多少了，那么，我应该吃些什么呢？我吃垃圾食品可以吗？"],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text: '告诉你个好消息，你吃什么都行！我们的饮食计划并不规定进食的任何具体食物。当然，我们也不推荐你吃垃圾食品。',
      choices: ['你们有没有吃什么的建议？不然我在计划的时候可能没有头绪呀？'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text: '有的！根据营养学的知识，我们为你设计了一些计划饮食的',
      choices: ['我在计划饮食的时候有哪些参考原则呢？'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text:
          '首先，对于正餐（早、中、晚餐），我们希望你吃的东西同时具备碳水化合物、蔬菜水果和优质蛋白质。\n对于其它餐（包括点心、下午茶、夜宵等），你可以选择坚果、水果、蔬菜、奶制品来补充缺乏的营养成分。',
      choices: ['基于你给的原则，有什么具体食物推荐吗？'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text: '我们选择了一些食物供你参考～',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text:
          '正餐：\n碳水化合物：米饭/面食/全麦面包/玉米/土豆/薯类\n蛋白质：蛋类/奶制品/豆浆/肉类（羊牛猪、鸡鸭鹅、鱼虾贝）\n维生素+膳食纤维：水果/蔬菜/果蔬汁',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '其他餐：\n牛奶、酸奶、水果、坚果、蔬菜',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '当然，这些食物都是供你参考，最重要的还是遵循计划饮食的核心原则！',
      choices: [
        '知道啦，我会将每次计划进食的时间控制在3-4小时之内的～\n但是，我之前的饮食模式可能比较混乱，按照计划执行是挺难的事情。'
      ],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text: '小E觉得这也很不容易～因此在下一周，你只需要对下一天的饮食进行计划，而不要一定要按照计划执行！',
      choices: ['啊？制定了计划又不做，会有效果吗？'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text:
          '放心～我们这一周只是给你一个过渡的时间，让你的“大脑”先习惯“计划饮食”这件事。真正要做到按计划进食不是那么快的事，我们下一周再开始慢慢按照计划执行吧！',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text:
          '另外，如果你觉得在早晨进行当天的计划进食感觉会更好，你也可以留到当天早晨来做！\n饮食计划入口将在前一天中午12点后开放，并持续到当天中午12点。超过12点的计划我们会自动算作下一天的哦。\n举个例子：你在8.27号中午12点后，就可以进行8.28的饮食计划。\n当然，你也可以选择在8.28的早上进行当天的饮食计划，只要在中午12点前完成就好啦。',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '计划饮食被证明是在我们方案中对缓解暴食最有效的成分。你可以在首页的今日任务中找到我们的饮食计划入口，现在去计划一下吧！',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
];

List<Content> dealingWithSetbackContent = [
  Content(
      text: '恭喜你坚持到最后！在结束本疗程前，小E还要教你最后两件事：应对挫折和保持进步',
      choices: ['该如何应对挫折呢？'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text: '我们首先要明白，“挫折”≠“复发”。',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '“复发”指一切都回到了原点，而“挫折”只是暂时的偏离轨道。',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '如果你认为你只是暂时遇到了挫折，你可能会采取积极的措施回到正轨。',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '而如果你认为自己复发了，你可能会彻底放弃自己，从而让事情变得更糟。',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '因此，为了最大限度地减少复发的机会，千万不要把任何遇到的挫折误认为是彻底的复发！',
      choices: ['我似乎还是有点没理解'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text:
          '我们来想象一下这个场景：几周以来你已经暴食的冲动和行为已经大幅减轻了。但某一天，你又克制不住地进行了一次疯狂的暴食。你会怎么想？你可能会感到悲伤、烦恼、绝望，你可能会想：\n1. 说明之前的治疗一点效果也没有，接下来，我的人生将会在疯狂的暴食中度过。\n2. 我之前的暴食症状改善只是侥幸，一切都还会回到原点。\n3. 我是一个只会吃的人，我毫无价值\n4. 这不公平，其他人就不会暴食，我肯定哪里出了问题',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '你觉得这些想法是正确的吗？',
      choices: ['正确', '不正确'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text: '其实，这些想法是不正确的。这些想法代表了你认为暴食问题”复发“了，一切都回到了原点。',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text:
          '然而，这其实只是暂时的“挫折”，虽然以上想法可能对你很有说服力，那一刻的痛苦也非常具有压倒性，但你只要识别出它们的错误性，直面这些挫折并采取合适的行动，就能够重新走上正轨。',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '那么小E请你思考一下，之后你遇到“挫折”的概率大概是多少呢？',
      choices: ['0%', '30%', '70%', '100%'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text:
          '其实，你之后遇到“挫折”的概率是100%！是不是很震惊？事实上，完全地和暴食说拜拜不是一件那么容易的事，我们也肯定会再次发生暴食。但是，你只要识别、直面、处理“挫折”，就能让暴食不再干扰你的生活～',
      choices: ['明白了！我以后遇到的暴食只是暂时的“挫折”，而不是彻底的“复发”。那么，当“挫折”发生的时候，我该怎么应对它呢？'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
  Content(
      text: '首先，你需要处理诱发自己“挫折”的因素。针对不同的诱发因素，小E也给你',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text: '1. 综合资源：《战胜暴食的CBT-E方法》《与进食障碍分手》《告别情绪性进食的DBT方法》',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text:
          '2. 消极事件：\n  a. 亲友亡故：《最好的告别》《生命的礼物》《当呼吸化为空气》《遗愿清单》\n  b. 学习工作挫折：《幸福超越完美》 《情绪急救》\n  c. 人际关系冲突：《被讨厌的勇气》《非暴力沟通》《自卑与超越》',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text:
          '3. 抑郁症、焦虑症或其它精神疾病\n  A. 医疗资源：北京大学第六医院，上海市精神卫生中心，中南大学湘雅医院，四川大学华西医院，首都医科大学附属脑科医院，广州医科大学附属脑科医院，南京脑科医院，武汉大学人民医院，北京回龙观医院，深圳省精神卫生中心 ——来自复旦大学精神医学专科排名\n  B. 心理热线：\n    a. 北京安定医院心理热线：010-58303286/58340263(工作日8:00-16:00）\n    b. 北京青少年服务台：010-12355（咨询时间:周一至周五9:00-20:00；周六、日 9:00-16:00）\n    c. 北京心理危机干预热线：免费电话：800-810-1117；手机用户：010-82951332（时间:每周7天、每天24小时）\n    d. 北京心理危机研究与干预中心热线：010-82951332(24小时)\n    e. 中科院心理所咨询志愿者热线：010-64851106\n    f. 北京红枫妇女热线：010-64033383，010-64073800(工作日9：00-18:00)\n    g. 青岛市危机干预中心热线：0532-85659516\n    h. 南京自杀干预中心救助热线：025-16896123(24小时)\n    i. 杭州心理研究与干预中心救助热线：0571-85029595(24小时)\n    j. 武汉市精神卫生中心危机干预中心救助热线：027-85844666(每天晚18：30-早9：30)\n    k. 重庆市生命救助热线：023-66699199\n    l. 广州市心理危机干预中心热线：020-81899120\n    m. 大连市心理危机干预中心：0411-84689595(24小时)',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  Content(
      text:
          '在处理诱发自己“挫折”的因素的时候，小E推荐您再次使用我们的治疗方案，拾起那些过去的应对暴食方法。因为你已经对这个计划很熟悉了，所以这一次的旅途会更加顺利！',
      choices: ['感谢小E！我记住啦～'],
      type: ContentType.TEXT,
      responseType: ResponseType.choices),
];

// 冲动诱因选修 X1
List<Content> x1Content = [
  Content(
    text: "相信你在第一天的饮食日志教学里已经对引起暴食/清除食物行为的诱因有了一些认识。在这里，小E也将常见的诱因分为了三类～",
    choices: ['哪三类呢？'],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text: "A.生理诱因\nB.心理诱因\nC.外部诱因",
    choices: ['ok!那这三类诱因具体都有什么呢？'],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text: "我们先来看看生理诱因吧",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "1. 吃的太少，身体能量不足\n我在除了暴食之外的时间都吃的很少。因此，身体在摄取能量不足的情况下，产生了大量进食的欲望。",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text:
        "2. 经期及激素的影响\n我发现在月经前几天和经期控制饮食特别困难。感觉身体浮肿，经前体重增加，或感到抑郁或易怒，而且我觉得月经期间消耗大，于是经常暴食。",
    choices: ['明白了！那心理诱因都有哪些呢？'],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text:
        "1. 情绪\n负面情绪（比如抑郁、焦虑、紧张、愧疚、无聊、疲惫、愤怒等），正面情绪（兴奋、开心、平静等）各种情绪均有触发暴食/清除食物行为的可能性。",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "2. 感觉自己很胖\n感觉“胖”可能不等于真的胖，但觉得自己很胖可能会导致“破罐子破摔”的想法，从而引发一场暴食/清除食物行为。",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text:
        "3. 以某种方式限制饮食\n你可能会限制自己进食的食物种类（比如不吃碳水），或是限制自己的进食时间（比如晚上不进食）。这样做可能会带来很大的心理压力，从而引发暴食。",
    choices: ['好的！那么，外部诱因有什么呢？'],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text: "1. 松散的时间安排\n松散的时间安排可能会感觉无聊，从而导致暴食。",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "2. 一个人呆着\n暴食时别人在场会让我感到羞耻，一个人呆着的时候我常常“肆无忌惮”地吃很多食物。",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "3. 体重增加\n我正在控制体重，但是体重不减反增，我很生气，选择放弃控制自己的体重，进行暴饮暴食。",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "4. 饮酒\n酒精会降低人们抵抗自己欲望的能力，让我感到沮丧和抑郁，从而增加了暴食的风险。",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "想想看，上面提到的哪些诱因会引起你的暴食或是清除食物冲动呢？",
    choices: [
      '1. 吃的太少，身体能量不足',
      '2. 经期及激素的影响',
      '3. 以某种方式限制饮食',
      '4. 情绪',
      '5. 感觉自己很胖',
      '6. 松散的时间安排',
      '7. 一个人呆着',
      '8. 体重增加',
      '9. 饮酒'
    ],
    type: ContentType.TEXT,
    responseType: ResponseType.multiChoices,
  ),
  // TODO 选择结果
  Content(
    text: "看来，XX、XX、XX（用户选择结果）更有可能引发你的暴食。觉知到它们是很重要的！",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "或者，你还发现了引起自己冲动的其它独特诱因吗？填写在下方，发送给小E吧～",
    type: ContentType.TEXT,
    responseType: ResponseType.userInput,
  ),
  Content(
    text: "看来，XXXX（用户输入结果）也可能会引发你的暴食。",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "相信今天和小E的聊天会帮助你在饮食日志中更好地填写“诱因”一栏。\n\n今天就到这里啦，要好好消化吸收今天的知识哦。",
    choices: ['好的，明白了！'],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
];

// 为什么无法停止暴食 X2
List<Content> x2Content = [
  Content(
    text: "很高兴在这里看到你！\n\n暴食&清除通常不是孤立存在的，它们与一些生理、心理因素交织形成恶性循环，让我们无法跳出这个怪圈",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "循环？",
    choices: ["是的，接下来小E会通过三位朋友的日记，带你认识这三种不同的循环"],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text: "梓楚",
    imageUrl: "assets/images/x2-person-1.JPEG",
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "不知道你是不是平行世界的第二个她，小E总结了梓楚的暴食模式，也是我们今天要介绍的第一种‘节食-暴食循环’。",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    imageUrl: "assets/images/x2-cycle-1.PNG",
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "那么，我感觉自己陷在这个循环里出不来，该怎么办呢？",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "不用担心，我们的干预计划帮助你同时从以下几个点打破循环。",
    imageUrl: "assets/images/x2-intervention-1.JPEG",
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "我知道了！那么，暴食还有什么其他的循环呢？",
    choices: ["了解下一种循环模式"],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text: '林林',
    imageUrl: "assets/images/x2-person-2.JPEG",
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "林林的情况，就是我们今天要介绍的第二种循环模式——‘节食-暴食-清除-暴食循环’：",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    imageUrl: "assets/images/x2-cycle-2.PNG",
    type: ContentType.IMAGE,
    responseType: ResponseType.choices,
    choices: ["‘清除’食物是什么意思呢？"],
  ),
  Content(
    text: "它指的是使用催吐，泻药，利尿剂等一系列强行将摄入的食物排出体外的手段，以及采取极端运动、极端节食等极端补偿行为。",
    type: ContentType.TEXT,
    choices: ["我感觉清除食物行为给我带来了很大的困扰，小E能怎么帮助我？"],
    responseType: ResponseType.choices,
  ),
  Content(
    text: "别担心！我会帮助你从以下节点打破这个循环。",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    imageUrl: "assets/images/x2-intervention-2.jpeg",
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "它指的是使用催吐，泻药，利尿剂等一系列强行将摄入的食物排出体外的手段，以及采取极端运动、极端节食等极端补偿行为。",
    type: ContentType.TEXT,
    choices: ["我感觉清除食物行为给我带来了很大的困扰，小E能怎么帮助我？"],
    responseType: ResponseType.choices,
  ),
  Content(
    text: "它指的是使用催吐，泻药，利尿剂等一系列强行将摄入的食物排出体外的手段，以及采取极端运动、极端节食等极端补偿行为。",
    type: ContentType.TEXT,
    choices: ["我感觉清除食物行为给我带来了很大的困扰，小E能怎么帮助我？"],
    responseType: ResponseType.choices,
  ),
  Content(
    imageUrl: "assets/images/person-3.PNG",
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
    text:
        "心宇说，当情绪袭来时，她不知道如何用正确的方法来应对，下意识地依靠暴食来缓解，长期依赖这种方法给她带来了更严重的生理和心理问题，使调节情绪变得更难。",
    type: ContentType.TEXT,
    responseType: ResponseType.auto,
  ),
  Content(
    imageUrl: "assets/images/cycle-3.PNG",
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  ),
  Content(
    text: "我已经陷入到这个循环里了，我该怎么打破它？？",
    choices: ["别担心！我会帮助你从以下节点打破这个循环。"],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    imageUrl: "assets/images/intervention-3.PNG",
    type: ContentType.IMAGE,
    responseType: ResponseType.auto,
  )
];

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

// 清除食物大百科 X3
List<Content> x3Content = [
  Content(
    text: "今天我们来系统地学习一下清除食物的相关知识～",
    choices: ["好的，继续！"],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text:
        "清除食物是什么？\n\n清除食物指的是催吐，泻药，利尿剂等一系列强行将摄入的食物排出体外的手段，以及极端运动、极端节食（比如第二天完全不进食或者液断）等对暴食的极端补偿行为。",
    choices: ["明白了，那为什么我会想要清除食物呢？"],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text: "我为什么会想要清除食物呢？\n\n小E总结了几个原因，来看看哪些能引起你的共鸣吧。",
    choices: ["好的！"],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text: "到你啦，现在花点时间思考一下自己清除食物的原因叭（多选）",
    choices: [
      "A.为了在暴食后排出摄入的热量",
      "B.为了控制体重",
      "C.为了摆脱‘饱胀感’，让胃感到‘空’和‘干净’",
      "D.为了促进排便",
      "E.为了缓解坏情绪"
    ],
    type: ContentType.TEXT,
    responseType: ResponseType.multiChoices,
  ),
  Content(
    text:
        "看来，XX、XX、XX（用户选择结果）更有可能引发你的暴食。觉知到它们是很重要的！\n\n你也可以想想，自己清除食物是否还有什么其它的原因呢？填写在下方，发送给小E吧～",
    type: ContentType.USER_INPUT,
    responseType: ResponseType.userInput,
  ),
  Content(
    text: "看来，XXXX（用户输入结果）也可能引发你的清除食物行为。觉察到它们特别棒！",
    choices: ["那么，清除食物真的有想象中那么‘好’吗？"],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text:
        "首先，所有形式的清除食物都会导致脱水，进而引起电解质失衡。这会影响到心脏功能；导致头晕和昏厥；极端情况下甚至可能引发心脏骤停，导致死亡。",
    choices: ["继续了解催吐的危害"],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text: "研究表明，即使你感觉在暴食后把所有的东西都吐出来了，人体通常依旧会吸收食物中40%至75%的热量...",
    choices: ["原来催吐危害这么大！"],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text:
        "可是好像只有清除食物才能缓解我的‘饱胀感’。\n\n清除食物确实能在一定程度上缓解你的‘饱胀感’，但是，清除食物不是缓解你不适的唯一方式！！",
    choices: ["我明白了！"],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
  Content(
    text: "可是我还是没忍住清除食物了……\n\n没关系的！不要苛责自己，习惯需要慢慢改变。这里给您三个缓解的小妙招...",
    choices: ["好的，学到啦！"],
    type: ContentType.TEXT,
    responseType: ResponseType.choices,
  ),
];

final List<Content> chatbotTestContent = [
  Content(
      text: 'ContentType-TEXT-auto',
      type: ContentType.TEXT,
      responseType: ResponseType.auto),
  // Content(
  //   // Local image example
  //   // imageUrl: 'images/day0-DietLogTutor-1.PNG',
  //   // Online image example
  //   imageUrl:
  //       'https://pbs.twimg.com/profile_images/1511434207079407618/AwzUxnVf_400x400.png',
  //   type: ContentType.IMAGE,
  //   responseType: ResponseType.auto,
  // ),
  // Content(
  //     text: 'ResponseType-choices',
  //     choices: ['A'],
  //     type: ContentType.TEXT,
  //     responseType: ResponseType.choices),
  // Content(
  //     text: 'ResponseType-multiChoices',
  //     choices: ['A', 'B', 'C'],
  //     type: ContentType.TEXT,
  //     responseType: ResponseType.multiChoices),
  // Content(
  //     text: 'ResponseType-userInput',
  //     type: ContentType.TEXT,
  //     responseType: ResponseType.userInput)
];
