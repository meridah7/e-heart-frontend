
//定义了与聊天消息、聊天内容和用户回应相关的class

import 'package:flutter/material.dart';

//ChatMessage 用于表示单个消息，可以是来自于用户的，也可以是来自机器人的
class ChatMessage {
  String text;
  final bool isUser;
  final String? imageUrl;
  final VoidCallback? onComplete;

  ChatMessage({this.text = "", required this.isUser, this.imageUrl, this.onComplete});
}

enum ContentType { TEXT, IMAGE, USER_INPUT }
enum ResponseType { auto, choices, userInput, multiChoices, NONE }


// Content 用于表示机器人预设的问题内容，可指定用户回复的类型
class Content {
  final String? text;
  final String? imageUrl;
  final List<String>? choices;
  final ContentType type;
  final ResponseType responseType;
  final String? id;
  List<String>? selectedChoices = [];

  Content({
    this.text, 
    this.imageUrl, 
    this.choices, 
    required this.type, 
    this.responseType = ResponseType.NONE,
    this.id
  });

  void setShowChoices(bool bool) {}
}

// UserResponse 用于表示用户对聊天内容的回应，包括用户输入的文本和选择的选项。
class UserResponse {
  final String? contentId;  // 当前内容的id
  final String userResponse;  // 用户的回应

  UserResponse({
    this.contentId,
    required this.userResponse,
  });

  @override
  String toString() {
    return 'Content ID: $contentId, User Response: $userResponse';
  }
}







