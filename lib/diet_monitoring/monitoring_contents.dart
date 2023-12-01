import 'package:flutter/material.dart';
import 'package:namer_app/global_setting.dart';
import 'record_success_page.dart';

class MonitoringContentCard extends StatefulWidget {
  @override
  _MonitoringContentCardState createState() => _MonitoringContentCardState();
}

class _MonitoringContentCardState extends State<MonitoringContentCard> {
  List<TextEditingController> _controllers = [TextEditingController()];
  String _eatingLocationChoice = '家';
  TextEditingController _customEatingLocationController =
      TextEditingController();
  TextEditingController _bingeEatingCauseController = TextEditingController();

  bool _hasPurgingBehavior = false;
  Map<String, bool> _purgingMethods = {
    '没有进行过食物消除': false,
    '服用利尿剂': false,
    '服用泻药': false,
    '催吐': false,
    '减少吸收的药': false,
  };

  TextEditingController _otherPurgingController = TextEditingController();
  TextEditingController _otherThoughtsController = TextEditingController();

  double _bingeEatingLevel = 0;
  bool _isBingeEatingUnknown = true;

  double _moodSliderValue = 1; // Assuming 0 = 不开心, 1 = 一般, 2 = 开心
  Map<String, bool> feelings = {
    '焦虑': false,
    '兴奋': false,
    '难过': false,
    '愉悦': false,
    // 可以添加更多感受
  };

  Map<String, bool> morefeelings = {
    '焦虑': false,
    '兴奋': false,
    '难过': false,
    '疲劳': false,
    '满足感': false,
    '愧疚': false,
    '沮丧': false,
    '平静': false,
    '焦躁': false,
    // 可以添加更多感受
  };

  TextEditingController _otherFeelingsController = TextEditingController();
  String? _primaryLocationChoice;
  String? _secondaryLocationChoice;
  
  Map<String, List<String>> _locationOptions = {
    '家': ['餐桌旁', '书桌旁'],
    '学校': ['玉树园', "观畴园", "听涛园","紫荆园"],
  
  };

  Widget _buildSubmitButton() {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        // 打印逻辑
        print('选项结果：');
        print('1. 在这个时间里你吃了什么？');
        _controllers.forEach((controller) {
          print('   - ${controller.text}');
        });
        print('2. 你在哪里吃的呢？');
        print('   - 主要地点: $_primaryLocationChoice');
        if (_secondaryLocationChoice != null) {
          print('   - 二级地点: $_secondaryLocationChoice');
        }
        print('3. 你这次进食的总体心情如何？');
        print('   - ${_moodSliderLabel(_moodSliderValue)}');
        print('4. 你在进食中感受到了什么？');
        feelings.forEach((key, value) {
          if (value) {
            print('   - $key');
          }
        });
        print('   - 其他感受: ${_otherFeelingsController.text}');
        print('5. 你是否暴食了呢？');
        print('   - ${_bingeEatingLevelText(_bingeEatingLevel)}');
        print('6. 你认为诱因是什么？');
        print('   - ${_bingeEatingCauseController.text}');
        print('7. 你是否有清除食物的行为？');
        _purgingMethods.forEach((key, value) {
          if (value) {
            print('   - $key');
          }
        });
        print('   - 其他方式: ${_otherPurgingController.text}');
        print('8. 还有什么其他想法？');
        print('   - ${_otherThoughtsController.text}');

        // 页面跳转逻辑
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => RecordSuccessPage()),
        );
      },
      child: Text('提交'),
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
        title: Text('饮食监控', style: TextStyle(color: Colors.black)),
        backgroundColor: themeColor, // Change this to match your theme color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Question 1
              _buildQuestionCard(
                '1.在这个时间里你吃了什么？',
                '填写你这次进食吃下、喝下的所有东西以及大概的量。千万不要具体记录摄入食物的重量和卡路里!正确示例:八包薯片，一个八寸披萨，一小碗酸奶。',
                child: Column(
                  children: _controllers
                      .map((controller) => Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                hintText: '添加描述',
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
                            '增加',
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
                '2.你在哪里吃的呢？',
                '选择你这次进食的所在之处。若没有对应选项，请于下方手动填写。若在进食过程中移动了位置，请填写进食时间最长的地点。',
                child: Column(
                  children: _locationOptions.keys
                      .map<Widget>((String primaryLocation) {
                    List<Widget> widgets = [];
                    // 添加一级菜单
                    widgets.add(
                      RadioListTile<String>(
                        title: Text(primaryLocation),
                        value: primaryLocation,
                        groupValue: _primaryLocationChoice,
                        onChanged: (value) {
                          setState(() {
                            _primaryLocationChoice = value;
                            _secondaryLocationChoice = null; // 重置二级选项
                          });
                        },
                      ),
                    );

                    // 如果选中了一级菜单，添加对应的二级菜单
                    if (_primaryLocationChoice == primaryLocation &&
                        _locationOptions.containsKey(primaryLocation)) {
                      // 在一级和二级菜单之间添加间隔
                      widgets.add(SizedBox(height: 8));

                      widgets.addAll(
                        _locationOptions[primaryLocation]!
                            .map<Widget>((String secondaryLocation) {
                          return RadioListTile<String>(
                            title: Text('     $secondaryLocation'), // 二级选项缩进显示
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

              // Question  - Mood Slider
              _buildQuestionCard(
                '3.你这次进食的总体心情如何 ?',
                '滑动滑块选择你的心情。',
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
                '4.你在进食中感受到了什么？',
                '请选择所有适用的感受。',
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
                      child: Text('更多感受'),
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
                '5.你是否暴食了呢？',
                '请拖动滑轮选择暴食程度。',
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
                '6.你认为诱因是什么?',
                '请努力识别这次暴食的诱发因素并填写它!',
                child: Column(
                  children: [
                    TextField(
                      controller: _bingeEatingCauseController,
                      decoration: InputDecoration(
                        hintText: '输入诱因',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        _bingeEatingCauseController.text = "我不知道我为什么暴食";
                      },
                      child: Text('我不知道我为什么暴食'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF9D9BE9), // Light purple color
                        shape: StadiumBorder(), // Rounded sides
                      ),
                    ),
                  ],
                ),
              ),

              _buildQuestionCard(
                '7. 你是否有清除食物的行为? 如果你使用过食物清除，你是如何清除的？',
                '清除食物指的是催吐，服用泻药，服用利尿剂，服用减少消化吸收的其他药品以及其他相似的行为',
                child: Column(
                  children: [
                    ..._purgingMethods.keys.map((String method) {
                      return CheckboxListTile(
                        title: Text(method),
                        value: _purgingMethods[method],
                        onChanged: (bool? value) {
                          setState(() {
                            if (method == '没有进行过食物消除') {
                              if (value == true) {
                                // 如果选择了没有进行过食物消除，禁用其他所有选项
                                _purgingMethods.forEach((key, _) =>
                                    _purgingMethods[key] = key == method);
                              }
                            } else {
                              if (value == true) {
                                // 如果选择了其他选项，设置没有进行过食物消除为 false
                                _purgingMethods['没有进行过食物消除'] = false;
                              }
                              _purgingMethods[method] = value!;
                            }
                          });
                        },
                      );
                    }).toList(),
                    if (_purgingMethods['没有进行过食物消除'] ==
                        false) // 仅当没有选择“没有进行过食物消除”时，显示其他输入框
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: _otherPurgingController,
                          decoration: InputDecoration(
                            hintText: '其他',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              _buildQuestionCard(
                '8.还有什么其他想法?',
                '记录任何可能会影响你这次饮食的东西，不管是你的纠结，想法还是情绪都可以。努力拿一些!这块的记录往往会在之后成为你改善暴食的奇招!',
                child: TextField(
                  controller: _otherThoughtsController,
                  decoration: InputDecoration(
                    hintText: '输入你的想法',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // Additional questions...

              // 提交按钮

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
        return '没有暴食';
      case 1:
        return '轻度暴食';
      case 2:
        return '中度暴食';
      case 3:
        return '严重暴食';
      default:
        return '';
    }
  }
  String _moodSliderLabel(double value) {
  switch (value.round()) {
    case 1:
      return '很不开心';
    case 2:
      return '不太开心';
    case 3:
      return '不太开心';
    case 4:
      return '一般';
    case 5:
      return '较开心';
    case 6:
      return '较开心';
    case 7:
      return '很开心';
    default:
      return '心情${value.round()}';
  }
}

  void _showFeelingSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('选择更多感受'),
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
              child: Text('关闭'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('提交'),
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
