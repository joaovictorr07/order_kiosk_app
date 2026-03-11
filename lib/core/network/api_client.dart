import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:order_kiosk_app/core/constants/app_constants.dart';

import 'auth_interceptor.dart';

class ApiClient {
  ApiClient._internal()
    : dio = Dio(
        BaseOptions(
          baseUrl: AppConstants.baseUrl,
          connectTimeout: AppConstants.connectTimeout,
          receiveTimeout: AppConstants.receiveTimeout,
          headers: const {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      ) {
    dio.interceptors.add(AuthInterceptor());
    // Adiciona um interceptor para logar as requisições e respostas debug
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('REQUEST[${options.method}] => ${options.uri}');
          debugPrint('HEADERS: ${options.headers}');
          debugPrint('DATA: ${options.data}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint(
            'RESPONSE[${response.statusCode}] => ${response.requestOptions.uri}',
          );
          debugPrint('DATA: ${response.data}');
          handler.next(response);
        },
        onError: (error, handler) {
          debugPrint(
            'ERROR[${error.response?.statusCode}] => ${error.requestOptions.uri}',
          );
          debugPrint('MESSAGE: ${error.message}');
          debugPrint('DATA: ${error.response?.data}');
          handler.next(error);
        },
      ),
    );
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
