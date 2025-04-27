// ignore_for_file: constant_identifier_names
import 'package:flutter/foundation.dart'; // 用于访问 kDebugMode
import 'package:namer_app/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:namer_app/utils/index.dart';
import 'api_endpoints.dart';
import 'dart:async'; // 保留这个导入，用于Future
import 'package:namer_app/services/cache_service.dart';
import 'package:namer_app/services/api_analytics.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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
        // 记录请求开始时间
        options.extra['startTime'] = DateTime.now();

        // 在请求前统一处理，比如添加 Token
        String? accessToken = await _getAccessToken();
        options.headers["Authorization"] = "Bearer $accessToken";
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        // 记录API响应性能
        final startTime =
            response.requestOptions.extra['startTime'] as DateTime?;
        if (startTime != null) {
          ApiAnalytics.recordRequest(
            response.requestOptions.path,
            startTime,
            true,
            statusCode: response.statusCode,
          );
        }

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
        // Record API error (keep existing code)
        final startTime =
            exception.requestOptions.extra['startTime'] as DateTime?;
        if (startTime != null) {
          ApiAnalytics.recordRequest(
            exception.requestOptions.path,
            startTime,
            false,
            statusCode: exception.response?.statusCode,
          );
        }

        // Handle different error scenarios with user-friendly messages
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
        } else if (exception.response?.statusCode == 500) {
          // Convert 500 errors to user-friendly exceptions
          final userFriendlyException = UserFriendlyException('服务器出现错误，请稍后再试',
              technicalDetails: exception.toString(), errorCode: 500);

          // Log for debugging
          print('Server error: ${exception.message}');

          // Replace the exception with our user-friendly version
          return handler.reject(DioException(
            requestOptions: exception.requestOptions,
            error: userFriendlyException,
            type: exception.type,
            response: exception.response,
          ));
        } else if (exception.type == DioExceptionType.connectionTimeout) {
          // Handle timeout errors
          return handler.reject(DioException(
            requestOptions: exception.requestOptions,
            error: UserFriendlyException(
              '请求超时，请检查网络连接',
              technicalDetails: exception.toString(),
            ),
            type: exception.type,
            response: exception.response,
          ));
        } else {
          // Handle general errors
          if (kDebugMode) {
            ToastUtils.showToast("接口请求失败：${exception.message}");
          }

          // Convert generic errors to user-friendly ones
          return handler.reject(DioException(
            requestOptions: exception.requestOptions,
            error: UserFriendlyException(
              '请求失败，请稍后重试',
              technicalDetails: exception.toString(),
              errorCode: exception.response?.statusCode,
            ),
            type: exception.type,
            response: exception.response,
          ));
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

  bool _isOfflineMode = false;
  final _pendingRequests = <Future Function()>[];
  final _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;
  int _maxRetryAttempts = 3;

  void setupNetworkListener() {
    // Only set up the listener if it hasn't been set up already
    _connectivitySubscription ??=
        _connectivity.onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        // Network restored - process pending requests
        if (_isOfflineMode) {
          print(
              'Network connectivity restored, processing ${_pendingRequests.length} pending requests');
          _isOfflineMode = false;
          _processPendingRequests();
        }
      } else {
        print('Network connectivity lost, entering offline mode');
        _isOfflineMode = true;
      }
    });
  }

  void dispose() {
    // Safe cancellation that won't affect other instances
    if (_connectivitySubscription != null) {
      _connectivitySubscription?.cancel();
      _connectivitySubscription = null;
    }
  }

  Future<void> _processPendingRequests() async {
    final requests = List.of(_pendingRequests);
    _pendingRequests.clear();

    for (final request in requests) {
      for (int attempt = 0; attempt < _maxRetryAttempts; attempt++) {
        try {
          await request();
          // Request succeeded, break out of retry loop
          break;
        } catch (e) {
          final isLastAttempt = attempt == _maxRetryAttempts - 1;
          print(
              'Error processing pending request (attempt ${attempt + 1}/$_maxRetryAttempts): $e');

          if (isLastAttempt) {
            // If this is the last attempt, log final failure
            print('Request failed after $_maxRetryAttempts attempts');
          } else {
            // Wait before retrying (with exponential backoff)
            final delayMs = 1000 * (attempt + 1);
            print('Retrying in ${delayMs}ms...');
            await Future.delayed(Duration(milliseconds: delayMs));
          }
        }
      }
    }
  }

  Future<bool> isConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<Response> _executeWithOfflineSupport(
    Future<Response> Function() requestFunc,
    String endpoint,
    Map<String, dynamic>? data,
    bool supportOffline,
  ) async {
    // Define cachedData with explicit null type
    Map<String, dynamic>? cachedData;

    try {
      // 首先尝试从缓存获取
      final cacheService = CacheService();
      try {
        cachedData = await cacheService.getCachedResponse(endpoint);
      } catch (cacheError) {
        print('Cache retrieval error: $cacheError');
        // Ensure cachedData is null on error
        cachedData = null;
      }

      // 检查网络连接
      final isOnline = await isConnected();
      if (!isOnline) {
        // Explicitly check for null and valid cachedData
        if (cachedData != null) {
          print('使用缓存数据: $endpoint');
          return Response(
            requestOptions: RequestOptions(path: endpoint),
            data: cachedData,
            statusCode: 200,
          );
        }

        if (supportOffline) {
          print('添加离线请求到队列: $endpoint');
          // 添加到待处理队列，恢复网络后再处理
          _pendingRequests.add(() async {
            final response = await requestFunc();
            if (response.data != null) {
              await cacheService.cacheResponse(endpoint, response.data);
            }
            return response;
          });

          throw DioException(
            requestOptions: RequestOptions(path: endpoint),
            type: DioExceptionType.connectionError,
            error: '当前处于离线模式，请求已加入队列',
          );
        } else {
          throw DioException(
            requestOptions: RequestOptions(path: endpoint),
            type: DioExceptionType.connectionError,
            error: '离线模式下无法完成此操作',
          );
        }
      }

      // 在线模式，正常请求
      try {
        final response = await requestFunc();

        // 缓存响应
        if (response.statusCode == 200 && response.data != null) {
          try {
            await cacheService.cacheResponse(endpoint, response.data);
          } catch (cacheError) {
            print('Error caching response: $cacheError');
            // Continue despite caching error
          }
        }

        return response;
      } catch (e) {
        // 如果请求失败但有缓存，返回缓存
        // Double-check cachedData is valid before using
        if (cachedData != null) {
          print('请求失败，使用缓存数据: $endpoint');
          return Response(
            requestOptions: RequestOptions(path: endpoint),
            data: cachedData,
            statusCode: 200,
          );
        }
        rethrow;
      }
    } catch (e) {
      print('执行离线支持请求时出错: $e');
      rethrow;
    }
  }

  // 更新 getRequest 方法
  Future<Response> getRequest(String endpoint,
      {bool supportOffline = true}) async {
    return _executeWithOfflineSupport(
      () => _dio.get(endpoint),
      endpoint,
      null,
      supportOffline,
    );
  }

  // 更新 postRequest 方法
  Future<Response> postRequest(String endpoint, Map<String, dynamic> data,
      {bool supportOffline = false}) async {
    return _executeWithOfflineSupport(
      () => _dio.post(endpoint, data: data),
      endpoint,
      data,
      supportOffline,
    );
  }

  // PUT 请求方法
  Future<Response> putRequest(String endpoint, Map<String, dynamic> data,
      {bool supportOffline = false}) async {
    return _executeWithOfflineSupport(
      () => _dio.put(endpoint, data: data),
      endpoint,
      data,
      supportOffline,
    );
  }

  // DELETE 请求方法
  Future<Response> deleteRequest(String endpoint,
      {bool supportOffline = false}) async {
    return _executeWithOfflineSupport(
      () => _dio.delete(endpoint),
      endpoint,
      null,
      supportOffline,
    );
  }
}

// Create a user-friendly exception class
class UserFriendlyException implements Exception {
  final String message;
  final String? technicalDetails;
  final int? errorCode;

  UserFriendlyException(this.message, {this.technicalDetails, this.errorCode});

  @override
  String toString() => message;
}
