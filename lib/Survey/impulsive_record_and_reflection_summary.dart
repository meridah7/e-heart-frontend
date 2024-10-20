/// 用于冲动记录反思问卷上方的历史总结回顾
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:namer_app/utils/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class ImpulsiveRecordAndReflectionSummary extends StatefulWidget {
  @override
  _ImpulsiveRecordAndReflectionSummary createState() =>
      _ImpulsiveRecordAndReflectionSummary();
}

class _ImpulsiveRecordAndReflectionSummary
    extends State<ImpulsiveRecordAndReflectionSummary> {
  int _currentPage = 0;
  bool _isShowCharts = false;
  final DioClient dioClient = DioClient();
  List<dynamic> _impulseRecordList = [];
  bool _isLoadingRecord = true;

  // TODO: replace this to the new data with chart data
  final List<Widget> _charts = [
    Center(child: Text('Chart 1 Placeholder')),
    Center(child: Text('Chart 2 Placeholder')),
    Center(child: Text('Chart 3 Placeholder')),
  ];

  @override
  void initState() {
    super.initState();
    loadRecords();
  }

  Future<void> loadRecords() async {
    // Future<void> loadRecords() async {
    try {
      Response response =
          await dioClient.getRequest('/impulse/impulse-reflection-records/');
      setState(() {
        _impulseRecordList = response.data;
        _isLoadingRecord = false;
      });
    } catch (e) {
      print('Error in impulse review $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            color: _isShowCharts ? Colors.black : Colors.grey),
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
                          color:
                              _isShowCharts ? Colors.transparent : Colors.black,
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
            child: _isShowCharts ? _buildChartContent() : _buildTextContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildChartContent() {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            items: _charts,
            options: CarouselOptions(
              height: double.infinity,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              },
              enableInfiniteScroll: true,
              autoPlay: false,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: CarouselIndicator(
            count: _charts.length,
            index: _currentPage,
            color: Colors.grey,
            activeColor: Colors.black,
            width: 8,
            height: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildTextContent() {
    return _isLoadingRecord
        ? Center(child: CircularProgressIndicator()) // 加载时显示进度指示器
        : _impulseRecordList.isEmpty
            ? Center(child: Text('没有记录')) // 如果列表为空显示提示
            : Column(
                children: [
                  Expanded(
                    child: CarouselSlider.builder(
                      itemCount: _impulseRecordList.length,
                      itemBuilder: (context, index, realIndex) {
                        final entry = _impulseRecordList[index];
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('冲动种类：${entry['impulse_type']}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              Text(
                                  '时间：${DateFormat('yyyy-mm-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(entry['timestamp']))}'),
                              SizedBox(height: 8),
                              Text('应对策略：${entry['plan']}'),
                              SizedBox(height: 8),
                              Text('冲动强度：${entry['intensity']}'),
                              SizedBox(height: 8),
                              Text(
                                  '应对回顾：${entry['impulse_response_experience'] ?? ''}'),
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
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        enableInfiniteScroll: true,
                        autoPlay: false,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: CarouselIndicator(
                      count: _impulseRecordList.length,
                      index: _currentPage,
                      color: Colors.grey,
                      activeColor: Colors.black,
                      width: 8,
                      height: 8,
                    ),
                  ),
                ],
              );
  }
}
