class ReviewModel {
  final List<String> content;
  final int timestamp;

  ReviewModel({
    required this.content,
    required this.timestamp,
  });

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      content: map['content'].cast<String>(),
      timestamp: map['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'timestamp': timestamp,
    };
  }
}
