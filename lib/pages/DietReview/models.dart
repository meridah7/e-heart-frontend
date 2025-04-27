class ReviewModel {
  final List<String> content;
  final int timestamp;
  final int index;

  ReviewModel(
      {required this.content, required this.timestamp, required this.index});

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
        content: map['content'].cast<String>(),
        timestamp: map['timestamp'],
        index: map['index']);
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'timestamp': timestamp,
      'index': index,
    };
  }
}

extension ReviewModelExtensions on ReviewModel {
  // Format timestamp to readable date string
  String get formattedDate {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${date.year}年${date.month}月${date.day}日 ${date.hour}:${date.minute}';
  }
  
  // Get a specific content entry by index
  String? getContentAt(int index) {
    if (index >= 0 && index < content.length) {
      return content[index];
    }
    return null;
  }
  
  // Parse content into Q&A pairs
  List<Map<String, String>> getQAPairs() {
    final List<Map<String, String>> qaPairs = [];
    for (int i = 0; i < content.length - 1; i += 2) {
      qaPairs.add({
        'question': content[i],
        'answer': content[i + 1].replaceFirst('Answer:', ''),
      });
    }
    return qaPairs;
  }
  
  // Create a copy with updated content
  ReviewModel copyWith({
    List<String>? content,
    int? timestamp,
    int? index,
  }) {
    return ReviewModel(
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      index: index ?? this.index,
    );
  }
}
