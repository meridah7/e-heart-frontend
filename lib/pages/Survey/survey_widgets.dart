import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;

  const TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    List<String> parts = text.split('/'); // 以斜线分隔文本
    List<TextSpan> textSpans = parts.asMap().entries.map((entry) {
      int index = entry.key;
      String part = entry.value;
      String displayText =
          index < parts.length - 1 ? "$part\n" : part; // 仅为最后一个片段之前的片段添加换行符
      return TextSpan(
        text: displayText,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      );
    }).toList();

    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  final String text;

  const DescriptionText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    );
  }
}

class ExpandDescriptionText extends StatefulWidget {
  final String title;
  final String? expandedText;

  const ExpandDescriptionText(
    this.title, {
    this.expandedText,
    Key? key,
  }) : super(key: key);

  @override
  State<ExpandDescriptionText> createState() => _ExpandDescriptionTextState();
}

class _ExpandDescriptionTextState extends State<ExpandDescriptionText> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            if (widget.expandedText != null)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                      size: 20,
                    )
                    // child: Text(
                    //   _isExpanded ? "收起" : "展开",
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     color: Colors.blue,
                    //   ),
                    ),
              ),
          ],
        ),
        if (_isExpanded && widget.expandedText != null)
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Text(
                widget.expandedText!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomElevatedButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // foregroundColor: Colors.white, backgroundColor: Color(0xFF9D9BE9), // 设置按钮文本的颜色
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14), // 设置内边距
        textStyle: TextStyle(fontSize: 16), // 设置文本样式
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 设置边框圆角
        ),
      ),
      child: Text(text),
    );
  }
}
