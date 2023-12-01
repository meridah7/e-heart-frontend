//定义了每天的任务内容
// DayX 有很多不同的task
// task有不同的种类，可以是聊天机器人，也可以是问卷调查

import 'chat_models.dart';
import 'task_models.dart';
import 'survey_models.dart';


List<Task>TaskDay0 = [task1,task2, task3];

Task task1 = Task(
  title: "认识暴食",
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
  Content(text: 'Hi，你好呀，我是小E', type: ContentType.TEXT, responseType: ResponseType.auto),
  Content(text: '首先，我要恭喜你！祝贺你勇敢地迈出了对抗暴食，成为更好的自己的第一步！', type: ContentType.TEXT, responseType: ResponseType.auto),
  Content(imageUrl: 'assets/images/image1.png', choices: ['好的'], type: ContentType.IMAGE, responseType: ResponseType.choices),
  Content(text: '您主要属于', choices: ['主观暴食', '客观暴食'],type: ContentType.TEXT, responseType: ResponseType.choices),
  Content(text: '常见的好处你可以选择，可以多选！', choices: [
      "A.摆脱易疲劳体质，精力更充沛",
      "B.不再手脚冰凉",
      "C.抵抗力会增强",
      "D.低血糖症状减轻",
      "E.不再超重或肥胖",
      "F.缓解肠胃不适",
    ], type: ContentType.TEXT, responseType: ResponseType.multiChoices),
  Content(text: '很好！除了以上这些，你可以以文字方式继续补充其他对你健康的好处。将每一个好处分别发给我。当你发完所有的好处之后，以“就这些”结尾！', type: ContentType.TEXT, responseType: ResponseType.userInput),
  // Content(text: '4444444444', type: ContentType.TEXT, responseType: ResponseType.auto),
  // Content(text: '5555555555', choices: ['主观暴食3', '客观暴食'], type: ContentType.TEXT, responseType: ResponseType.choices, id: "idtype1" ),
  // Content(text: '66666666', type: ContentType.TEXT,  responseType: ResponseType.userInput, id: "idtype"),
];

 // Define the questions
var question1 = SingleChoiceQuestion('What is your favorite color?', ['Red', 'Blue', 'Green', 'Yellow']);
var question2 = MultipleChoiceQuestion('Which fruits do you like?', ['Apple', 'Banana', 'Cherry', 'Date']);
var question3 = TextQuestion('What is your hobby?');

// Define the survey
var sampleSurvey = Survey('1111 Survey', [question1, question2, question3]);

// Define the task
Task task3 = Task(
  title: "改变准备",
  id: 'task3',
  type: TaskType.SURVEY,
  isCompleted: false,
  day: 0,
  survey: sampleSurvey,
);
