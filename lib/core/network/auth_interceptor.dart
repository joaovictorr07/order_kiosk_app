import 'package:dio/dio.dart';

typedef TokenResolver = Future<String?> Function();

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    TokenResolver? tokenResolver,
  }) : _tokenResolver = tokenResolver;

  final TokenResolver? _tokenResolver;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenResolver?.call();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
