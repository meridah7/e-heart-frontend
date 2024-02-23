//定义了每天的任务内容
// DayX 有很多不同的diet
// diet有不同的种类，可以是聊天机器人，也可以是问卷调查

import 'chat_models.dart';
import 'diet_models.dart';
import 'Survey/survey_models.dart';


List<Diet>DietDay0 = [diet1,];

Diet diet1 = Diet(
  food: "一份肠粉",
  id: '早餐',
  type: "早餐",
  day: 0,
  mealContent: mealContent1,
);

// Diet diet2 = Diet(
//   food: "One plate of twice-cooked pork, one bowl of rice",
//   id: 'Lunch',
//   type: "Lunch",
//   day: 0,
//   mealContent: mealContent2,
// );

// Diet diet3 = Diet(
//   food: "One cup of yogurt",
//   id: 'afternoontea',
//   type: "Afternoon Tea",
//   day: 0,
//   mealContent: mealContent2,
// );

// Diet diet4 = Diet(
//   food: "One Caesar salad, one glass of juice",
//   id: 'Dinner',
//   type: "Dinner",
//   day: 0,
//   mealContent: mealContent2,
// );

// Day 0
List<Content> mealContent1 = [
  Content(text: '欢迎回顾！你今天吃的早餐是....', type: ContentType.TEXT, responseType: ResponseType.auto),
  // ... 其他内容实例
];

final List<Content> mealContent2 = [
  Content(text: '欢迎回顾！你今天吃的午餐是....', type: ContentType.TEXT, responseType: ResponseType.auto),
];

final List<Content> mealContent5 = [
  Content(text: '欢迎回顾！你今天吃的下午茶是....', type: ContentType.TEXT, responseType: ResponseType.auto),
];

