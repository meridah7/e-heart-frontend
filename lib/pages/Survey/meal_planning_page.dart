import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/providers/progress.dart';
import 'package:namer_app/services/dio_client.dart';
import 'package:dio/dio.dart';

class MealPlanningPage extends ConsumerStatefulWidget {
  final String taskId;
  final Function? handleSubmit;

  MealPlanningPage({required this.taskId, this.handleSubmit});

  @override
  _MealPlanningPageState createState() => _MealPlanningPageState();
}

class _MealPlanningPageState extends ConsumerState<MealPlanningPage> {
  @override
  void initState() {
    super.initState();
    _initWidget();
  }

  final DioClient dioClient = DioClient();

  List<Map> cards = []; // List to store card data

  Future<void> _initWidget() async {
    getAllMealPlans();
  }

  DateTime getTargetDateTime(Map<String, dynamic> item) {
    // Convert the `target_date` (timestamp in milliseconds) to DateTime
    DateTime targetDate =
        DateTime.fromMillisecondsSinceEpoch(item['target_date']);
    // Parse the `time` string and apply it to the `target_date`
    List<String> timeParts = (item['time'] as String).split(':');
    return DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
      int.parse(timeParts[0]), // hours
      int.parse(timeParts[1]), // minutes
      int.parse(timeParts[2]), // seconds
    );
  }

  Map<String, int> getMealPlanDate() {
    final now = DateTime.now();
    int startTime = now.hour > 12
        ? DateTime(now.year, now.month, now.day + 1).millisecondsSinceEpoch
        : DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    int endTime = now.hour > 12
        ? DateTime(now.year, now.month, now.day + 1, 23, 59, 59, 999)
            .millisecondsSinceEpoch
        : DateTime(now.year, now.month, now.day, 23, 59, 59, 999)
            .millisecondsSinceEpoch;
    return {
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  // 获取今天的每日饮食计划
  getAllMealPlans() async {
    try {
      var {'startTime': startTime, 'endTime': endTime} = getMealPlanDate();
      Response response =
          await dioClient.getRequest('/meal_plans/$startTime/$endTime');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        // 根据目标饮食时间先后来排序
        data.sort((a, b) {
          return getTargetDateTime(a).compareTo(getTargetDateTime(b));
        });
        print('data $data');
        setState(() {
          cards = [...data];
        });
      }
    } catch (e) {
      print('get all meal_plans err: $e');
    }
  }

  String? mealName;
  String? food;
  TextEditingController timeController = TextEditingController();

  String getMealPlanningDate(String formatType) {
    DateTime now = DateTime.now();
    if (now.hour >= 12) {
      return DateFormat(formatType).format(now.add(Duration(days: 1)));
    } else {
      return DateFormat(formatType).format(now);
    }
  }

  void addCard() {
    timeController.clear(); // Clear the controller before showing the dialog
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '新增一餐',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '餐次名称',
                    hintText: '例如：早餐、午餐',
                  ),
                  onChanged: (value) {
                    mealName = value;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: timeController,
                  decoration: InputDecoration(
                    labelText: '计划吃的时间',
                    hintText: '填写时间',
                    suffixIcon: Icon(Icons.access_time),
                  ),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        final DateTime now = DateTime.now();
                        final DateTime dateTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                        final String formattedTime =
                            DateFormat('HH:mm').format(dateTime);
                        timeController.text =
                            formattedTime; // Update the controller
                      });
                    }
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '食物',
                    hintText: '填写食物',
                  ),
                  onChanged: (value) {
                    food = value;
                  },
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (mealName != null &&
                          timeController.text.isNotEmpty &&
                          food != null) {
                        // 改动：用户在中午12点前提交的计划为当天的计划，12点后是明天的计划
                        try {
                          var {'startTime': startTime} = getMealPlanDate();

                          Response res = await dioClient
                              .postRequest('/meal_plans/create', {
                            "type": mealName,
                            "food_details": food,
                            "time": "${timeController.text}:00",
                            "date": DateTime.now().millisecondsSinceEpoch,
                            // 12点后日期➕1
                            "target_date": startTime
                          });
                          if (res.statusCode == 200 || res.statusCode == 201) {
                            ref
                                .read(progressProvider.notifier)
                                .updateProgress(widget.taskId);
                          }
                          await getAllMealPlans();
                        } catch (e) {
                          print('request meal_plans err: $e');
                        }

                        mealName = null;
                        food = null;
                        timeController.clear();
                        Navigator.of(context).pop();
                      } else {
                        // Show a snack bar if some fields are missing
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('请填写所有必填字段'),
                          ),
                        );
                      }
                    },
                    child: Text('确认'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void removeCard(int id) async {
    try {
      await dioClient.deleteRequest('/meal_plans/$id');
      await getAllMealPlans();
    } catch (e) {
      print('delete meal_plans err: $e');
    }
  }

  void showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '每日饮食计划帮助',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '请在这里制定下一次的计划，记得一定要计划5-6餐哦。',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('关闭'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String planningDate = getMealPlanningDate('yyyy年MM月dd日');

    return Scaffold(
      backgroundColor: Color(0xfffaeef0), // Custom background color
      appBar: AppBar(
        title: Text(
          '每日饮食计划',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor:
            Color(0xfef8dede), // Slightly darker shade for contrast
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: showHelpDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Light and Positive Date Section with Subtle Shadow
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Color.fromARGB(
                  255, 242, 225, 228), // Light blue with positive energy
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '当前做的是：',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                SizedBox(height: 4),
                Text(
                  '$planningDate的饮食计划',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
          // List of Cards Section
          Expanded(
            child: cards.isEmpty
                ? Center(
                    child: Text(
                      '点击底部的 + 按钮开始添加你的饮食计划！',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      return Card(
                        color: Color(0xffffffff),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    card['type'] ?? '餐次',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => removeCard(card['id']),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                '计划吃的时间： ${card['time'] ?? ''}',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '食物： ${card['food_details'] ?? ''}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addCard,
        backgroundColor: Color.fromARGB(255, 213, 114, 113),
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
