import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/Login/user_model.dart';
import 'package:namer_app/user_preference.dart';
import 'package:namer_app/utils/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:namer_app/DailyDiet/diet_models.dart';
import 'package:provider/provider.dart';
import './review_template_page.dart';

class DietReviewPage extends StatefulWidget {
  const DietReviewPage({super.key});

  @override
  State<DietReviewPage> createState() => _DietReviewPageState();
}

class _DietReviewPageState extends State<DietReviewPage> {
  List<Diet> dietLogs = [];
  DioClient dioClient = DioClient();
  late Preferences _userPref;

  Future<void> _initializePreferences() async {
    if (mounted) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      _userPref = await Preferences.getInstance(namespace: userProvider.uuid);
      await _loadDiet();
    }
  }

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _loadDiet() async {
    try {
      await _userPref.readSurveyData();
      print('load diet');
      // return;
    } catch (e) {
      print('Error in load diet $e');
      throw Exception(e);
    }
  }
  // Future<void> _loadDiet() async {
  //   try {
  //     Response response = await dioClient.getRequest('/diet_logs/');
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         dietLogs = (response.data['data'] as List)
  //             .map((item) => Diet.fromJson(item))
  //             .toList();
  //         dietLogs.sort((a, b) => b.id.compareTo(a.id));
  //         print(dietLogs);
  //       });
  //     }
  //   } catch (e) {
  //     print('Error in load diet $e');
  //     throw Exception(e);
  //   }
  // }

  Widget _buildDietTail(
    Diet diet,
  ) {
    return InkWell(
      onTap: () {
        print('tap');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReviewTemplatePage(
                qaContent: [
                  {
                    'question': '进食具体时间',
                    'answer': DateFormat('yyyy年MM月dd日 HH:MM:ss').format(
                        DateTime.fromMillisecondsSinceEpoch(diet.eatingTime)),
                  },
                  {
                    'question': '吃了什么&吃了多少？',
                    'answer': diet.foodDetails,
                  },
                  {
                    'question': '属于哪一餐？',
                    'answer': diet.mealType?.displayName ?? '其他',
                  },
                  {
                    'question': '进食的时候感受到的情绪强度',
                    'answer': diet.emotionIntensity.toString(),
                  },
                  {
                    'question': '是否暴食',
                    'answer': diet.isBingeEating != null && diet.isBingeEating!
                        ? '是'
                        : '否',
                  },
                ],
                title: '饮食日志',
                subTitle: '第${diet.id}次饮食日志',
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
              Text('第${diet.id}次饮食日志'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat('yyyy年MM月dd日').format(
                      DateTime.fromMillisecondsSinceEpoch(diet.eatingTime))),
                  Icon(Icons.arrow_forward_ios_outlined)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDietListView(List<Diet> diets, {bool shrinkWrap = true}) {
    return ListView.builder(
        shrinkWrap: shrinkWrap, // 根据内容自适应高度
        physics: NeverScrollableScrollPhysics(), // 禁用列表自身的滚动
        itemCount: diets.length,
        itemBuilder: (context, index) {
          final diet = diets[index];
          return _buildDietTail(diet);
        });
  }

  @override
  Widget build(BuildContext context) {
    // return SimpleListPage(title: '饮食日志--分析反思', items: [], itemTextBuilder: itemTextBuilder)
    return Scaffold(
        appBar: AppBar(
          title: Text('饮食日志'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: _buildDietListView(dietLogs),
          ),
        ));
  }
}
