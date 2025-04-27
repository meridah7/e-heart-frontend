import 'package:flutter/material.dart';
import 'package:namer_app/services/dio_client.dart';

class ErrorDisplay extends StatelessWidget {
  final dynamic error;
  final VoidCallback onRetry;
  
  const ErrorDisplay({
    Key? key, 
    required this.error,
    required this.onRetry,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    String message = '发生了错误';
    
    if (error is UserFriendlyException) {
      message = (error as UserFriendlyException).message;
    } else {
      message = error.toString();
    }
    
    return Center(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 48),
            SizedBox(height: 16),
            Text(
              '请求失败',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: Text('重试'),
            ),
          ],
        ),
      ),
    );
  }
} 