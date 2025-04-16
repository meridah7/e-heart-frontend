/// 用于冲动记录反思问卷上方的历史总结回顾
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:namer_app/services/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'utils.dart';
import 'chart_widgets.dart';

class ImpulsiveRecordAndReflectionSummary extends StatefulWidget {
  @override
  _ImpulsiveRecordAndReflectionSummary createState() =>
      _ImpulsiveRecordAndReflectionSummary();
}

class _ImpulsiveRecordAndReflectionSummary
    extends State<ImpulsiveRecordAndReflectionSummary> {
  // FIXME: 轮播指示器
  // int _currentPage = 0;
  // int _currentChartPage = 0;
  bool _isShowCharts = true;
  final DioClient dioClient = DioClient();

  @override
  void initState() {
    super.initState();
    // loadRecords();
  }

  Future<List<Map<String, dynamic>>> fetchImpulseData() async {
    try {
      Response response =
          await dioClient.getRequest('/impulse/impulse-reflection-records/');
      if (response.statusCode == 200) {
        // 强制转换为 List<Map<String, dynamic>>
        List<Map<String, dynamic>> parsedData =
            List<Map<String, dynamic>>.from(response.data);

        return parsedData;
      }
    } catch (e) {
      print('Error in impulse review $e');
    }
    return [];
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.all(10.0),
  //     padding: EdgeInsets.all(4.0),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       border: Border.all(color: Colors.black12),
  //       borderRadius: BorderRadius.circular(8.0),
  //     ),
  //     child: Column(
  //       children: [
  //         // Tabs
  //         Row(
  //           children: [
  //             Expanded(
  //               child: GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     _isShowCharts = true;
  //                   });
  //                 },
  //                 child: Container(
  //                   padding: EdgeInsets.all(8),
  //                   decoration: BoxDecoration(
  //                     border: Border(
  //                       bottom: BorderSide(
  //                           width: 2,
  //                           color: _isShowCharts
  //                               ? Colors.black
  //                               : Colors.transparent),
  //                     ),
  //                   ),
  //                   child: Center(
  //                     child: Text(
  //                       '冲动总体分析',
  //                       style: TextStyle(
  //                           fontSize: 16,
  //                           fontWeight: _isShowCharts
  //                               ? FontWeight.bold
  //                               : FontWeight.normal,
  //                           color: _isShowCharts ? Colors.black : Colors.grey),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               width: 1, // Separator width
  //               color: Colors.grey[300], // Light grey color
  //               height: 20, // Height of the separator
  //             ),
  //             Expanded(
  //               child: GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     _isShowCharts = false;
  //                   });
  //                 },
  //                 child: Container(
  //                   padding: EdgeInsets.all(8),
  //                   decoration: BoxDecoration(
  //                     border: Border(
  //                       bottom: BorderSide(
  //                         width: 2,
  //                         color:
  //                             _isShowCharts ? Colors.transparent : Colors.black,
  //                       ),
  //                     ),
  //                   ),
  //                   child: Center(
  //                     child: Text(
  //                       '冲动记录回顾',
  //                       style: TextStyle(
  //                           fontSize: 16,
  //                           fontWeight: _isShowCharts
  //                               ? FontWeight.normal
  //                               : FontWeight.bold),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         // Content area
  //         Expanded(
  //           child: _isShowCharts ? _buildChartContent() : _buildTextContent(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildChartContent(
      List<Map<String, dynamic>> processedImpulseTypeData,
      List<Map<String, dynamic>> processedDayOfWeekData,
      List<Map<String, dynamic>> processedTimeOfDayData,
      List<Map<String, dynamic>> processedIntensityWeekData,
      List<Map<String, dynamic>> processedIntensityDayData) {
    List<Widget> charts = [
      ImpulseTypePieChart(data: processedImpulseTypeData),
      DayOfWeekBarChart(data: processedDayOfWeekData),
      TimeOfDayBarChart(data: processedTimeOfDayData),
      DayOfWeekBarChart(data: processedIntensityWeekData),
      TimeOfDayBarChart(data: processedIntensityDayData),
    ];

    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            items: charts,
            options: CarouselOptions(
              height: 320.0,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
              // onPageChanged: (index, reason) {
              //   setState(() {
              //     _currentChartPage = index;
              //   });
              // },
              enableInfiniteScroll: true,
              autoPlay: false,
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 10.0),
        //   child: CarouselIndicator(
        //     count: charts.length,
        //     index: _currentChartPage,
        //     color: Colors.grey,
        //     activeColor: Colors.black,
        //     width: 8,
        //     height: 8,
        //   ),
        // ),
      ],
    );
  }

  Widget _buildTextContent(List<dynamic> impulseRecordList) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider.builder(
            itemCount: impulseRecordList.length,
            itemBuilder: (context, index, realIndex) {
              final entry = impulseRecordList[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('冲动种类：${entry['impulse_type']}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(
                        '时间：${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(entry['timestamp']))}'),
                    SizedBox(height: 8),
                    Text('应对策略：${entry['plan']}'),
                    SizedBox(height: 8),
                    Text('冲动强度：${entry['intensity']}'),
                    SizedBox(height: 8),
                    Text('应对回顾：${entry['impulse_response_experience'] ?? ''}'),
                    SizedBox(height: 8),
                    Text('诱因：${entry['trigger']}'),
                  ],
                ),
              );
            },
            options: CarouselOptions(
              height: double.infinity,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
              // onPageChanged: (index, reason) {
              //   setState(() {
              //     _currentPage = index;
              //   });
              // },
              enableInfiniteScroll: true,
              autoPlay: false,
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 5.0),
        //   child: CarouselIndicator(
        //     count: impulseRecordList.length,
        //     index: _currentPage,
        //     color: Colors.grey,
        //     activeColor: Colors.black,
        //     width: 8,
        //     height: 8,
        //   ),
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchImpulseData(), // 调用异步获取数据的方法
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 加载时显示进度指示器
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // 错误处理
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // 如果没有数据，显示提示
          return Center(child: Text('没有记录'));
        }
        final List<dynamic> impulseRecordList = snapshot.data!;
        // 数据处理
        final processedImpulseTypeData = processImpulseTypeData(snapshot.data!);
        final processedDayOfWeekData = processDayOfWeekData(snapshot.data!);
        final processedTimeOfDayData = processTimeOfDayData(snapshot.data!);
        final processedIntensityWeekData =
            processIntensityWeekData(snapshot.data!);
        final processedIntensityDayData =
            processIntensityDayData(snapshot.data!);

        return Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              // Tabs
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isShowCharts = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 2,
                                color: _isShowCharts
                                    ? Colors.black
                                    : Colors.transparent),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '冲动总体分析',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: _isShowCharts
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color:
                                    _isShowCharts ? Colors.black : Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1, // Separator width
                    color: Colors.grey[300], // Light grey color
                    height: 20, // Height of the separator
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isShowCharts = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 2,
                              color: _isShowCharts
                                  ? Colors.transparent
                                  : Colors.black,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '冲动记录回顾',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: _isShowCharts
                                    ? FontWeight.normal
                                    : FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Content area
              Expanded(
                child: _isShowCharts
                    ? _buildChartContent(
                        processedImpulseTypeData,
                        processedDayOfWeekData,
                        processedTimeOfDayData,
                        processedIntensityWeekData,
                        processedIntensityDayData)
                    : _buildTextContent(impulseRecordList), // 假设您有一个方法用于显示记录回顾
              ),
            ],
          ),
        );
      },
    );
  }
}
