import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/services/dio_client.dart';
import 'package:namer_app/widgets/error_display.dart';

class ErrorHandler {
  // Extract user-friendly error message from any error
  static String getErrorMessage(dynamic error) {
    if (error is UserFriendlyException) {
      return error.message;
    } else if (error is DioException) {
      if (error.error is UserFriendlyException) {
        return (error.error as UserFriendlyException).message;
      }
      
      // Handle different DioException types
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return '请求超时，请检查网络连接';
        case DioExceptionType.badResponse:
          // Handle different HTTP status codes
          final statusCode = error.response?.statusCode;
          if (statusCode == 404) {
            return '找不到请求的资源';
          } else if (statusCode == 500) {
            return '服务器内部错误，请稍后再试';
          } else {
            return '请求失败 (HTTP $statusCode)';
          }
        case DioExceptionType.cancel:
          return '请求已取消';
        case DioExceptionType.connectionError:
          return '网络连接错误，请检查网络设置';
        default:
          return '请求失败: ${error.message}';
      }
    }
    
    // Fallback for other error types
    return error.toString();
  }
  
  // Show error dialog
  static void showErrorDialog(BuildContext context, dynamic error, {VoidCallback? onRetry}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('出错了'),
        content: Text(getErrorMessage(error)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('关闭'),
          ),
          if (onRetry != null)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onRetry();
              },
              child: Text('重试'),
            ),
        ],
      ),
    );
  }
  
  // Show error within a page using the ErrorDisplay widget
  static Widget buildErrorWidget(dynamic error, VoidCallback onRetry) {
    return ErrorDisplay(
      error: error,
      onRetry: onRetry,
    );
  }
  
  // Log error for debugging (could integrate with a logging service)
  static void logError(dynamic error, {StackTrace? stackTrace}) {
    String errorMessage = '';
    
    if (error is UserFriendlyException) {
      errorMessage = '${error.message} | Technical: ${error.technicalDetails ?? 'N/A'} | Code: ${error.errorCode ?? 'N/A'}';
    } else if (error is DioException) {
      errorMessage = 'DioError: ${error.message} | Type: ${error.type} | URL: ${error.requestOptions.path}';
    } else {
      errorMessage = error.toString();
    }
    
    print('ERROR: $errorMessage');
    if (stackTrace != null) {
      print('STACK TRACE: $stackTrace');
    }
    
    // Here you could also send the error to a logging service
  }
} 