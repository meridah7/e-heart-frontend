//定义了与聊天消息、聊天内容和用户回应相关的class

import 'package:flutter/material.dart';

//ChatMessage 用于表示单个消息，可以是来自于用户的，也可以是来自机器人的
class ChatMessage {
  String text;
  final bool isUser;
  final String? imageUrl;
  final VoidCallback? onComplete;

  ChatMessage(
      {this.text = "", required this.isUser, this.imageUrl, this.onComplete});
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

  Content(
      {this.text,
      this.imageUrl,
      this.choices,
      required this.type,
      this.responseType = ResponseType.NONE,
      this.id});

  void setShowChoices(bool bool) {}
}

extension ContentExtensions on Content {
  // Convenience method to check if this content has choices
  bool get hasChoices => choices != null && choices!.isNotEmpty;
  
  // Check if this content has a valid text
  bool get hasText => text != null && text!.isNotEmpty;
  
  // Check if a specific choice is selected
  bool isChoiceSelected(String choice) => 
      selectedChoices?.contains(choice) ?? false;
      
  // Safely add a choice to selectedChoices
  void selectChoice(String choice) {
    selectedChoices ??= [];
    if (choices?.contains(choice) ?? false) {
      if (!selectedChoices!.contains(choice)) {
        selectedChoices!.add(choice);
      }
    }
  }
  
  // Clear selections
  void clearSelections() {
    selectedChoices = [];
  }
}

extension ChatMessageFormatter on ChatMessage {
  // Format chat message for display
  String get formattedText {
    if (text.isEmpty) return '';
    
    // You could add custom formatting logic here
    // For example, handle markdown, emojis, etc.
    return text;
  }
  
  // Create a copy with updated text
  ChatMessage copyWithText(String newText) {
    return ChatMessage(
      text: newText, 
      isUser: isUser,
      imageUrl: imageUrl,
      onComplete: onComplete
    );
  }
}
