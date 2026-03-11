import 'package:flutter/material.dart';
import 'package:order_kiosk_app/core/constants/app_assets.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_spacing.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  AppAssets.kioskIcon,
                  size: 72,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: AppSpacing.lg),

                Text(
                  AppConstants.appName,
                  style: theme.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.xl),

                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
