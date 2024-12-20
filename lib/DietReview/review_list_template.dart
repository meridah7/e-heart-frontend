import 'package:flutter/material.dart';

class SimpleListPage<T> extends StatelessWidget {
  final String title; // 页面标题
  final List<T> items; // 数据列表
  final String Function(T) itemTextBuilder; // 用于提取每项的展示文本

  const SimpleListPage({
    Key? key,
    required this.title,
    required this.items,
    required this.itemTextBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(itemTextBuilder(item)),
          );
        },
      ),
    );
  }
}
