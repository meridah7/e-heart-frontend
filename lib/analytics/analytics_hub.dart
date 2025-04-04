import 'package:flutter/material.dart';
import 'package:namer_app/analytics/diet_analytics.dart';
import 'package:namer_app/analytics/impulse_analytics.dart';
import 'package:namer_app/analytics/progress_analytics.dart';
import 'package:namer_app/widgets/network_status_bar.dart';

class AnalyticsHub extends StatefulWidget {
  @override
  _AnalyticsHubState createState() => _AnalyticsHubState();
}

class _AnalyticsHubState extends State<AnalyticsHub> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('数据分析中心', style: TextStyle(color: Colors.black)),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: '饮食分析', icon: Icon(Icons.restaurant)),
            Tab(text: '冲动分析', icon: Icon(Icons.psychology)),
            Tab(text: '进度洞察', icon: Icon(Icons.insights)),
          ],
        ),
      ),
      body: Column(
        children: [
          NetworkStatusBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                DietAnalytics(),
                ImpulseAnalytics(),
                ProgressAnalytics(),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 