import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;

  const TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
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
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF9D9BE9), // 设置按钮的背景颜色
        onPrimary: Colors.white, // 设置按钮文本的颜色
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // 设置内边距
        textStyle: TextStyle(fontSize: 16), // 设置文本样式
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 设置边框圆角
        ),
      ),
    );
  }
}
