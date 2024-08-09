// 定义了两个自定义的StatefulWidget类：TypeWriterText和Bubble。
// Bubble是一个自定义的聊天气泡小部件，用于在聊天应用中显示聊天消息。
// 在Bubble部件的build方法中，它可以选择包含一个TypeWriterText小部件，用于逐字显示文本消息。

import 'package:flutter/material.dart';

// TypeWriterText 用于实现文本逐字显示的效果
class TypeWriterText extends StatefulWidget {
  final String text;
  final Duration duration;
  final TextStyle? style;
  final VoidCallback? onComplete;
  final VoidCallback? onChanged;

  TypeWriterText(this.text,
      {this.style,
      this.duration = const Duration(milliseconds: 50),
      this.onChanged,
      this.onComplete});

  @override
  _TypeWriterTextState createState() => _TypeWriterTextState();
}

class _TypeWriterTextState extends State<TypeWriterText> {
  String _displayedString = '';
  int _currentCharIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.duration, _displayNextCharacter);
  }

  void _displayNextCharacter() {
    if (_currentCharIndex < widget.text.length) {
      setState(() {
        _displayedString += widget.text[_currentCharIndex];
        _currentCharIndex++;
      });
      if (widget.onChanged != null) {
        widget.onChanged!();
      }
      Future.delayed(widget.duration, _displayNextCharacter);
    } else {
      if (widget.onComplete != null) {
        widget.onComplete!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedString,
      style: widget.style ??
          TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
    );
  }
}

// Bubble 用于创建气泡式的聊天框
class Bubble extends StatefulWidget {
  final String? text;
  final String? imageUrl;
  final bool isUser;
  final bool shouldUseTyperEffect;
  final VoidCallback onComplete;
  final VoidCallback onChanged;

  Bubble({
    this.text,
    this.imageUrl,
    required this.isUser,
    required this.shouldUseTyperEffect,
    required this.onComplete,
    required this.onChanged,
  });

  @override
  _BubbleState createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _imageLoaded = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: widget.isUser
            ? Color.fromARGB(255, 228, 206, 235)
            : Color(0xFF6FCF97),
        borderRadius: BorderRadius.circular(10),
      ),
      child: widget.imageUrl == null ? _buildWriterText() : _buildImageBubble(),
    );
  }

  Widget _buildWriterText() {
    if (widget.shouldUseTyperEffect) {
      return TypeWriterText(
        widget.text!,
        style: TextStyle(color: Colors.black),
        onChanged: widget.onChanged,
        onComplete: widget.isUser
            ? null
            : widget.onComplete, // 根据isUser的值来决定是否传递onComplete
      );
    } else {
      return Text(
        widget.text!,
        style: TextStyle(color: Colors.black),
      );
    }
  }

  Widget _buildImageBubble() {
    return GestureDetector(
      onTap: () => _showFullImage(context, widget.imageUrl!),
      child: SizedBox(
        width: 100,
        height: 100,
        child: Image.network(
          widget.imageUrl!,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              if (!_imageLoaded) {
                widget.onComplete();
                _imageLoaded = true;
              }
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            return Center(
              child: Icon(Icons.error),
            );
          },
        ),
      ),
    );
  }

  void _showFullImage(BuildContext context, String imageUrl) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors
          .black54, // Optional: You can set a semi-transparent barrier color here
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: InteractiveViewer(
            panEnabled: false,
            boundaryMargin: EdgeInsets.all(double.infinity),
            minScale: 0.1,
            maxScale: 4.0,
            clipBehavior: Clip.none,
            child: Image.network(imageUrl),
          ),
        );
      },
    );
  }
}
