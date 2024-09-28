import 'package:dio/dio.dart';
import 'package:namer_app/utils/dio_client.dart';

Future<Response?> uploadSurveyData(String taskId, List<String> summary) async {
  final DioClient dioClient = DioClient();
  Map<String, dynamic> data = getUserUploadData(taskId, summary) ?? {};

  switch (taskId) {
    case 'vomitRecord':
      // 食物清除记录
      return await dioClient.postRequest('/food_purge_logs', data);
    case 'dietaryIntake':
      // 食物清除记录
      return await dioClient.postRequest('/diet_logs', data);

    default:
      return null;
  }
}

/// transform user input summary to interface params
Map<String, dynamic>? getUserUploadData(String taskId, List<String> summary) {
  switch (taskId) {
    // 食物清除记录上报
    case 'vomitRecord':
      // NOTE: maybe refactor this later, don't hardcoded text here
      int dateTimeIdx = summary.indexOf('食物清除的时间');

      DateTime? dateTime = dateTimeIdx < 0
          ? null
          : DateTime.parse(
              summary[dateTimeIdx + 1].replaceFirst("Answer: ", "").trim());

      int emotionIntensityIdx = summary.indexOf('食物清除的时候感受到的情绪强度');
      int? emotionIntensity = emotionIntensityIdx >= 0
          ? parseToInt(summary[emotionIntensityIdx + 1]
              .replaceFirst("Answer: ", "")
              .trim())
          : null;

      int emotionTypeIdx = summary.indexOf('食物清除的时候感受到的情绪种类');
      String? emotionTypeAns = emotionTypeIdx >= 0
          ? summary[emotionTypeIdx + 1].replaceFirst("Answers: ", "").trim()
          : null;
      if (emotionTypeAns != null ? emotionTypeAns.contains('其他') : false) {
        String result = '';
        int emotionTypeOtherIdx = summary.indexOf('请输入其他情绪种类');
        if (emotionTypeOtherIdx > 0) {
          RegExp regExp = RegExp(r'\[(.*?)\]');
          RegExpMatch? match =
              regExp.firstMatch(summary[emotionTypeOtherIdx + 1]);
          if (match != null) {
            result = match.group(1)!;
            emotionTypeAns.replaceFirst('其他', result);
          }
        }
      }

      int triggerIdx = summary.indexOf('请努力识别这次食物清除的诱发因素并填写它！');
      String? trigger = triggerIdx >= 0
          ? summary[triggerIdx + 1].replaceFirst("Answer: ", "").trim()
          : null;

      int additionalInfoIdx = summary.indexOf('更多注释（想法，感受等等）');
      String? additionalInfo = additionalInfoIdx >= 0
          ? summary[additionalInfoIdx + 1].replaceFirst("Answer: ", "").trim()
          : null;

      return {
        "time": dateTime?.millisecondsSinceEpoch,
        "emotion_intensity": emotionIntensity,
        "emotion_type": emotionTypeAns,
        "trigger": trigger,
        "additional_info": additionalInfo
      };
    // 饮食记录上报
    case 'dietaryIntake':
      int dateTimeIdx = summary.indexOf('进食具体时间');

      DateTime? dateTime = dateTimeIdx < 0
          ? null
          : DateTime.parse(
              summary[dateTimeIdx + 1].replaceFirst("Answer: ", "").trim());

      int foodDetailsIdx = summary.indexOf('吃了什么&吃了多少');
      String? foodDetails = foodDetailsIdx >= 0
          ? summary[foodDetailsIdx + 1].replaceFirst("Answer: ", "").trim()
          : null;

      // TODO: wait for BE support
      //     int mealsTypeIdx = summary.indexOf('属于哪一餐');
      // String? mealsType =
      //     mealsTypeIdx >= 0 ? summary[mealsType + 1].replaceFirst("Answer: ", "").trim() : null;

      int emotionIntensityIdx = summary.indexOf('进食的时候感受到的情绪强度');
      int? emotionIntensity = emotionIntensityIdx >= 0
          ? parseToInt(summary[emotionIntensityIdx + 1]
              .replaceFirst("Answer: ", "")
              .trim())
          : null;

      int emotionTypeIdx = summary.indexOf('情绪种类');
      String? emotionTypeAns = emotionTypeIdx >= 0
          ? summary[emotionTypeIdx + 1].replaceFirst("Answers: ", "").trim()
          : null;
      if (emotionTypeAns != null ? emotionTypeAns.contains('其他') : false) {
        String result = '';
        int emotionTypeOtherIdx = summary.indexOf('请输入其他情绪种类');
        if (emotionTypeOtherIdx > 0) {
          RegExp regExp = RegExp(r'\[(.*?)\]');
          RegExpMatch? match =
              regExp.firstMatch(summary[emotionTypeOtherIdx + 1]);
          if (match != null) {
            result = match.group(1)!;
            emotionTypeAns.replaceFirst('其他', result);
          }
        }
      }

      int eatingLocationIdx = summary.indexOf('在哪吃');
      String? eatingLocation = eatingLocationIdx >= 0
          ? summary[eatingLocationIdx + 1].replaceFirst("Answer: ", "").trim()
          : null;
      if (eatingLocation != null ? eatingLocation.contains('其他') : false) {
        String result = '';
        int eatingLocationOtherIdx = summary.indexOf('请输入其他地点');
        if (eatingLocationOtherIdx > 0) {
          RegExp regExp = RegExp(r'\[(.*?)\]');
          RegExpMatch? match =
              regExp.firstMatch(summary[eatingLocationOtherIdx + 1]);
          if (match != null) {
            result = match.group(1)!;
            eatingLocation.replaceFirst('其他', result);
          }
        }
      }

      int specificLocationIdx = summary.indexOf('是在家里的');
      String? specificLocation = specificLocationIdx >= 0
          ? summary[specificLocationIdx + 1].replaceFirst("Answer: ", "").trim()
          : null;

      int dietingIdx = summary.indexOf('有没有节食');
      bool? dieting = dietingIdx >= 0
          ? (summary[dietingIdx + 1].replaceFirst("Answer: ", "").trim() == '有'
              ? true
              : false)
          : null;

      int bingeEatingLevelIdx = summary.indexOf('是否暴食');
      int? bingeEatingLevel = bingeEatingLevelIdx >= 0
          ? (parseToInt(summary[bingeEatingLevelIdx + 1]
              .replaceFirst("Answer: ", "")
              .trim()))
          : null;
      bool bingeEating =
          bingeEatingLevel != null ? false : bingeEatingLevel! > 0;

      int additionalInfoIdx = summary.indexOf('更多注释（想法，感受等等）');
      String? additionalInfo = additionalInfoIdx >= 0
          ? summary[additionalInfoIdx + 1].replaceFirst("Answer: ", "").trim()
          : null;

      return {
        "eating_time": dateTime?.millisecondsSinceEpoch,
        "food_details": foodDetails,
        "emotion_intensity": emotionIntensity,
        "emotion_type": emotionTypeAns,
        "eating_location": eatingLocation,
        "specific_location": specificLocation,
        "dieting": dieting,
        "binge_eating": bingeEating,
        "trigger": "",
        "additional_info": additionalInfo
      };
    default:
      return null;
  }
}

int? parseToInt(String input) {
  // Try to parse it as an integer first
  int? integer = int.tryParse(input);
  if (integer != null) {
    return integer;
  }

  // If it's not an integer, try parsing it as a double and then convert to int
  double? doubleNumber = double.tryParse(input);
  if (doubleNumber != null) {
    return doubleNumber.toInt();
  }

  // Return null if neither int nor double could be parsed
  return null;
}
