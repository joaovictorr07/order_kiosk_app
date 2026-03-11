import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
  bool _isAuthenticated = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;

  Future<void> bootstrap() async {
    _setLoading(true);

    try {
      final token = await _localStorageService.getAuthToken();
      _isAuthenticated = token != null && token.isNotEmpty;
      _errorMessage = null;
    } catch (_) {
      _isAuthenticated = false;
      _errorMessage = 'Erro ao verificar autenticação local.';
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> login({
    required String clientId,
    required String clientSecret,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final authModel = await _authService.login(
        clientId: clientId,
        clientSecret: clientSecret,
      );

      await _localStorageService.saveAuthToken(authModel.accessToken);

      _isAuthenticated = true;
      notifyListeners();
      return true;
    } catch (e, stackTrace) {
      debugPrint('Erro ao autenticar totem: $e');
      debugPrintStack(stackTrace: stackTrace);

      if (e is DioException) {
        debugPrint('Status code: ${e.response?.statusCode}');
        debugPrint('Response data: ${e.response?.data}');
      }

      _isAuthenticated = false;
      _errorMessage = 'Não foi possível autenticar o totem.';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    await _localStorageService.removeAuthToken();
    _isAuthenticated = false;
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
