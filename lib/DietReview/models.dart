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
