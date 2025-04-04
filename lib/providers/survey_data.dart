import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:namer_app/models/survey_models.dart';
import 'package:namer_app/services/survey_service.dart';

part 'survey_data.g.dart';

@riverpod
class SurveyData extends _$SurveyData {
  @override
  FutureOr<List<Question>?> build() async {
    return null;
  }

  Future<List<Question>?> fetchSurveyQuestions(String taskId) async {
    try {
      state = AsyncLoading();
      Future.delayed(Duration(seconds: 2));
      List<Question>? surveyQuestions =
          await SurveyService.generateSurveyQuestions(taskId);
      // final Survey survey = await ref.read(surveyServiceProvider).fetchSurvey();
      state = AsyncData(surveyQuestions);
      return surveyQuestions;
    } catch (err) {
      // state = AsyncError(err);
      rethrow;
    }
  }
}
