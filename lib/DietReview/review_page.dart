import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/Login/user_model.dart';
import 'package:namer_app/user_preference.dart';
import 'package:provider/provider.dart';
import './review_template_page.dart';
import './models.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({required this.surveyKey, required this.reviewTitle});

  final String reviewTitle;
  final String surveyKey;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<ReviewModel> dietLogs = [];

  late Preferences _userPref;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  // FIXME: 清除缓存 仅调试使用
  Future<void> clearCache() async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '清空当前记录（无法撤销）',
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _clearCache();
                          },
                          child: Text('确定')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('取消')),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _clearCache() async {
    Map<String, dynamic> data = _userPref.getData(COMPLETED_SURVEY_KEY);
    data.remove(widget.surveyKey);
    await _userPref.setData(COMPLETED_SURVEY_KEY, data);
    await _loadDiet();
  }

  Future<void> _initializePreferences() async {
    if (mounted) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      _userPref = await Preferences.getInstance(namespace: userProvider.uuid);
      await _loadDiet();
    }
  }

  Future<void> _loadDiet() async {
    try {
      var dietData = await _userPref.readSurveyData(widget.surveyKey);
      print('load diet: $dietData');
      setState(() {
        dietLogs = (dietData).map((item) => ReviewModel.fromMap(item)).toList();
        dietLogs.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        print(dietLogs);
      });
      // return;
    } catch (e) {
      print('Error in load diet $e');
      throw Exception(e);
    }
  }

  Widget _buildDietTail(
    ReviewModel diet,
    int index,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReviewTemplatePage(
                qaContent: diet.content,
                title: widget.reviewTitle,
                subTitle: '第${index + 1}次${widget.reviewTitle}',
              ),
            ));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        elevation: 1, // 阴影高度
        // color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // 圆角边框
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('第${index + 1}次${widget.reviewTitle}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat('yyyy-MM-dd HH:mm').format(
                      DateTime.fromMillisecondsSinceEpoch(diet.timestamp))),
                  Icon(Icons.arrow_forward_ios_outlined)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDietListView(List<ReviewModel> diets, {bool shrinkWrap = true}) {
    return ListView.builder(
        shrinkWrap: shrinkWrap, // 根据内容自适应高度
        physics: NeverScrollableScrollPhysics(), // 禁用列表自身的滚动
        itemCount: diets.length,
        itemBuilder: (context, index) {
          final diet = diets[index];
          return _buildDietTail(diet, index);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.reviewTitle),
          actions: [
            IconButton(onPressed: clearCache, icon: Icon(Icons.clear_all))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: _buildDietListView(dietLogs),
          ),
        ));
  }
}
