/*import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

import '../utils/network_connectivity.dart';
import '../utils/secure_storage.dart';
import 'api_endpoints.dart';

class ApiClient {
  final Dio _dio;
  final String baseUrl;

  ApiClient({required this.baseUrl}) : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {HttpHeaders.acceptHeader: 'application/json'},
    );

    _initializeInterceptors();
  }

  Future<void> _initializeInterceptors() async {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (!await NetworkInfo.isConnected) {
            return handler.reject(DioException(requestOptions: options, error: 'No internet connection'));
          }

          if (options.extra['requiresToken'] == true) {
            final token = await TokenStorage.getToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          handler.next(options);
        },

        onError: (e, handler) {
          log(e.response?.data.toString() ?? 'No response body');
          if (e.response?.statusCode == 401) {
            TokenStorage.clear();
            // optional: force logout navigation
          }
          handler.next(e);
        },
      ),
    );
  }

  // =====================
  // OAUTH LOGIN
  // =====================

  Future<Response> login({required String username, required String password}) {
    return _dio.post(
      ApiEndPoints.login,
      data: {'username': username, 'password': password},
      options: Options(contentType: Headers.formUrlEncodedContentType, extra: {'requiresToken': false}),
    );
  }

  // =====================
  // STANDARD API METHODS
  // =====================

  Future<Response> get(String endpoint, {Map<String, dynamic>? query, bool requiresToken = false}) {
    return _dio.get(endpoint, queryParameters: query, options: Options(extra: {'requiresToken': requiresToken}));
  }

  Future<Response> post(String endpoint, {dynamic body, bool requiresToken = false}) {
    return _dio.post(endpoint, data: body, options: Options(extra: {'requiresToken': requiresToken}));
  }

  Future<Response> postWithFiles(String endpoint, {dynamic body, bool requiresToken = false}) {
    return _dio.post(endpoint, data: FormData.fromMap(body), options: Options(extra: {'requiresToken': requiresToken}));
  }

  Future<Response> put(String endpoint, {dynamic body, bool requiresToken = true}) {
    return _dio.put(endpoint, data: body, options: Options(extra: {'requiresToken': requiresToken}));
  }

  Future<Response> delete(String endpoint, {bool requiresToken = true}) {
    return _dio.delete(endpoint, options: Options(extra: {'requiresToken': requiresToken}));
  }
}*/
