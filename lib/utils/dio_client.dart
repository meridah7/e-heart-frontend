import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
  final Dio _dio;
  // Token 安全存储
  final _storage = FlutterSecureStorage();

  // Token 相关方法
  Future<void> storeToken(String accessToken, String refreshToken) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refreshToken');
  }

  Future<void> deleteAllTokens() async {
    await _storage.deleteAll();
  }

  // 配合Dio来处理请求
  DioClient()
      : _dio = Dio(BaseOptions(
          baseUrl: 'http://121.41.30.133/api', // 设置基本URL
          connectTimeout: Duration(seconds: 5), // 连接超时
          receiveTimeout: Duration(seconds: 5), // 接收超时
        )) {
    // 拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // 请求头添加token
        String? accessToken = await getAccessToken();
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      // 响应拦截
      onResponse: (response, handler) {
        // check status code
        // TODO 这里应该配合错误码处理
        // if (response.statusCode != 200) {
        //   return handler.reject(DioException(
        //       requestOptions: response.requestOptions,
        //       response: response,
        //       type: DioExceptionType.badResponse,
        //       error: 'HTTP Error: ${response.statusCode}'));
        // }
        // 处理Token 存储
        if (response.requestOptions.path == '/auth/verifyCode') {
          var _data = response.data;
          storeToken(_data['accessToken'], _data['refreshToken']);
        }
        return handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Token expired, attempt to refresh
          String? refreshToken = await getRefreshToken();
          if (refreshToken != null) {
            try {
              // Call your refresh token endpoint
              final response = await _dio.post('/auth/refresh-token', data: {
                'refreshToken': refreshToken,
              });

              // Store the new access token
              await storeToken(response.data['accessToken'], refreshToken);

              // Retry the original request with the new access token
              error.requestOptions.headers['Authorization'] =
                  'Bearer ${response.data['accessToken']}';
              final newResponse = await _dio.fetch(error.requestOptions);
              return handler.resolve(newResponse);
            } catch (e) {
              // Handle refresh token failure (e.g., redirect to login)
            }
          }
        }
        return handler.next(error);
      },
    ));
  }

  // GET 请求方法
  Future<Response> getRequest(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      print('dio GET response: $response');
      return response;
    } catch (e) {
      throw Exception('GET请求失败: $e');
    }
  }

  // POST 请求方法
  Future<Response> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      print('dio POST response: $response');
      return response;
    } catch (e) {
      throw Exception('POST请求失败: $e');
    }
  }
}
