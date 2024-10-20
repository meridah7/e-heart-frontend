import 'package:flutter/material.dart';
import 'package:namer_app/Survey/survey_models.dart';
import 'package:namer_app/Survey/survey_page.dart'; // Assuming SurveyPage can be reused or adapted
import 'package:namer_app/Tasks/Survey/tasks.dart';
import 'package:namer_app/utils/dio_client.dart';
import 'package:dio/dio.dart';

class BingeEatingRecordPage extends StatefulWidget {
  @override
  _BingeEatingRecordPageState createState() => _BingeEatingRecordPageState();
}

class _BingeEatingRecordPageState extends State<BingeEatingRecordPage> {
  final DioClient dioClient = DioClient();

  // Map<String, dynamic> refineAnswers(Map<String, dynamic> answers) {
  //   Map<String, dynamic> refined = {};
  //   for (var entry in answers.entries) {
  //     if (entry.key == 'impulse_type') {
  //       if (entry.value.contains('A')) {
  //         refined[entry.key] = 'A';
  //       } else if (entry.value.contains('B')) {
  //         refined[entry.key] = 'B';
  //       }
  //     } else if (entry.key == 'plan' || entry.key == 'trigger') {
  //       refined[entry.key] = entry.value[0];
  //     } else {
  //       refined[entry.key] = entry.value;
  //     }
  //   }
  //   return refined;
  // }

  // Future<void> handleSubmit(Map<String, dynamic> answers) async {
  //   Map refined = refineAnswers(answers);
  //   print('Survey ${answers} $refined');
  //   try {
  //     Response response =
  //         await dioClient.postRequest('/impulse/impulse-records/', {
  //       "impulse_type": refined['impulse_type'],
  //       "timestamp": refined['timestamp'],
  //       "intensity": refined['intensity'],
  //       "trigger": refined['trigger'],
  //       "plan": refined['plan']
  //     });
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use the SurveyPage widget if it's designed to be directly reusable
      body: SurveyPage(
        survey: impulseRecording.survey!,
        taskId: impulseRecording.id,
        isLastTask: false,
        // handleSubmit: handleSubmit,
      ),
      // If you need to adapt the survey logic specifically for this page,
      // you might integrate it directly here instead of using SurveyPage.
    );
  }
}
