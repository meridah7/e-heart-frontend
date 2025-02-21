import 'package:flutter/material.dart';

class PracticeListPage extends StatefulWidget {
  @override
  State<PracticeListPage> createState() => _PracticeListPageState();
}

class _PracticeListPageState extends State<PracticeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '选修练习',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme:
            IconThemeData(color: Colors.black), // Change back button color
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        children: [
          _buildPracticeItem('冲动诱因教学'),
          _buildPracticeItem('为什么我无法停止暴食？'),
          _buildPracticeItem('清除食物大百科'),
          _buildPracticeItem('这是其他的选修练习'),
          _buildCompletedPracticeItem('这是已完成的选修练习'),
        ],
      ),
    );
  }

  Widget _buildPracticeItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
          trailing: Icon(Icons.check_box_outline_blank, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildCompletedPracticeItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
          trailing: Icon(Icons.check_box, color: Colors.grey),
        ),
      ),
    );
  }
}
