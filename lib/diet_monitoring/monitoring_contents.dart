import 'package:flutter/material.dart';
import 'package:namer_app/global_setting.dart';
import 'reccord_success_page.dart';

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
    '疲劳': false,
  };
  TextEditingController _otherFeelingsController = TextEditingController();

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // 打印逻辑
          print('选项结果：');
          print('暴食程度: ${_bingeEatingLevel.toStringAsFixed(0)}');
          // 打印其他所有选项...

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
        title: Text('饮食监控',style:TextStyle(color: Colors.black)),
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
                  children: [
                    RadioListTile<String>(
                      title: Text('家'),
                      value: '家',
                      groupValue: _eatingLocationChoice,
                      onChanged: (value) {
                        setState(() {
                          _eatingLocationChoice = value!;
                          _customEatingLocationController.clear();
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('餐桌旁'),
                      value: '餐桌旁',
                      groupValue: _eatingLocationChoice,
                      onChanged: (value) {
                        setState(() {
                          _eatingLocationChoice = value!;
                          _customEatingLocationController.clear();
                        });
                      },
                    ),
                    TextField(
                      controller: _customEatingLocationController,
                      decoration: InputDecoration(
                        hintText: '其他',
                        border: OutlineInputBorder(),
                      ),
                    )
                  ],
                ),
              ),

              // Question  - Mood Slider
              _buildQuestionCard(
                '3.你这次进食的总体心情如何 ?',
                '滑动滑块选择你的心情。',
                child: Slider(
                  value: _moodSliderValue,
                  min: 0,
                  max: 2,
                  divisions: 2,
                  label: _moodSliderValue == 0
                      ? '很不开心'
                      : _moodSliderValue == 1
                          ? '一般'
                          : '很开心',
                  onChanged: (newValue) {
                    setState(() {
                      _moodSliderValue = newValue;
                    });
                  },
                ),
              ),

              // Question 4 - Feelings Checkbox

              _buildQuestionCard(
                '4.你在进食中感受到了什么',
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
                    TextField(
                      controller: _otherFeelingsController,
                      decoration: InputDecoration(
                        hintText: '更多（自定义）',
                        border: OutlineInputBorder(),
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
                '7. 你是否有清除食物的行为 ?',
                '清除食物指的是催吐，服用泻药，服用利尿剂，服用减少消化吸收的其他药品以及其他相似的行为',
                child: Column(
                  children: [
                    RadioListTile<bool>(
                      title: Text('是'),
                      value: true,
                      groupValue: _hasPurgingBehavior,
                      onChanged: (bool? value) {
                        setState(() {
                          _hasPurgingBehavior = value!;
                        });
                      },
                    ),
                    RadioListTile<bool>(
                      title: Text('否'),
                      value: false,
                      groupValue: _hasPurgingBehavior,
                      onChanged: (bool? value) {
                        setState(() {
                          _hasPurgingBehavior = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),

              _buildQuestionCard(
                '8. 你是如何清除的？',
                '请选择你使用过的方法。',
                child: Column(
                  children: [
                    ..._purgingMethods.keys.map((String method) {
                      return CheckboxListTile(
                        title: Text(method),
                        value: _purgingMethods[method],
                        onChanged: (bool? value) {
                          setState(() {
                            _purgingMethods[method] = value!;
                          });
                        },
                      );
                    }).toList(),
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
                '还有什么其他想法?',
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
