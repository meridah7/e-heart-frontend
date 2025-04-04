import 'package:flutter/material.dart';
import 'package:namer_app/Survey/survey_page.dart'; // Assuming SurveyPage can be reused or adapted
import 'package:namer_app/Tasks/Survey/tasks.dart';
import 'package:namer_app/services/dio_client.dart';

class BingeEatingRecordPage extends StatefulWidget {
  @override
  _BingeEatingRecordPageState createState() => _BingeEatingRecordPageState();
}

class _BingeEatingRecordPageState extends State<BingeEatingRecordPage> {
  final DioClient dioClient = DioClient();

  Map<String, dynamic> refineAnswers(Map<String, dynamic> answers) {
    Map<String, dynamic> refined = {};
    for (var entry in answers.entries) {
      if (entry.key == 'impulse_type') {
        if (entry.value.contains('A')) {
          refined[entry.key] = 'A';
        } else if (entry.value.contains('B')) {
          refined[entry.key] = 'B';
        }
      } else if (entry.key == 'plan' || entry.key == 'trigger') {
        refined[entry.key] = entry.value[0];
      } else {
        refined[entry.key] = entry.value;
      }
    }
    return refined;
  }

  Future<void> handleSubmit(Map<String, dynamic> answers) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator())
      );
      
      Map<String, dynamic> refined = refineAnswers(answers);
      await dioClient.postRequest('/impulse/binge-eating-records/', refined);
      
      // Hide loading indicator and show success
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('记录已成功提交'))
      );
      
      // Navigate back or to another page
      Navigator.of(context).pop();
    } catch (e) {
      // Hide loading indicator and show error
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('提交失败: ${e.toString()}'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use the SurveyPage widget if it's designed to be directly reusable
      body: SurveyPage(
        survey: impulseRecording.survey!,
        taskId: impulseRecording.id,
        handleSubmit: handleSubmit,
      ),
      // If you need to adapt the survey logic specifically for this page,
      // you might integrate it directly here instead of using SurveyPage.
    );
  }
}
