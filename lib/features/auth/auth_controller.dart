import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:order_kiosk_app/core/errors/app_exception.dart';
import 'package:order_kiosk_app/core/errors/error_parser.dart';

import '../../core/storage/local_storage_service.dart';
import 'auth_service.dart';

class AuthController extends ChangeNotifier {
  AuthController({
    required AuthService authService,
    required LocalStorageService localStorageService,
  }) : _authService = authService,
       _localStorageService = localStorageService;

  final AuthService _authService;
  final LocalStorageService _localStorageService;

  bool _isLoading = false;
  bool _isBootstrapping = true;
  bool _isAuthenticated = false;
  AppException? _lastError;

 bool get isBootstrapping => _isBootstrapping;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  AppException? get lastError => _lastError;

  Future<void> bootstrap() async {
    _isBootstrapping = true;
    notifyListeners();

    try {
      final token = await _localStorageService.getAuthToken();
      _isAuthenticated = token != null && token.isNotEmpty;
      _lastError = null;
    } catch (_) {
      _isAuthenticated = false;
      _lastError = AppException(
        statusCode: null,
        title: 'Erro ao verificar autenticação local',
        message: 'Não foi possível verificar a autenticação local.',
      );
    } finally {
      _isBootstrapping = false;
      notifyListeners();
    }
  }

  Future<AppException?> login({
    required String clientId,
    required String clientSecret,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final authModel = await _authService.login(
        clientId: clientId,
        clientSecret: clientSecret,
      );

      await _localStorageService.saveAuthToken(authModel.accessToken);

      _isAuthenticated = true;
      _lastError = null;
      return null;
    } catch (e, stackTrace) {
      debugPrint('Erro ao autenticar totem: $e');
      debugPrintStack(stackTrace: stackTrace);

      _isAuthenticated = false;
      _lastError = ErrorParser.parse(e);
      return _lastError;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _localStorageService.removeAuthToken();
    _isAuthenticated = false;
    _lastError = null;
    notifyListeners();
  }

  void clearError() {
    _lastError = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
