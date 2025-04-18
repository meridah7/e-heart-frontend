import 'package:flutter/material.dart';

class ReviewTemplatePage extends StatelessWidget {
  final List<String> qaContent;
  final String title;
  final String subTitle;

  /// 构造函数，接受 Q&A 数据列表
  const ReviewTemplatePage(
      {Key? key,
      required this.qaContent,
      required this.title,
      required this.subTitle})
      : super(key: key);

  /// 转换函数：将连续的 List<String> 转换为 [{question: xxx, answer: xxx}]
  List<Map<String, String>> _generateQAPairs(List<String> qaList) {
    final List<Map<String, String>> qaPairs = [];
    for (int i = 0; i < qaList.length - 1; i += 2) {
      qaPairs.add({
        'question': qaList[i],
        'answer': qaList[i + 1].replaceFirst('Answer:', ''),
      });
    }
    return qaPairs;
  }

  @override
  Widget build(BuildContext context) {
    // 转换成 [{question: xxx, answer: xxx}] 格式
    final List<Map<String, String>> qaPairs = _generateQAPairs(qaContent);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(children: [
        Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.white,
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
            itemCount: qaPairs.length,
            itemBuilder: (context, index) {
              final item = qaPairs[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: Colors.white,
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
