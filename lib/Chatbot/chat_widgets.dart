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

  TypeWriterText(this.text,
      {this.style,
      this.duration = const Duration(milliseconds: 50),
      this.onComplete});

  @override
  _TypeWriterTextState createState() => _TypeWriterTextState();
}

class _TypeWriterTextState extends State<TypeWriterText>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
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
      Future.delayed(widget.duration, _displayNextCharacter);
    } else {
      if (widget.onComplete != null) {
        widget.onComplete!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
  final VoidCallback onComplete;

  Bubble({
    this.text,
    this.imageUrl,
    required this.isUser,
    required this.onComplete,
  });

  @override
  _BubbleState createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  bool _isImageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: widget.isUser
            ? Color.fromARGB(255, 228, 206, 235)
            : Color(0xFF6FCF97),
        borderRadius: BorderRadius.circular(10),
      ),
      child: widget.imageUrl == null
          ? TypeWriterText(
              widget.text!,
              style: TextStyle(color: Colors.black),
              onComplete: widget.isUser
                  ? null
                  : widget.onComplete, // 根据isUser的值来决定是否传递onComplete
            )
          : GestureDetector(
              onTap: () => _showFullImage(context, widget.imageUrl!),
              child: _isImageLoaded
                  ? Image.asset(widget.imageUrl!)
                  : CircularProgressIndicator(),
            ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.imageUrl != null && !widget.isUser) {
      // 只有当isUser为false时才调用onComplete
      // 加载图片，并在加载完毕后设置 _isImageLoaded 为 true 并调用 onComplete
      precacheImage(AssetImage(widget.imageUrl!), context).then((_) {
        setState(() {
          _isImageLoaded = true;
        });
        widget.onComplete();
      });
    }
  }

  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: InteractiveViewer(
            panEnabled: true, // 允许平移
            boundaryMargin: EdgeInsets.zero, // 设置边界留白为零
            minScale: 0.1, // 最小缩放比例
            maxScale: 4.0, // 最大缩放比例，可以根据需要调整
            child: Image.asset(imageUrl),
          ),
        );
      },
    );
  }
}
