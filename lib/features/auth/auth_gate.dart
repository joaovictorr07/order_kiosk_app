import 'package:flutter/material.dart';
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
        if (controller.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
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