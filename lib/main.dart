import 'package:flutter/material.dart';
import 'package:order_kiosk_app/core/theme/app_theme.dart';
import 'package:order_kiosk_app/features/home/home_page.dart';

void main() {
  runApp(const OrderKioskApp());
}

class OrderKioskApp extends StatelessWidget {
  const OrderKioskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Kiosk',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const HomePage(),
    );
  }
}
