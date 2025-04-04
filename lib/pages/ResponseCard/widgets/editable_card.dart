import "package:flutter/material.dart";

class EditableCard extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onDelete;
  final Widget child;
  final VoidCallback? onTap;

  const EditableCard({
    Key? key,
    required this.isEditing,
    required this.onDelete,
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 卡片主体
        GestureDetector(
          onTap: onTap,
          child: Card(
            child: child,
          ),
        ),
        // 条件渲染删除按钮
        if (isEditing)
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ),
      ],
    );
  }
}
