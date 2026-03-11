class AppConstants {
  AppConstants._();

  static const String appName = 'Order Kiosk';

  static const String baseUrl = 'http://10.0.2.2:8080/api';

  static const String storageAuthTokenKey = 'auth_token';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}