import 'package:flutter/material.dart';
import 'package:order_kiosk_app/core/utils/error_presenter.dart';
import 'package:order_kiosk_app/widgets/app_scroll_page.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_spacing.dart';
import 'auth_controller.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _clientIdController = TextEditingController();
  final _clientSecretController = TextEditingController();

  @override
  void dispose() {
    _clientIdController.dispose();
    _clientSecretController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    FocusScope.of(context).unfocus();

    final controller = context.read<AuthController>();

    final error = await controller.login(
      clientId: _clientIdController.text.trim(),
      clientSecret: _clientSecretController.text.trim(),
    );

    if (!mounted) return;

    if (error != null) {
      await ErrorPresenter.show(context, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, controller, _) {
        return AppScrollPage(
          centerContent: true,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Configurar totem',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Informe as credenciais geradas no painel para autenticar este dispositivo.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xl),
                TextFormField(
                  controller: _clientIdController,
                  enabled: !controller.isLoading,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Totem ID'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o totem ID.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _clientSecretController,
                  enabled: !controller.isLoading,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Senha do totem',
                  ),
                  onFieldSubmitted: (_) => _submit(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe a senha do totem.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: controller.isLoading ? null : _submit,
                    child: controller.isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2.2),
                          )
                        : const Text('Autenticar totem'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
