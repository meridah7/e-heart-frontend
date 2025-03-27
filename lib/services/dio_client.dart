// ignore_for_file: constant_identifier_names
import 'package:flutter/foundation.dart'; // 用于访问 kDebugMode
import 'package:namer_app/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:namer_app/utils/toast_util.dart';
import 'api_endpoints.dart';

class DioClient {
  late final Dio _dio;
  // Token 安全存储
  final _storage = FlutterSecureStorage();
  static final DioClient _instance = DioClient._internal();

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.BASE_URL, // 全局基础 URL
        connectTimeout: const Duration(seconds: 10), // 连接超时时间
        receiveTimeout: const Duration(seconds: 15), // 响应超时时间
        headers: {
          'Content-Type': 'application/json', // 默认请求头
        },
      ),
    );

    // 添加拦截器
    _dio.interceptors.add(_createInterceptors());
    // 添加 PrettyDioLogger 拦截器
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true, // 打印请求头
        requestBody: true, // 打印请求体
        responseHeader: false, // 不打印响应头
        responseBody: true, // 打印响应体
        error: true, // 打印错误信息
        compact: true, // 压缩日志（使其更紧凑）
        maxWidth: 90, // 日志的最大宽度
      ),
    );
  }
  // 创建拦截器
  Interceptor _createInterceptors() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        // 在请求前统一处理，比如添加 Token
        String? accessToken = await _getAccessToken();
        options.headers["Authorization"] = "Bearer $accessToken";
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        // 处理Token 存储
        final data = response.data;

        // 检查是否有 token，并存储
        if (data is Map<String, dynamic>) {
          if (data.containsKey('accessToken')) {
            await _setAccessToken(data['accessToken']);
          }
          if (data.containsKey('refreshToken')) {
            await _setRefreshToken(data['refreshToken']);
          }
        }

        return handler.next(response);
      },
      onError: (DioException exception, handler) async {
        if (exception.response?.statusCode == 401) {
          // 刷新 Token
          final isRefreshed = await _refreshAccessToken();
          if (isRefreshed) {
            final options = exception.requestOptions;
            final newToken = await _getAccessToken();
            if (newToken != null) {
              options.headers['Authorization'] = 'Bearer $newToken';
            }
            try {
              final retryResponse = await _dio.request(
                options.path,
                options: Options(
                  method: options.method,
                  headers: options.headers,
                ),
                data: options.data,
                queryParameters: options.queryParameters,
              );
              return handler.resolve(retryResponse);
            } catch (retryException) {
              return handler.next(retryException as DioException);
            }
          }
        } else if (exception.response?.statusCode == 403) {
          handleRedirectLogin();
        } else {
          // 判断是否为 debug 模式
          if (kDebugMode) {
            // 显示 Toast 提示

            ToastUtils.showToast(
              "接口请求失败：${exception.message}",
            );
          }
        }
        handler.next(exception);
      },
    );
  }

  // 刷新 Access Token
  Future<bool> _refreshAccessToken() async {
    final refreshToken = await _getRefreshToken();
    if (refreshToken == null) return false;

    try {
      final response = await postRequest(
        "/auth/refresh-token",
        {"refreshToken": refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['accessToken'];
        final newRefreshToken = response.data['refreshToken'];
        if (newAccessToken != null) {
          await _setAccessToken(newAccessToken);
        }
        if (newRefreshToken != null) {
          await _setRefreshToken(newRefreshToken);
        }
        return true;
      }
    } catch (e) {
      print("刷新 Token 失败: $e");
    }
    return false;
  }

  // 跳转到登录页面
  void handleRedirectLogin() {
    print("跳转到登录页面");
    print(navigatorKey.currentState); // 确保这里不是 null
    // 具体实现根据你的路由逻辑
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil('/login', (route) => false);
  }

  // Token 相关方法
  Future<void> storeToken(String accessToken, String refreshToken) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<void> _setAccessToken(String accessToken) async {
    await _storage.write(key: 'accessToken', value: accessToken);
  }

  Future<void> setAccessToken(String accessToken) async {
    await _storage.write(key: 'accessToken', value: accessToken);
  }

  Future<void> _setRefreshToken(String refreshToken) async {
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<String?> _getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  Future<String?> _getRefreshToken() async {
    return await _storage.read(key: 'refreshToken');
  }

  Future<void> clearTokens() async {
    await _storage.deleteAll();
  }

  // GET 请求方法
  Future<Response> getRequest(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } catch (e) {
      throw Exception('GET请求失败: $e');
    }
  }

  // POST 请求方法
  Future<Response> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      print('dio request $data');
      final response = await _dio.post(endpoint, data: data);
      print('dio POST response: $response');
      return response;
    } catch (e) {
      throw Exception('POST请求失败: $e');
    }
  }

  // PUT 请求方法
  Future<Response> putRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      print('dio PUT response: $response');
      return response;
    } catch (e) {
      throw Exception('PUT请求失败: $e');
    }
  }

  // DELETE 请求方法
  Future<Response> deleteRequest(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      print('dio DELETE response: $response');
      return response;
    } catch (e) {
      throw Exception('DELETE请求失败: $e');
    }
  }
}
