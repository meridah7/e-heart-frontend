import 'package:flutter/material.dart';
import 'package:namer_app/Survey/survey_models.dart'; // Import the location of your Survey models
import 'package:namer_app/Survey/survey_page.dart'; // Import your SurveyPage widget
import '../../TodayList/task_models.dart';
import 'package:namer_app/Tasks/Survey/tasks.dart'; // Import tasks related to surveys

// Assuming 'themeColor' is defined elsewhere in your application
const Color themeColor = Colors.blue; // Placeholder for the actual theme color

class DietMonitoringPage extends StatefulWidget {
  @override
  _DietMonitoringPageState createState() => _DietMonitoringPageState();
}

class _DietMonitoringPageState extends State<DietMonitoringPage> {
  Task? currentSurvey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentSurvey != null
          ? null
          : AppBar(
              title: Text('饮食日志'),
              backgroundColor: themeColor,
            ),
      body: currentSurvey != null
          ? SurveyPage(
              survey: currentSurvey!.survey!,
              taskId: currentSurvey!.id,
              isLastTask: false,
            )
          : Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center horizontally
              children: [
                SizedBox(height: 30), // Add space above the first button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    '请选择本次要记录的活动：',
                    style: TextStyle(
                      fontSize: 18,
                      color:
                          Colors.grey.shade600, // Light grey color for the text
                    ),
                    textAlign: TextAlign.center, // Center the text
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width *
                        0.2, // 20% margin left and right
                  ),
                  child: SizedBox(
                    width: double
                        .infinity, // Ensures both buttons take the same width
                    height: 60, // Ensures both buttons have the same height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .lightBlueAccent.shade100, // Soft, comforting color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          currentSurvey = dietaryIntake;
                        });
                      },
                      child: Text(
                        '饮食记录',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Space between buttons
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width *
                        0.2, // 20% margin left and right
                  ),
                  child: SizedBox(
                    width: double
                        .infinity, // Ensures both buttons take the same width
                    height: 60, // Ensures both buttons have the same height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.amberAccent.shade200, // Soft warning color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          currentSurvey = vomitRecord;
                        });
                      },
                      child: Text(
                        '食物清除记录',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Spacer(), // Pushes content to the top
              ],
            ),
    );
  }
}
