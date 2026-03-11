import 'package:flutter/material.dart';
import 'package:order_kiosk_app/core/storage/local_storage_service.dart';
import 'package:order_kiosk_app/core/theme/app_theme.dart';
import 'package:order_kiosk_app/features/auth/auth_controller.dart';
import 'package:order_kiosk_app/features/auth/auth_gate.dart';
import 'package:order_kiosk_app/features/auth/auth_service.dart';
import 'package:order_kiosk_app/features/home/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localStorageService = await LocalStorageService.getInstance();

  runApp(OrderKioskApp(localStorageService: localStorageService));
}
class OrderKioskApp extends StatelessWidget {
  const OrderKioskApp({super.key, required this.localStorageService});

  final LocalStorageService localStorageService;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthController(
            authService: AuthService(),
            localStorageService: localStorageService,
          )..bootstrap(),
        ),
      ],
      child: MaterialApp(
        title: 'Order Kiosk',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const AuthGate(),
      ),
    );
  }
}
