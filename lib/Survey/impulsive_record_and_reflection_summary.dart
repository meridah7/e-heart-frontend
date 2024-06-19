/// 用于冲动记录反思问卷上方的历史总结回顾
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_indicator/carousel_indicator.dart';

class ImpulsiveRecordAndReflectionSummary extends StatefulWidget {
  @override
  _ImpulsiveRecordAndReflectionSummary createState() =>
      _ImpulsiveRecordAndReflectionSummary();
}

class _ImpulsiveRecordAndReflectionSummary
    extends State<ImpulsiveRecordAndReflectionSummary> {
  int _currentPage = 0;
  bool _isShowCharts = false;

  // TODO: replace this to the new data
  final List<Widget> _charts = [
    Center(child: Text('Chart 1 Placeholder')),
    Center(child: Text('Chart 2 Placeholder')),
    Center(child: Text('Chart 3 Placeholder')),
  ];

  // TODO: replace this to the new data
  final List<Map<String, String>> _textEntries = [
    {
      'type': '食物清除',
      'time': '2024-5-5 19:02:48',
      'strategy': '准备跟爸妈去打羽毛球；冲动冲浪10分钟',
      'intensity': '7',
      'review': '通过这次我发现了 ***********************',
      'reason': '这次冲动是因为最近压力太大了'
    },
    {
      'type': '购物冲动',
      'time': '2024-6-10 14:23:12',
      'strategy': '和朋友一起去逛街，避免独自购物',
      'intensity': '6',
      'review': '发现冲动购物可以通过计划性购物来减少',
      'reason': '看到大减价的广告'
    },
    {
      'type': '社交冲动',
      'time': '2024-7-20 16:45:32',
      'strategy': '参加了一个社交活动，尝试控制社交频率',
      'intensity': '5',
      'review': '学会了如何拒绝不必要的社交邀约',
      'reason': '最近缺少社交活动'
    }
  ];

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
    return Column(
      children: [
        Expanded(
          child: CarouselSlider.builder(
            itemCount: _textEntries.length,
            itemBuilder: (context, index, realIndex) {
              final entry = _textEntries[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('冲动种类：${entry['type']}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('时间：${entry['time']}'),
                    SizedBox(height: 8),
                    Text('应对策略：${entry['strategy']}'),
                    SizedBox(height: 8),
                    Text('冲动强度：${entry['intensity']}'),
                    SizedBox(height: 8),
                    Text('应对回顾：${entry['review']}'),
                    SizedBox(height: 8),
                    Text('诱因：${entry['reason']}'),
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
            count: _textEntries.length,
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
