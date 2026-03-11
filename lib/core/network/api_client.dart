import 'package:dio/dio.dart';

import 'auth_interceptor.dart';

class ApiClient {
  ApiClient._internal()
      : dio = Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    dio.interceptors.add(AuthInterceptor());
  }

  static final ApiClient instance = ApiClient._internal();

  final Dio dio;

  void updateBaseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
  }

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }
}
