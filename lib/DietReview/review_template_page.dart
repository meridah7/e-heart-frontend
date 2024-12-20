import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReviewTemplatePage extends StatelessWidget {
  final List<Map<String, String>> qaContent;
  final String title;
  final String subTitle;

  /// 构造函数，接受 Q&A 数据列表
  const ReviewTemplatePage(
      {Key? key,
      required this.qaContent,
      required this.title,
      required this.subTitle})
      : super(key: key);

  ///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(children: [
        Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '标题名称:',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: const TextStyle(fontSize: 14),
                    )
                  ]),
            )),
        Expanded(
          child: ListView.builder(
            itemCount: qaContent.length,
            itemBuilder: (context, index) {
              final item = qaContent[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Q: ${item['question'] ?? 'No question provided'}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'A: ${item['answer'] ?? 'No answer provided'}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
