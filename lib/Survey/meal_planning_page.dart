import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/utils/dio_client.dart';
import 'package:dio/dio.dart';

class MealPlanningPage extends StatefulWidget {
  final String taskId;
  final Function? handleSubmit;

  MealPlanningPage({required this.taskId, this.handleSubmit});

  @override
  _MealPlanningPageState createState() => _MealPlanningPageState();
}

class _MealPlanningPageState extends State<MealPlanningPage> {
  @override
  void initState() {
    super.initState();
    _initWidget();
  }

  Future<void> _initWidget() async {
    try {
      // Response<dynamic> currentPlans =
      //     await dioClient.getRequest('/meal_plans/get-all');
      // TODO: add currentPlans to cards
    } catch (e) {
      print('get all meal_plans err: $e');
    }
  }

  final DioClient dioClient = DioClient();

  List<Map<String, String>> cards = []; // List to store card data

  String? mealName;
  String? food;
  TextEditingController _timeController = TextEditingController();

  String getMealPlanningDate(String formatType) {
    DateTime now = DateTime.now();
    if (now.hour >= 12) {
      return DateFormat(formatType).format(now.add(Duration(days: 1)));
    } else {
      return DateFormat(formatType).format(now);
    }
  }

  void _addCard() {
    _timeController.clear(); // Clear the controller before showing the dialog
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
                  controller: _timeController,
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
                        _timeController.text =
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
                          _timeController.text.isNotEmpty &&
                          food != null) {
                        setState(() {
                          cards.add({
                            'mealName': mealName!,
                            'mealTime': _timeController.text,
                            'food': food!,
                          });
                        });

                        String planningDate = getMealPlanningDate('yyyy-MM-dd');

                        try {
                          // TODO: check interface response
                          await dioClient.postRequest('/meal_plans', {
                            "type": mealName,
                            "food_details": food,
                            "time": "${_timeController.text}:00",
                            "date":
                                DateFormat('yyyy-MM-dd').format(DateTime.now()),
                            "target_date": planningDate
                          });
                        } catch (e) {
                          print('request meal_plans err: $e');
                        }

                        mealName = null;
                        food = null;
                        _timeController.clear();
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

  void _removeCard(int index) {
    setState(() async {
      // TODO: ask background for remove here
      // try {
      //   await dioClient.deleteRequest('/meal_plans/$PLAN_ID');
      // } catch (e) {
      //   print('delete meal_plans err: $e');
      // }
      cards.removeAt(index);
    });
  }

  void _showHelpDialog() {
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
                  '制定饮食计划的核心原则：',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '每餐的间隔应该在3-4小时之间！',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('关闭', style: TextStyle(color: Colors.blue)),
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
            onPressed: _showHelpDialog,
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
                                    card['mealName'] ?? '餐次',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _removeCard(index),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                '计划吃的时间： ${card['mealTime'] ?? ''}',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '食物： ${card['food'] ?? ''}',
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
        onPressed: _addCard,
        backgroundColor: Color.fromARGB(255, 213, 114, 113),
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
