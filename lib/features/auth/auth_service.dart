import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/network/api_client.dart';
import 'auth_model.dart';

class AuthService {
  AuthService({Dio? dio}) : _dio = dio ?? ApiClient.instance.dio;

  final Dio _dio;

  Future<AuthModel> login({
    required String clientId,
    required String clientSecret,
  }) async {
    final response = await _dio.post(
      '/auth/totem/login',
      data: {'clientId': clientId, 'clientSecret': clientSecret},
    );

    debugPrint('RESPONSE RAW TYPE: ${response.data.runtimeType}');
    debugPrint('RESPONSE RAW DATA: ${response.data}');

    return AuthModel.fromJson(response.data as Map<String, dynamic>);
  }
}
