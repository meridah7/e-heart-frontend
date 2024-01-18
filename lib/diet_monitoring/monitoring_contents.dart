import 'package:flutter/material.dart';
import 'package:namer_app/global_setting.dart';
import 'record_success_page.dart';

class MonitoringContentCard extends StatefulWidget {
  @override
  _MonitoringContentCardState createState() => _MonitoringContentCardState();
}

class _MonitoringContentCardState extends State<MonitoringContentCard> {
  List<TextEditingController> _controllers = [TextEditingController()];
  String _eatingLocationChoice = 'Home';
  TextEditingController _customEatingLocationController =
      TextEditingController();
  TextEditingController _bingeEatingCauseController = TextEditingController();

  bool _hasPurgingBehavior = false;
  Map<String, bool> _purgingMethods = {
    'No food purging': false,
    'Taking diuretics': false,
    'Taking laxatives': false,
    'Inducing vomiting': false,
    'Taking absorption reducing drugs': false,
  };

  TextEditingController _otherPurgingController = TextEditingController();
  TextEditingController _otherThoughtsController = TextEditingController();

  double _bingeEatingLevel = 0;
  bool _isBingeEatingUnknown = true;

  double _moodSliderValue = 1; // Assuming 0 = Unhappy, 1 = Neutral, 2 = Happy
  Map<String, bool> feelings = {
    'Anxious': false,
    'Excited': false,
    'Sad': false,
    'Pleasant': false,
    // More feelings can be added
  };

  Map<String, bool> morefeelings = {
    'Anxious': false,
    'Excited': false,
    'Sad': false,
    'Fatigued': false,
    'Satisfaction': false,
    'Guilty': false,
    'Depressed': false,
    'Calm': false,
    'Restless': false,
    // More feelings can be added
  };

  TextEditingController _otherFeelingsController = TextEditingController();
  String? _primaryLocationChoice;
  String? _secondaryLocationChoice;
  
  Map<String, List<String>> _locationOptions = {
    'Home': ['Near the dining table', 'Near the desk'],
    'School': ['Yushu Garden', "Guanchou Garden", "Tingtao Garden","Zijing Garden"],
  };

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Print logic
          print('Option results:');
          print('1. What did you eat at this time?');
          _controllers.forEach((controller) {
            print('   - ${controller.text}');
          });
          print('2. Where did you eat?');
          print('   - Main location: $_primaryLocationChoice');
          if (_secondaryLocationChoice != null) {
            print('   - Secondary location: $_secondaryLocationChoice');
          }
          print('3. How was your overall mood during this meal?');
          print('   - ${_moodSliderLabel(_moodSliderValue)}');
          print('4. What did you feel during the meal?');
          feelings.forEach((key, value) {
            if (value) {
              print('   - $key');
            }
          });
          print('   - Other feelings: ${_otherFeelingsController.text}');
          print('5. Did you binge eat?');
          print('   - ${_bingeEatingLevelText(_bingeEatingLevel)}');
          print('6. What do you think was the cause?');
          print('   - ${_bingeEatingCauseController.text}');
          print('7. Did you have any food purging behavior?');
          _purgingMethods.forEach((key, value) {
            if (value) {
              print('   - $key');
            }
          });
          print('   - Other methods: ${_otherPurgingController.text}');
          print('8. Any other thoughts?');
          print('   - ${_otherThoughtsController.text}');

          // Page navigation logic
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RecordSuccessPage()),
          );
        },
        child: Text('Submit'),
        style: ElevatedButton.styleFrom(
          primary: Colors.deepPurple,
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dietary Monitoring', style: TextStyle(color: Colors.black)),
        backgroundColor: themeColor, // Change this to match your theme color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Question 1
              _buildQuestionCard(
                '1. What did you eat at this time?',
                'List everything you ate or drank in this meal and the approximate amount. Do not record the specific weight and calories of the food! Correct example: Eight bags of chips, an 8-inch pizza, a small bowl of yogurt.',
                child: Column(
                  children: _controllers
                      .map((controller) => Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                hintText: 'Add description',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ))
                      .toList()
                    ..add(
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _controllers.add(TextEditingController());
                            });
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF9D9BE9),
                            shape:
                                StadiumBorder(), // This provides the rounded sides
                            padding: EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12), // Adjust padding as needed
                          ),
                        ),
                      ),
                    ),
                ),
              ),

              // Question 2
              _buildQuestionCard(
                '2. Where did you eat?',
                'Select the location of your meal. If there is no corresponding option, please fill it in manually below. If you moved during the meal, please fill in the location where you spent the most time eating.',
                child: Column(
                  children: _locationOptions.keys
                      .map<Widget>((String primaryLocation) {
                    List<Widget> widgets = [];
                    // Add primary menu
                    widgets.add(
                      RadioListTile<String>(
                        title: Text(primaryLocation),
                        value: primaryLocation,
                        groupValue: _primaryLocationChoice,
                        onChanged: (value) {
                          setState(() {
                            _primaryLocationChoice = value;
                            _secondaryLocationChoice = null; // Reset secondary option
                          });
                        },
                      ),
                    );

                    // If a primary menu is selected, add the corresponding secondary menu
                    if (_primaryLocationChoice == primaryLocation &&
                        _locationOptions.containsKey(primaryLocation)) {
                      // Add a gap between primary and secondary menus
                      widgets.add(SizedBox(height: 8));

                      widgets.addAll(
                        _locationOptions[primaryLocation]!
                            .map<Widget>((String secondaryLocation) {
                          return RadioListTile<String>(
                            title: Text('     $secondaryLocation'), // Indent secondary options
                            value: secondaryLocation,
                            groupValue: _secondaryLocationChoice,
                            onChanged: (value) {
                              setState(() {
                                _secondaryLocationChoice = value;
                              });
                            },

                          );
                        }).toList(),
                      );
                      
                    }

                    

                    return Column(children: widgets);
                  }).toList(),
                ),
              ),

              // Question 3 - Mood Slider
              _buildQuestionCard(
                '3. How was your overall mood during this meal?',
                'Slide the slider to select your mood.',
                child: Slider(
                  value: _moodSliderValue,
                  min: 1,
                  max: 7,
                  divisions: 6,
                  label: _moodSliderLabel(_moodSliderValue),
                  onChanged: (newValue) {
                    setState(() {
                      _moodSliderValue = newValue;
                    });
                  },
                ),
              ),

              // Question 4 - Feelings Checkbox
              _buildQuestionCard(
                '4. What did you feel during the meal?',
                'Please select all applicable feelings.',
                child: Column(
                  children: [
                    ...feelings.keys.map((String key) {
                      return CheckboxListTile(
                        title: Text(key),
                        value: feelings[key],
                        onChanged: (bool? value) {
                          setState(() {
                            feelings[key] = value!;
                          });
                        },
                      );
                    }).toList(),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _showFeelingSelectionDialog,
                      child: Text('More Feelings'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Question 5 - Binge Eating Slider
              _buildQuestionCard(
                '5. Did you binge eat?',
                'Please drag the slider to select the level of binge eating.',
                child: Slider(
                  value: _bingeEatingLevel,
                  onChanged: (newRating) {
                    setState(() => _bingeEatingLevel = newRating);
                  },
                  divisions: 3,
                  label: _bingeEatingLevelText(_bingeEatingLevel),
                  min: 0,
                  max: 3,
                ),
              ),
              // Question 6 - Binge Eating Cause
              _buildQuestionCard(
                '6. What do you think was the cause?',
                'Please try to identify the triggering factor for this binge eating and fill it in!',
                child: Column(
                  children: [
                    TextField(
                      controller: _bingeEatingCauseController,
                      decoration: InputDecoration(
                        hintText: 'Enter the cause',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        _bingeEatingCauseController.text = "I don't know why I binge ate";
                      },
                      child: Text("I don't know why I binge ate"),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF9D9BE9), // Light purple color
                        shape: StadiumBorder(), // Rounded sides
                      ),
                    ),
                  ],
                ),
              ),

              _buildQuestionCard(
                '7. Did you have any food purging behavior? If you have purged food, how did you do it?',
                'Food purging refers to behaviors such as inducing vomiting, taking laxatives, taking diuretics, taking other drugs that reduce digestion and absorption, and other similar behaviors',
                child: Column(
                  children: [
                    ..._purgingMethods.keys.map((String method) {
                      return CheckboxListTile(
                        title: Text(method),
                        value: _purgingMethods[method],
                        onChanged: (bool? value) {
                          setState(() {
                            if (method == 'No food purging') {
                              if (value == true) {
                                // If 'No food purging' is selected, disable all other options
                                _purgingMethods.forEach((key, _) =>
                                    _purgingMethods[key] = key == method);
                              }
                            } else {
                              if (value == true) {
                                // If other options are selected, set 'No food purging' to false
                                _purgingMethods['No food purging'] = false;
                              }
                              _purgingMethods[method] = value!;
                            }
                          });
                        },
                      );
                    }).toList(),
                    if (_purgingMethods['No food purging'] ==
                        false) // Show other input field only when 'No food purging' is not selected
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: _otherPurgingController,
                          decoration: InputDecoration(
                            hintText: 'Other',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              _buildQuestionCard(
                '8. Any other thoughts?',
                "Record anything that might affect this meal, whether it's your struggles, thoughts, or emotions. Try to jot down some! This record often becomes the key to improving binge eating later!",
                child: TextField(
                  controller: _otherThoughtsController,
                  decoration: InputDecoration(
                    hintText: 'Enter your thoughts',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // Additional questions...

              // Submit button
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  String _bingeEatingLevelText(double level) {
    switch (level.round()) {
      case 0:
        return 'No binge eating';
      case 1:
        return 'Mild binge eating';
      case 2:
        return 'Moderate binge eating';
      case 3:
        return 'Severe binge eating';
      default:
        return '';
    }
  }

  String _moodSliderLabel(double value) {
    switch (value.round()) {
      case 1:
        return 'Very unhappy';
      case 2:
        return 'Somewhat unhappy';
      case 3:
        return 'Somewhat unhappy';
      case 4:
        return 'Neutral';
      case 5:
        return 'Quite happy';
      case 6:
        return 'Quite happy';
      case 7:
        return 'Very happy';
      default:
        return 'Mood ${value.round()}';
    }
  }

  void _showFeelingSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('more feelings'),
          content: SingleChildScrollView(
            child: ListBody(
              children: morefeelings.keys.map((String key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: morefeelings[key],
                  onChanged: (bool? value) {
                    setState(() {
                      morefeelings[key] = value!;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('submit'),
              onPressed: () {
                // 可以在这里添加保存逻辑
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Card _buildQuestionCard(String question, String description,
      {required Widget child}) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 16.0),
            child,
          ],
        ),
      ),
    );
  }
}
