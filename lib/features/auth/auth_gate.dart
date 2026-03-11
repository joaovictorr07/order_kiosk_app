import 'package:flutter/material.dart';
import 'package:order_kiosk_app/features/splash/splash_page.dart';
import 'package:provider/provider.dart';

import '../home/home_page.dart';
import 'auth_controller.dart';
import 'auth_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, controller, _) {
        if (controller.isBootstrapping) {
          return const Scaffold(
            body: Center(
              child: SplashPage(),
            ),
          );
        }

        if (controller.isAuthenticated) {
          return const HomePage();
        }

        return const AuthPage();
      },
    );
  }
}