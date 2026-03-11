import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../errors/app_exception.dart';

class ErrorPresenter {
  ErrorPresenter._();

  static Future<void> show(BuildContext context, AppException error) async {
    if (error.isServerError) {
      await _showServerErrorBottomSheet(context, error);
      return;
    }

    await _showClientErrorDialog(context, error);
  }

  static Future<void> _showClientErrorDialog(
    BuildContext context,
    AppException error,
  ) {
    return showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(error.title),
          content: Text(error.message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> _showServerErrorBottomSheet(
    BuildContext context,
    AppException error,
  ) {
    final details = _buildTechnicalDetails(error);

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Erro interno',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Text(error.message),
              const SizedBox(height: 16),
              Container(
                constraints: const BoxConstraints(maxHeight: 240),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(details),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: details));
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Detalhes copiados.'),
                            ),
                          );
                        }
                      },
                      child: const Text('Copiar detalhes'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Fechar'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static String _buildTechnicalDetails(AppException error) {
    final buffer = StringBuffer();

    buffer.writeln('statusCode: ${error.statusCode ?? '-'}');
    buffer.writeln('title: ${error.title}');
    buffer.writeln('message: ${error.message}');

    if (error.path != null && error.path!.isNotEmpty) {
      buffer.writeln('path: ${error.path}');
    }

    if (error.supportId != null && error.supportId!.isNotEmpty) {
      buffer.writeln('supportId: ${error.supportId}');
    }

    if (error.technicalDetails != null && error.technicalDetails!.isNotEmpty) {
      buffer.writeln('technicalDetails: ${error.technicalDetails}');
    }

    return buffer.toString();
  }
}