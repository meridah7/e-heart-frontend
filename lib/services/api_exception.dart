import 'package:dio/dio.dart';

/// 自定义异常
class ApiException implements Exception {
  final String _message;
  final int _code;

  ApiException(
    this._code,
    this._message,
  );

  @override
  String toString() {
    return "$_code$_message";
  }

  String getMessage() {
    return _message;
  }

  factory ApiException.create(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        {
          return BadRequestException(-1, "请求取消");
        }
      case DioExceptionType.connectionTimeout:
        {
          return BadRequestException(-1, "连接超时");
        }
      case DioExceptionType.sendTimeout:
        {
          return BadRequestException(-1, "请求超时");
        }
      case DioExceptionType.receiveTimeout:
        {
          return BadRequestException(-1, "响应超时");
        }
      case DioExceptionType.badResponse:
        {
          try {
            int? errCode = error.response!.statusCode;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 400:
                {
                  return BadRequestException(errCode!, "请求语法错误");
                }
              case 401:
                {
                  return UnauthorisedException(errCode!, "没有权限");
                }
              case 403:
                {
                  return UnauthorisedException(errCode!, "服务器拒绝执行");
                }
              case 404:
                {
                  return UnauthorisedException(errCode!, "无法连接服务器");
                }
              case 405:
                {
                  return UnauthorisedException(errCode!, "请求方法被禁止");
                }
              case 500:
                {
                  return UnauthorisedException(errCode!, "服务器内部错误");
                }
              case 502:
                {
                  return UnauthorisedException(errCode!, "无效的请求");
                }
              case 503:
                {
                  return UnauthorisedException(errCode!, "服务器挂了");
                }
              case 505:
                {
                  return UnauthorisedException(errCode!, "不支持HTTP协议请求");
                }
              default:
                {
                  // return ErrorEntity(code: errCode, message: "未知错误");
                  return ApiException(errCode!, error.response!.statusMessage!);
                }
            }
          } on Exception catch (_) {
            return ApiException(-1, "未知错误");
          }
        }
      default:
        {
          return ApiException(-1, error.error.toString());
        }
    }
  }
}

/// 请求错误
class BadRequestException extends ApiException {
  BadRequestException(int code, String message) : super(code, message);
}

/// 未认证异常
class UnauthorisedException extends ApiException {
  UnauthorisedException(int code, String message) : super(code, message);
}
