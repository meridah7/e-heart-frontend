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
